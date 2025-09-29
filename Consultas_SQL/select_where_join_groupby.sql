-- Consulta para obtener el número de proyectos terminados por módulo.
SELECT id_modulo, nombre_modulo, COUNT(id_proyectos) AS total_proyectos
FROM modulos
JOIN proyectos ON modulos.id_modulo = proyectos.id_modulo
WHERE estado_proyecto = 'Terminado'
GROUP BY id_modulo, nombre_modulo;

-- Consulta para obtener los programas asociados a cada proyecto.
SELECT p.nombre_proyecto, pr.nombre_programa
FROM proyectos p
JOIN proyectos_programas pp ON p.id_proyectos = pp.id_proyectos
JOIN programas pr ON pr.id_programa = pp.id_programa;

-- Consulta para obtener nombres de modulos y proyectos con estado 'En progreso'.
SELECT m.nombre_modulo, p.nombre_proyecto
FROM modulos m
JOIN proyectos p ON m.id_modulo = p.id_modulo
WHERE p.estado_proyecto = 'En progreso';
