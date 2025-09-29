--Insertar datos tabla modulos.
INSERT INTO modulos (nombre_modulo, descripcion_modulo, orden_modulo) VALUES
('Orientación al perfil y metodología del curso','Aplicar las competencias del perfil laboral y la metodología bootcamp en el contexto de la industria TI.',1),
('Fundamentos del desarrollo Front-End','Desarrollar páginas web básicas responsivas utilizando html, css y javascript de acuerdo a los requerimientos y acorde a las buenas prácticas de la industria.',2),
('Fundamentos de programación en Python','Codificar piezas de software de baja complejidad utilizando lenguaje Python para resolver problemáticas comunes de acuerdo a las necesidades de la industria.',3),
('Programación avanzada en Python','Codificar piezas de software de mediana complejidad en lenguaje Python utilizando paradigmas de orientación a objetos para resolver problemáticas de acuerdo a las necesidades de la organización.',4);

--Insertar datos tabla programas.
INSERT INTO programas (nombre_programa, tipo_programa) VALUES
('HTML','Lenguaje de marcado'),
('CSS','Lenguaje de estilos'),
('Bootstrap','Framework de CSS y JS'),
('JQuery','Librería de JavaScript'),
('JavaScript','Lenguaje de programación'),
('GitHub','Plataforma de alojamiento de código'),
('Python','Lenguaje de programación'),
('Drawio','Herramienta de diagramación en línea'),
('ERD Editor','Herramienta de modelado de diagramas');

--Insertar datos tabla proyectos.
INSERT INTO proyectos (nombre_proyecto, descripcion_proyecto, fecha_creacion, url_repositorio, estado_proyecto, id_modulo) VALUES
('AutoFix','Página web en HTML básica, que incluye formulario y tarjetas, responsiva y manejo de versiones.','2025-06-30','https://github.com/JATeR912/github_autoflixlosdivtasticos','Terminado',2),
('Descuentos','Programa en Python que calcula descuentos y precios finales según el monto de la compra.','2025-07-15','https://github.com/JATeR912/descuentos','En progreso',3);

--Insertar datos tabla proyectos_programas.
INSERT INTO proyectos_programas (id_proyectos, id_programa) VALUES
(1,1),
(1,2),
(1,3),
(1,5),
(1,6),
(2,8),
(2,7),
(2,6);
