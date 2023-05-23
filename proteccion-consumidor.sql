UPDATE comercio
SET direccion = 'Balcarce 50'
WHERE comercio = 42;


-- 1)

SELECT DISTINCT * FROM producto WHERE contenido = 'Choclo' AND tipo = 'Enlatado'
UNION
SELECT DISTINCT * FROM producto WHERE contenido LIKE 'Pochoclo%' AND tipo = 'Bolsa';


--2 )
-- ¿A cuánto el tomate? Listar los precios del tomate que se vende en la zona de Bernal.


SELECT contenido, precio, barrio FROM producto NATURAL JOIN precio NATURAL JOIN comercio WHERE zona = 'Bernal' AND contenido = 'Tomate';

--3)
-- Comercios Gourmet: Listar los comercios que venden Avellanas a más de $50 y también venden Frutas Secas a menos de $40.


SELECT nombre FROM comercio NATURAL JOIN precio NATURAL JOIN producto WHERE contenido = 'Avellana' AND precio > 50
UNION  
SELECT nombre FROM comercio NATURAL JOIN precio NATURAL JOIN producto WHERE contenido = 'Frutas Secas' AND precio > 40;


--4)
-- (d) Productos Exclusivos: Listar los <pid, descripcion> de los productos que son vendidos
--     en el barrio de Palermo, pero que no son vendidos en el barrio de San Telmo.


SELECT DISTINCT pid, descripcion FROM comercio NATURAL JOIN precio NATURAL JOIN producto WHERE barrio = 'Palermo'
EXCEPT
SELECT DISTINCT pid, descripcion FROM comercio NATURAL JOIN precio NATURAL JOIN producto WHERE barrio = 'San Telmo';

--5)
-- (e) Barrios: Listar el <precio-promedio, barrio> del precio promedio de los productos
--              ofrecidos en cada barrio.

--SELECT AVG(precio), barrio FROM comercio NATURAL JOIN precio NATURAL JOIN producto GROUP BY barrio HAVING AVG(precio);




