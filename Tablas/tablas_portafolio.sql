--Base de datos: borrar base en caso de que exista y crearla.
DROP DATABASE IF EXISTS proyectos_portafolio; 
CREATE DATABASE IF NOT EXISTS proyectos_portafolio;
USE proyectos_portafolio;

-- Tabla: modulos.
CREATE TABLE modulos (
  id_modulo INT AUTO_INCREMENT PRIMARY KEY,
  nombre_modulo VARCHAR(100) NOT NULL,
  descripcion_modulo TEXT NOT NULL,
  orden_modulo INT NOT NULL
);

-- Tabla: programas.
CREATE TABLE programas (
  id_programa INT AUTO_INCREMENT PRIMARY KEY,
  nombre_programa VARCHAR(50) NOT NULL,
  tipo_programa VARCHAR(50) NOT NULL
);

-- Tabla: proyectos.
CREATE TABLE proyectos (
  id_proyectos INT AUTO_INCREMENT PRIMARY KEY,
  nombre_proyecto VARCHAR(100) NOT NULL,
  descripcion_proyecto TEXT NOT NULL,
  fecha_creacion DATE NOT NULL,
  url_repositorio VARCHAR(255) NOT NULL,
  estado_proyecto ENUM('En progreso', 'Terminado', 'Pendiente', 'Cancelado', 'En pausa') DEFAULT 'Pendiente',
  id_modulo INT NOT NULL,
  FOREIGN KEY (id_modulo) REFERENCES modulos(id_modulo)
);

-- Tabla union: proyectos_programas (relación muchos a muchos).
CREATE TABLE proyectos_programas (
  id_proyectos INT NOT NULL,
  id_programa INT NOT NULL,
  PRIMARY KEY (id_proyectos,id_programa),
  FOREIGN KEY (id_proyectos) REFERENCES proyectos(id_proyectos) ON DELETE CASCADE,
  FOREIGN KEY (id_programa) REFERENCES programas(id_programa) ON DELETE CASCADE
);

ALTER TABLE modulos
  ADD CONSTRAINT UQ_nombre_modulo UNIQUE (nombre_modulo);

ALTER TABLE programas
  ADD CONSTRAINT UQ_nombre_programa UNIQUE (nombre_programa);

ALTER TABLE proyectos
  ADD CONSTRAINT UQ_nombre_proyecto UNIQUE (nombre_proyecto);