-- 1) DDL DML 
--b)
ALTER TABLE ejemplar ADD COLUMN anio_edicion date;

-- c)
ALTER TABLE socio ADD COLUMN domicilio varchar(100);

-- d)
UPDATE socio
SET monto_cuota = monto_cuota + 10

-- e)

UPDATE socio
SET pais = 'Mexico'
WHERE nombre_y_apellido = 'Amy Farrah Fowler'


INSERT INTO nacionalidad (nombre_pais, nacionalidad) VALUES ('Colombia', 'Colombian'); 

UPDATE socio
SET pais = 'Colombia'
WHERE nombre_y_apellido = 'Howard Wolowitz'

--f)
 
DELETE FROM nacionalidad
WHERE nombre_pais = 'Peru'

-- g)

ALTER TABLE prestamo 
DELETE CONSTRAINT fk_cod_ejemplar
ADD CONSTRAINT fk_cod_ejemplar FOREIGN KEY
ON DELETE CASCADE;

DELETE FROM ejemplar
WHERE edicion = 3;


-- 2) DML

-- II) En ar el resultado es sin repetidos. En SQL devuelve valores repetidos.
-- 
-- III)  
-- a) SELECT r1 FROM R:
--     El resultado de esta operación sería una tabla con un solo atributo (columna) llamado "r1". El esquema de la tabla resultante sería: R' = <r1>.
-- 
-- b) SELECT r1, r2 FROM R:
--     El resultado de esta operación sería una tabla con dos atributos (columnas) llamados "r1" y "r2". El esquema de la tabla resultante sería: R' = <r1, r2>.

-- IV) SELECT nombre_y_apellido FROM socio;


-- 2c)


-- I) 
/* 

SELECT fecha_prestamo, fecha_devolucion,
EXTRACT ( 
    DAY FROM
    (
    fecha_devolucion
          -
    fecha_prestamo 
    ) 
    )AS duracion_en_dias
FROM prestamo;

*/

-- II)

SELECT monto_cuota, matricula,
    (
    matricula
          +
    (monto_cuota * 12 )
    ) 
    AS montoAnual
FROM socio;

-- 2d)


-- a) Devuelve la columna de cod_socio de la relacion prestamo donde la fecha del prestamo sea mayor a 31/01/2012 
-- b) Devuelve la columna de cod_ejemplar de la relacion prestamo donde la fecha del prestamo sea mayor a 31/01/2012 
-- c) En este caso, el resultado tiene una condicion marcada por la palabra clave WHERE.


-- II)


/* 
    En el a y b, se hace una "proyeccion"
    de las columnas de R, Pero a partir de una expresion condicional despues del WHERE.
    En estos casos, donde rn < r2.

*/


--III)

SELECT isbn_libro FROM ejemplar WHERE edicion = 3 OR edicion = 2



-- 2.e) Join Natural

-- I) Realizan la operacion del JOIN natural entre las dos tablas.
-- II) No tiene sentido, ya que la operacion ñ
-- III) Deben tener un atributo en comun. Se genera una relacion resultante a partir dela union de dos tablas.
-- IV) Que hayan atributos en comun. Que la condicion B sea sobre atributos y valores existentes en la nueva relacion creada en el JOIN.
-- V) 

    ALTER TABLE ejemplar
    RENAME COLUMN isbn_libro TO isbn;

    SELECT DISTINCT titulo FROM libro NATURAL JOIN ejemplar WHERE edicion = 2 OR edicion = 3; 

-- b)

-- 2. EJERCICIOS INTEGRADORES 

-- trabajador <legajo, nombre, tarifa, oficio, legajo_supv>
-- edificio <id_e, dir, tipo, nivel_calidad, categoria>
-- asignacion <legajo, id_e, fecha_inicio, num_dias>


