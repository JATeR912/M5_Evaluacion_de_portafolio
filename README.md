# Base de Datos - Registro de Proyectos del Portafolio

    Este repositorio contiene la estructura y lógica de una base de datos relacional diseñada para registrar y gestionar proyectos personales realizados durante una formación bootcamp en desarrollo de software.

## Propósito

    El objetivo de esta base de datos es:

        - Almacenar información de proyectos desarrollados.
        - Vincular cada proyecto con los programas (tecnologías/herramientas) utilizados.
        - Relacionar los proyectos con un módulo de estudio o categoría temática.
        - Registrar avances mediante estados de proyecto (Ej: Terminado, En progreso, Pendiente, etc.).

            Además, el repositorio incluye procedimientos almacenados como **funcionalidades extra** que automatizan ciertas tareas comunes como insertar proyectos y asociarlos con programas existentes.


## Estructura General

    Las principales tablas creadas son:

        - `modulos`: Representa los módulos del bootcamp.
        - `programas`: Tecnologías, herramientas o lenguajes utilizados en los proyectos.
        - `proyectos`: Información clave de cada proyecto.
        - `proyectos_programas`: Tabla intermedia para relación muchos a muchos entre proyectos y programas.
        - `categorias`: (opcional) Permite clasificar proyectos que no estén asociados a un módulo específico.


## Archivos incluidos

    Los scripts están organizados en diferentes secciones que puedes ejecutar de forma secuencial:

        - `Tablastablas_portafolio.sql`  Creación de base de datos, tablas principales, relaciones.  
        - `Tablas/datos_tablas.sql`   Inserción de datos de ejemplo.  
        - `Consultas_SQLselect_where_join_groupby.sql`   Consultas para explorar los datos.  
        - `Definicion_DDL/create_alter_drop_truncate.sql`   Opcional: crea la tabla `categorias` para proyectos fuera del bootcamp.Modifica estructura.
        - `Manipulacion_DML/insert_update_delete.sql`   Consultas DML: insertar, actualizar y eliminar registros. 
        - `Extra_TCL/commit_rollback.sql`   Procedimientos almacenados que automatizan la lógica de inserción y validación. 


## Pasos para ejecutar y verificar

    Sigue este orden para ejecutar correctamente los archivos:

        1. **Crear la base y las tablas:**
        - Ejecuta `Tablastablas_portafolio.sql`

        2. **Insertar los datos de prueba:**
        - Ejecuta `Tablas/datos_tablas.sql`

        3. **Consultar la base de datos:**
        - Ejecuta `Consultas_SQLselect_where_join_groupby.sql` para probar consultas de ejemplo.

        4. **Modificar registros:**
        - Ejecuta `Manipulacion_DML/insert_update_delete.sql` si deseas probar inserciones, actualizaciones o eliminaciones.

        5. **⚠️ Evolución con Categorías (Opcional):**
        - Ejecuta `Definicion_DDL/create_alter_drop_truncate.sql` **solo al final**, cuando decidas reemplazar `modulos` por `categorias`.
        - Este script modifica la estructura y **elimina la tabla `modulos`**, así que úsalo solo si ya no necesitas esa tabla.

        6. **Ejecutar procedimientos (opcional):**
        - Ejecuta `Extra_TCL/commit_rollback.sql` para crear procedimientos almacenados.
        - Luego puedes llamarlos con `CALL nombre_procedimiento(...)`.


## Consideraciones 

    - El proyecto está diseñado para ser **escalable y evolutivo**. Se puede usar tanto durante el bootcamp (con módulos) como posteriormente (con categorías).
    - Los **procedimientos almacenados** son extras que demuestran el uso de **TCL (Transacción Control Language)** y ayudan a mantener la integridad de los datos.
    - Se implementan **restricciones CHECK y claves foráneas** para asegurar la consistencia de los datos.
