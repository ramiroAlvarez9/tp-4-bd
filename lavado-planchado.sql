/* 
 (a) Obtener todos los (cod_plancha, fabricante) de las planchas instaladas en sucursales
 que NO tengan lavarropas ESPañoles
 
 (b) Obtener todos los (cod_lavarropas, marca) de los lavarropas fabricados en BRA o que
 en la sucursal donde está instalado trabaje el empleado “johnny”
 
 GROUP BY
 HAVING 
 AVG
 MAX 
 COUNT 
 LIKE
 
 
 SELECT codplancha FROM plancha 
 JOIN 
 (
 SELECT idsucursal FROM plancha 
 EXCEPT                                          
 SELECT idsucursal FROM lavarropas WHERE origen = 'ESP'
 ) 
 AS resta 
 ON resta.idsucursal = plancha.idsucursal;
 
 
 SELECT DISTINCT codplancha, fabricante FROM plancha
    EXCEPT   
 SELECT DISTINCT codplancha, fabricante FROM plancha NATURAL JOIN sucursal NATURAL JOIN lavarropas WHERE origen = 'ESP'; 
 
 
 */

--a)

SELECT DISTINCT codplancha, fabricante FROM plancha 

    EXCEPT 

SELECT DISTINCT codplancha, fabricante FROM plancha NATURAL JOIN sucursal NATURAL JOIN lavarropas WHERE origen = 'ESP';

--b)
/*
    (b) Obtener todos los (codlavarropas, marca) de los lavarropas fabricados en BRA o que
    en la sucursal donde está instalado trabaje el empleado “johnny”

    SELECT codlavarropas, marca 
    FROM lavarropas
    WHERE origen = 'BRA'
        UNION 
    SELECT codlavarropas, marca 
    FROM lavarropas
    NATURAL JOIN sucursal NATURAL JOIN plancha NATURAL JOIN turno
    WHERE apodo ='Johnny';

*/

SELECT DISTINCT codlavarropas, marca FROM lavarropas WHERE origen = 'BRA'
    UNION
SELECT DISTINCT codlavarropas, marca FROM plancha JOIN turno ON plancha.codplancha = turno.plancha_id NATURAL JOIN lavarropas WHERE apodo = 'Johnny' ;

--c)
/*
    (c) Obtener la (idsucursal, cantidad) de lavarropas por sucursal.
*/
SELECT idsucursal, COUNT (marca) AS cant_lavarropas_sucursal FROM lavarropas GROUP BY idsucursal;


--d)
/* 
(d) 
    
    Obtener el promedio de horas trabajadas por empleado, de aquellos empleados que
    trabajan en sucursales que tienen lavarropas con capacidad de más de 20 kg y cuyo
    promedio de horas trabajadas sea mayor a 5.


    pi nombre, promedio_horas ( SELECT trabajan > 5hs (empleados que trabajan en sucursales que tienen lavarropas con capacidad de más de 20 kg) )
        
*/



SELECT apodo, AVG(horas) AS promedio_horas_trabajo FROM plancha NATURAL JOIN turno NATURAL JOIN lavarropas  WHERE capacidad > 20 GROUP BY apodo HAVING AVG (horas) > 5;



-- e) Obtener los empleados que trabajaron solamente con planchas del fabricante “Atma".

/*  
    APODO EMPLEADOS QUE TRABAJARON CON ATMA Y ALGUNA MAS
        EXCEPT
    APODO EMPLEADOS QUE TRABAJARON CON MARCAS DISTINTAS DE ATMA.

*/

SELECT DISTINCT apodo FROM turno NATURAL JOIN plancha WHERE fabricante = 'ATMA'
    EXCEPT 
SELECT DISTINCT apodo FROM turno NATURAL JOIN plancha WHERE fabricante != 'ATMA'; 