--1. DDL/DML
--(a) Modifique la relación trabajador agregando la edad del mismo.
--(b) Modifique la relación edificio agregando un atributo que permita guardar la ciudad del edificio.
--(c) Actualice la relación asignaciones incrementando en 4 los números de dias en las asignaciones.
--(d) Actualice el nivel de calidad de los edificios que son oficinas cambiando 4 por 5 y la categoría de 1 por 4.
--(e) Elimine todos los plomeros.
--(f) Elimine los edificios que son residencias

-- DML

--(a) Nombre de los trabajadores cuya tarifa está entre 10 y 12 pesos.
--(b) Cuáles son los oficios de los trabajadores asignados al edificio 435?
--(c) Indicar el nombre del trabajador y el de su supervisor.
--(d) Nombre de los trabajadores asignados a oficinas.
--(e) Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor?
--(f) Cuál es el número total de días que se han dedicado a plomería en el edificio 312?
--(g) Cuántos tipos de oficios diferentes hay?
--(h) Para cada supervisor, cuál es la tarifa por hora más alta que se paga a un trabajador que informa a ese supervisor?
--(i) Para cada supervisor que supervisa a más de un trabajador, cuál es la tarifa más alta
--que se paga a un trabajador que informa a ese supervisor?
--(j) Para cada tipo de edificio, cuál es el nivel de calidad medio de los edificios con cate-
--goría 1? Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad
--máximo no mayor que 3.
--(k) Qué trabajadores reciben una tarifa por hora menor que la del promedio?
--(l) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los traba-
--jadores que tienen su mismo oficio?
--(m) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los traba-
--jadores que dependen del mismo supervisor que él?
--(n) Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que
--empezaron a trabajar en él.
--(ñ) Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de los
--12 euros

-- DDL / DML

-- a)

ALTER TABLE trabajador ADD COLUMN edad int;

 --b) 

ALTER TABLE trabajador DROP COLUMN ciudad;

--c)
UPDATE asignaciones
SET num_dias = num_dias + 4;

--d)

/*
UPDATE (SELECT * FROM edificio WHERE tipo = oficina) 
SET nivel_calidad = 5
WHERE nivel_calidad =  4
*/

UPDATE edificio
SET categoria     = 4
WHERE categoria   = 1 AND tipo = 'oficina';


UPDATE edificio
SET   nivel_calidad     = 5
WHERE nivel_calidad   = 4 AND tipo = 'oficina';

--(e) Elimine todos los plomeros.

ALTER TABLE asignacion
DROP CONSTRAINT fk_legajo;

ALTER TABLE asignacion
ADD CONSTRAINT fk_nuevo_legajo FOREIGN KEY (legajo) REFERENCES trabajador (legajo)ON DELETE CASCADE;


DELETE FROM trabajador
WHERE oficio = 'plomero';

--(f) Elimine los edificios que son residencias
ALTER TABLE asignacion
DROP CONSTRAINT fk_id_e;

ALTER TABLE asignacion
ADD CONSTRAINT fk_nuevo_idE FOREIGN KEY (id_e) REFERENCES edificio (id_e)ON DELETE CASCADE;

DELETE FROM edificio
WHERE tipo = 'residencia';
 
--DML: Resolver las siguientes consultas usando SQL

-- (a) Nombre de los trabajadores cuya tarifa está entre 10 y 12 pesos

SELECT nombre FROM trabajador 
WHERE tarifa BETWEEN 10 AND 12;

--(b) Cuáles son los oficios de los trabajadores asignados al edificio 435?


SELECT oficio FROM asignacion NATURAL JOIN trabajador WHERE id_e = 435;


--(c)Indicar el nombre del trabajador y el de su supervisor.

SELECT t1.nombre,t2.nombre  FROM trabajador t1 JOIN trabajador t2 ON t1.legajo_supv = t2.legajo;


--(d) Nombre de los trabajadores asignados a oficinas.
SELECT * FROM trabajador NATURAL JOIN asignacion  