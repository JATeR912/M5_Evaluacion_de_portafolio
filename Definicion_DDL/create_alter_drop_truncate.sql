--Implementar estructuras de datos relacionales utilizando lenguaje de definición de datos 
--(DDL) a partir de un modelo de datos para la creación y mantención de las definiciones de 
--los objetos de una base de datos.
Utilizar el lenguaje DDL para crear, modificar y eliminar tablas, índices y otros objetos dentro de una 
base de datos.



-- IMPORTANTE: EJECUTAR ESTE SCRIPT AL FINALIZAR REVISIÓN YA QUE MODIFICA ESTRUCTURAS CREADAS EN OTROS SCRIPTS
-- Script para futura evolucion de la base de datos, eliminando la tabla modulos(durante bootcamp) y creando una nueva tabla categorias (para cuando no se puedan vincular proyectos a modulos)

-- Crear tabla para cuando no se necesiten modulos
CREATE TABLE IF NOT EXISTS categorias(
  id_categorias INT AUTO_INCREMENT PRIMARY KEY,
  nombre_categoria VARCHAR(100) NOT NULL,
  descripcion_categoria TEXT NOT NULL,
  orden_categoria INT NOT NULL
);

-- Insertar datos de prueba en tabla categorias
INSERT INTO categorias (nombre_categoria, descripcion_categoria, orden_categoria) VALUES
('Desarrollo Web', 'Desarrollo de sitios y aplicaciones web.', 10);


-- SET FOREIGN_KEY_CHECKS -- Desactivar temporalmente y activar luego las comprobaciones de claves foráneas
SET FOREIGN_KEY_CHECKS = 0;

-- Modificar tabla proyectos para agregar columna id_categoria
ALTER TABLE proyectos
  ADD COLUMN id_categoria INT AFTER id_modulo,
  ADD FOREIGN KEY (id_categoria) REFERENCES categorias(id_categorias);

ALTER TABLE proyectos
  ADD CONSTRAINT chk_modulo_o_categoria
  CHECK (id_modulo IS NOT NULL OR id_categoria IS NOT NULL);

SET FOREIGN_KEY_CHECKS = 1;
-- SET FOREIGN_KEY_CHECKS -- Desactivar temporalmente y activar luego las comprobaciones de claves foráneas



-- SET FOREIGN_KEY_CHECKS -- Desactivar temporalmente y activar luego las comprobaciones de claves foráneas
SET FOREIGN_KEY_CHECKS = 0;

-- Eliminar restricción CHECK chk_modulo_o_categoria si ya no es necesario vincular proyectos a modulos
ALTER TABLE proyectos 
DROP CHECK chk_modulo_o_categoria;

-- Eliminar columna id_modulo de tabla proyectos cuando ya no se necesite
ALTER TABLE proyectos
  DROP COLUMN id_modulo;

-- Truncar tabla categorias si es necesario
TRUNCATE TABLE modulos;

-- Eliminar tabla modulos si ya no es necesaria
DROP TABLE IF EXISTS modulos;

SET FOREIGN_KEY_CHECKS = 1;
-- SET FOREIGN_KEY_CHECKS -- Desactivar temporalmente y activar luego las comprobaciones de claves foráneas