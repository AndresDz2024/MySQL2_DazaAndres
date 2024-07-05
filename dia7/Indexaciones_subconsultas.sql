-- ##############################
-- ###### DIA 7 - MySQL 2  ######
-- ##############################

USE `mysql2_dia5`;

-- SUBCONSULTAS : Se usan para realizar operaciones que requieren un conjunto
-- de datos que se obtiene de manera dinámica a través de otra consulta

-- Subconsulta Escalar : Toda subconsulta que devuelve un solo valor (fila y 
-- columna)
-- EJ: Devuelva el nombre del país con la mayor población

select Name
from country
where Population = (select max(Population) from country);

-- Subconsulta de Columna Única : Devuelve una columna de múltiples filas.
-- EJ: Encuentre los nombres de todas las ciudades en los paises
-- que tienen un área mayor a 1000000 km2

select Name
from city
where CountryCode IN (Select Code from country where SurfaceArea > 1000000);

-- Subconsultas de Múltiples Columnas: Devuelve múltiples columnas
-- de múltiples filas
-- EJ: Encontrar las ciudades que tengan la misma población y distrito
-- que cualquier ciudad del pais. 'USA'

select Name,CountryCode,District,Population
from city
where (District,Population) in (select District,Population from
city where CountryCode = 'USA');

-- Subconsulta Correlacionada: Depende de la consulta externa para cada
-- fila procesada.
-- EJ: Liste las ciudades con una población mayor que el promedio de la
-- poblacion de las ciudades en el mismo pais
select Name,CountryCode,Population
from city c1
where Population > (select avg(Population) from city c2 where c1.CountryCode
= c2.CountryCode);


-- Subconsulta Múltiple:
-- EJ:Listar las ciudades que tengan la misma población que la capital del país
-- 'JPN' (Japon)
select Name
from city
where Population = (select Population from city where ID= (
select Capital from country where Code = 'JPN'
));

-- INDEXACIÓN
select * from city;

-- Crear índice en la columna 'NAME' de City
create index idx_city_name on city(Name);
select * from city;
select Name from city;

-- Crear índice compuesto de las columnas 'District' y 'Population'
create index idx_city_district_population on city(District,Population);

-- Datos estadísticos para ver los índices creados
SELECT 
    TABLE_NAME, 
    INDEX_NAME, 
    SEQ_IN_INDEX, 
    COLUMN_NAME, 
    CARDINALITY, 
    SUB_PART, 
    INDEX_TYPE, 
    COMMENT
FROM 
    information_schema.STATISTICS
WHERE 
    TABLE_SCHEMA = 'mysql2_dia5';
-- Revisar tamaño de Indexaciones creadas
SELECT 
    TABLE_NAME, 
    INDEX_LENGTH 
FROM 
    information_schema.TABLES 
WHERE 
    TABLE_SCHEMA = 'mysql2_dia5';
    
-- TRANSACCIONES
-- Son secuencias de uno o más operaciones SQL, las cuales son ejecutadas como
-- una única unidad de trabajo. En otras palabras, las transacciones
-- aseguran que todas las operaciones se realicen de manera correcta antes
-- de ser ejecutadas en la bbdd real, buscando cumplir con las propiedades
-- ACID. (ATOMICIDAD, CONSISTENCIA, AISLAMIENTO, DURABILIDAD).

-- Primer paso : INICIAR LA TRANSACCIÓN
start transaction;
-- Segundo Paso: HACER COMANDOS
-- EJ: Actualizar la población de la ciudad de 'New York'
update city
set population = 9000000
where Name = 'New York';

select * from city where Name='New York';

-- Tercer Paso: Si quiero que los cambios se mantengan pongo COMMIT, sino
-- revierto mis cambios con ROLLBACK.
commit; -- Mandar cambios a produccion
rollback;-- Revertir cambios