--Insertar un nuevo dato.
INSERT INTO programas (nombre_programa, tipo_programa) VALUES
('Django', 'Framework Python'),
('PSeInt', 'Herramienta educativa para aprender fundamentos de programacion');

--Actualizar el tipo de programa de un programa.
UPDATE programas
SET tipo_programa = 'Sistema de control de versiones'
WHERE nombre_programa = 'GitHub';

--Actualizar estado de un proyecto de "En progreso" a "Terminado".
UPDATE proyectos
SET estado_proyecto = 'Terminado'
WHERE id_proyecto = 2 AND estado_proyecto = 'En progreso';

--Insertar un nuevo programa para borrar.
INSERT INTO programas (nombre_programa, tipo_programa) VALUES
('GitLab', 'Plataforma de alojamiento de código');
DELETE FROM programas
WHERE nombre_programa = 'GitLab';
