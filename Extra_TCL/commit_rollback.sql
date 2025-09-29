--Transacciones y procedimientos almacenados (TCL)

-----PROCEDIMIENTO AGREGAR PROYECTO-----
DELIMITER $$
CREATE PROCEDURE agregar_proyecto(
  IN p_nombre_proyecto      VARCHAR(100),
  IN p_descripcion_proyecto TEXT,
  IN p_fecha_creacion       DATE,
  IN p_url_repositorio      VARCHAR(255),
  IN p_id_modulo            INT,
  IN p_estado_proyecto      VARCHAR(20),
  IN p_nombre_programa      VARCHAR(50)
)
BEGIN
  DECLARE v_existe_nombre_proyecto INT DEFAULT 0;
  DECLARE v_existe_modulo INT DEFAULT 0;
  DECLARE v_id_programa INT;
  DECLARE v_estado_final ENUM('En progreso', 'Terminado', 'Pendiente', 'Cancelado', 'En pausa');
  DECLARE v_id_proyecto INT;

  -- Iniciar transacción
  START TRANSACTION;

  -- Verificar que el proyecto no exista
  SELECT COUNT(*) INTO v_existe_nombre_proyecto
  FROM proyectos
  WHERE nombre_proyecto = p_nombre_proyecto;

  IF v_existe_nombre_proyecto > 0 THEN
    ROLLBACK;
    SELECT 'ERROR: Ya existe un proyecto con ese nombre' AS estado;
    LEAVE agregar_proyecto_y_programa;
  END IF;

  -- Verificar que el módulo exista
  SELECT COUNT(*) INTO v_existe_modulo
  FROM modulos
  WHERE id_modulo = p_id_modulo;

  IF v_existe_modulo = 0 THEN
    ROLLBACK;
    SELECT 'ERROR: El módulo indicado no existe' AS estado;
    LEAVE agregar_proyecto_y_programa;
  END IF;

  -- Verificar que la URL comience con https://
  IF NOT (p_url_repositorio LIKE 'https://%') THEN
    ROLLBACK;
    SELECT 'ERROR: La URL debe comenzar con https://' AS estado;
    LEAVE agregar_proyecto_y_programa;
  END IF;

  -- Validar que la fecha no sea futura
  IF p_fecha_creacion > CURDATE() THEN
    ROLLBACK;
    SELECT CONCAT('ERROR: La fecha no puede ser futura. Hoy es ', CURDATE()) AS estado;
    LEAVE agregar_proyecto_y_programa;
  END IF;

  -- Verificar que el programa exista
  SELECT id_programa INTO v_id_programa
  FROM programas
  WHERE nombre_programa = p_nombre_programa;

  IF v_id_programa IS NULL THEN
    ROLLBACK;
    SELECT 'ERROR: El programa no existe. Debe crearse primero.' AS estado;
    LEAVE agregar_proyecto_y_programa;
  END IF;

  -- Validar estado
  IF p_estado_proyecto IN ('En progreso', 'Terminado', 'Pendiente', 'Cancelado', 'En pausa') THEN
    SET v_estado_final = p_estado_proyecto;
  ELSE
    SET v_estado_final = 'Pendiente';
  END IF;

  -- Insertar el proyecto
  INSERT INTO proyectos (
    nombre_proyecto,
    descripcion_proyecto,
    fecha_creacion,
    url_repositorio,
    estado_proyecto,
    id_modulo
  ) VALUES (
    p_nombre_proyecto,
    p_descripcion_proyecto,
    p_fecha_creacion,
    p_url_repositorio,
    v_estado_final,
    p_id_modulo
  );

  SET v_id_proyecto = LAST_INSERT_ID();

  -- Insertar la relación en proyectos_programas
  INSERT INTO proyectos_programas(id_proyectos, id_programa)
  VALUES (v_id_proyecto, v_id_programa);

  -- Si todo fue bien, confirmar los cambios
  COMMIT;

  SELECT 'OK: Proyecto creado y asociado a programa existente correctamente' AS estado;
END $$ 



-----PROCEDIMIENTO AGREGAR MODULO-----
CREATE PROCEDURE verificar_o_agregar_modulo(
  IN p_nombre_modulo VARCHAR(100),
  IN p_descripcion_modulo TEXT,
  IN p_orden_modulo INT
)
BEGIN
  DECLARE v_id_modulo INT;

  -- Iniciar transacción
  START TRANSACTION;

  SELECT id_modulo INTO v_id_modulo
  FROM modulos
  WHERE nombre_modulo = p_nombre_modulo;

  -- Verificar existencia del módulo, si no existe, agregarlo
  IF v_id_modulo IS NOT NULL THEN
    ROLLBACK;
    SELECT 'AVISO: El módulo ya existe.' AS estado;
  ELSE
    INSERT INTO modulos(nombre_modulo, descripcion_modulo, orden_modulo)
    VALUES (p_nombre_modulo, p_descripcion_modulo, p_orden_modulo);
    COMMIT;
    SELECT 'OK: Módulo agregado correctamente.' AS estado;
  END IF;
