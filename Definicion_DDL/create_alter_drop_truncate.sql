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

