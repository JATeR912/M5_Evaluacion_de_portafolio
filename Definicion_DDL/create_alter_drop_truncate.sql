--Implementar estructuras de datos relacionales utilizando lenguaje de definición de datos 
--(DDL) a partir de un modelo de datos para la creación y mantención de las definiciones de 
--los objetos de una base de datos.
Utilizar el lenguaje DDL para crear, modificar y eliminar tablas, índices y otros objetos dentro de una 
base de datos.

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

SET FOREIGN_KEY_CHECKS = 0;

-- Modificar tabla proyectos para agregar columna id_categoria
ALTER TABLE proyectos
  ADD COLUMN id_categoria INT AFTER id_modulo,
  ADD FOREIGN KEY (id_categoria) REFERENCES categorias(id_categorias);

-- Eliminar columna id_modulo de tabla proyectos
ALTER TABLE proyectos
  DROP COLUMN id_modulo;

-- Truncar tabla categorias
TRUNCATE TABLE modulos;

-- Eliminar tabla modulos si ya no es necesaria
DROP TABLE IF EXISTS modulos;

SET FOREIGN_KEY_CHECKS = 1;
-- SET FOREIGN_KEY_CHECKS -- Desactivar temporalmente y activar luego las comprobaciones de claves foráneas