END$$



-----PROCEDIMIENTO AGREGAR PROGRAMA-----
CREATE PROCEDURE verificar_o_agregar_programa(
  IN p_nombre_programa VARCHAR(50),
  IN p_tipo_programa VARCHAR(50)
)
BEGIN
  DECLARE v_id_programa INT;

  -- Iniciar transaccion
  START TRANSACTION;

  SELECT id_programa INTO v_id_programa
  FROM programas
  WHERE nombre_programa = p_nombre_programa AND tipo_programa = p_tipo_programa;

  -- Verificar existencia del programa, si no existe, agregarlo
  IF v_id_programa IS NOT NULL THEN
    ROLLBACK;
    SELECT 'AVISO: El programa ya existe.' AS estado;
  ELSE
    INSERT INTO programas(nombre_programa, tipo_programa)
    VALUES (p_nombre_programa, p_tipo_programa);
    COMMIT;
    SELECT 'OK: Programa agregado correctamente.' AS estado;
  END IF;
END$$



-----PROCEDIMIENTO AGREGAR PROGRAMA A PROYECTO EXISTENTE-----
CREATE PROCEDURE agregar_programa_a_proyecto_existente(
  IN p_nombre_proyecto VARCHAR(100),
  IN p_nombre_programa VARCHAR(50),
  IN p_tipo_programa VARCHAR(50)
)
BEGIN
  DECLARE v_id_proyecto INT;
  DECLARE v_id_programa INT;
  DECLARE v_existencia_relacion INT;

  -- Iniciar transacción
  START TRANSACTION;

  -- Verificar existencia del proyecto
  SELECT id_proyectos INTO v_id_proyecto
  FROM proyectos
  WHERE nombre_proyecto = p_nombre_proyecto;

  IF v_id_proyecto IS NULL THEN
    ROLLBACK;
    SELECT 'ERROR: El proyecto no existe' AS estado;
    LEAVE agregar_programa_a_proyecto_existente;
  END IF;

  -- Verificar existencia del programa
  SELECT id_programa INTO v_id_programa
  FROM programas
  WHERE nombre_programa = p_nombre_programa AND tipo_programa = p_tipo_programa;

  IF v_id_programa IS NULL THEN
    ROLLBACK;
    SELECT 'ERROR: El programa no existe' AS estado;
    LEAVE agregar_programa_a_proyecto_existente;
  END IF;

  -- Verificar si ya existe la relación
  SELECT COUNT(*) INTO v_existencia_relacion
  FROM proyectos_programas
  WHERE id_proyectos = v_id_proyecto AND id_programa = v_id_programa;

  IF v_existencia_relacion > 0 THEN
    ROLLBACK;
    SELECT 'AVISO: El programa ya está asociado al proyecto' AS estado;
    LEAVE agregar_programa_a_proyecto_existente;
  END IF;

  -- Crear la relación
  INSERT INTO proyectos_programas(id_proyectos, id_programa)
  VALUES (v_id_proyecto, v_id_programa);

  -- Confirmar
  COMMIT;
  SELECT 'OK: Programa asociado al proyecto correctamente' AS estado;
END $$
DELIMITER ;

-- Llamar al procedimiento para agregar un proyecto (nombre, descripción, fecha, url, id_modulo, estado y programa)
CALL agregar_proyecto(
  'Sistema de Gestión de Tareas',
  'Aplicación para gestionar tareas diarias',
  '2025-08-10',
  'https://github.com/usuario/sistema-gestion-tareas',
  3,
  'En progreso',
  'Python'
);

-- Llamar al procedimiento para agregar un proyecto a programa existente (proyecto,programa y descripción del programa)
CALL agregar_programa_a_proyecto_existente(
  'Descuentos',
  'ERD Editor',
  'Herramienta de modelado de diagramas',
);

-- Llamar al procedimiento para verificar o agregar un módulo (nombre, descripción y orden)
CALL verificar_o_agregar_modulo(
  'Fundamentos de bases de datos relacionales',
  'Operar una base de datos relacional utilizando el lenguaje SQL para la obtención, manipulación y definición de datos dando solución a un problema de almacenamiento de información.',
  5
);

-- Llamar al procedimiento para verificar o agregar un programa (nombre y descripción)
CALL verificar_o_agregar_programa(
  'SQL',
  'Lenguaje de programación para bases de datos'
);
