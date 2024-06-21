-- #############################################
-- ### DIA #2 - funcion - procedimiento - MySQL2
-- #############################################

create database dia2_MySQL2;

use dia2_MySQL2;

CREATE TABLE departamento (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DOUBLE UNSIGNED NOT NULL,
gastos DOUBLE UNSIGNED NOT NULL
); 


CREATE TABLE empleado (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nif VARCHAR(9) NOT NULL UNIQUE,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
id_departamento INT UNSIGNED,
FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);
INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);
INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);

## consultas avanzadas (función, procedimiento o sets)

## lista el primer apellido de todos los empleados. (función)
delimiter //
create procedure listar_apellido()
begin
    select apellido1 from empleado;
end //
delimiter ;

call listar_apellido();

## lista el primer apellido de los empleados eliminando los apellidos que estén
## repetidos.
delimiter // 
create procedure listar_apellido_norep()
begin 
    select distinct apellido1 from empleado;
end //
delimiter ; 

call listar_apellido_norep();

## lista todas las columnas de la tabla empleado.
delimiter //
create procedure listar_todos_empleados()
begin 
    select * from empleado;
end //
delimiter ;

call listar_todos_empleados();

## lista el nombre y los apellidos de todos los empleados.
delimiter //
create procedure lista_nombres_apellidos_empleados()
begin 
    select nombre, apellido1, apellido2 from empleado;
end //
delimiter ;

call lista_nombres_apellidos_empleados(); 

## lista el identificador de los departamentos de los empleados que aparecen
## en la tabla empleado.
delimiter //
create procedure listar_departamentos_id()
begin 
    select distinct id_departamento from empleado where id_departamento is not null;
end //
delimiter ; 

call listar_departamentos_id();

## lista el identificador de los departamentos de los empleados que aparecen
## en la tabla empleado, eliminando los identificadores que aparecen repetidos.
delimiter //
create procedure listar_departamentos_unrepeat()
begin
    select distinct id_departamento from empleado where id_departamento is not null;
end //
delimiter ; 

call listar_departamentos_unrepeat();

## lista el nombre y apellidos de los empleados en una única columna. 
delimiter //
create procedure listar_nombre_apellidos_columna()
begin 
    select concat(nombre, ' ', apellido1, ' ', ifnull(apellido2, '')) as full_name from empleado;
end //
delimiter ;

call listar_nombre_apellidos_columna();

## lista el nombre y apellidos de los empleados en una única columna,
## convirtiendo todos los caracteres en mayúscula.
delimiter //
create procedure listar_nombre_apellidos_columna_mayuscula()
begin 
    select upper(concat(nombre, ' ', apellido1, ' ', ifnull(apellido2, ''))) as full_name_mayus from empleado;
end //
delimiter ;

call listar_nombre_apellidos_columna_mayuscula();

## lista el nombre y apellidos de los empleados en una única columna,
## convirtiendo todos los caracteres en minúscula.
delimiter //
create procedure listar_nombre_apellidos_columna_minuscula()
begin 
    select lower(concat(nombre, ' ', apellido1, ' ', ifnull(apellido2, ''))) as full_name_minus from empleado;
end //
delimiter ;

call listar_nombre_apellidos_columna_minuscula();

## lista el identificador de los empleados junto al nif, pero el nif deberá
## aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la
## otra la letra.
delimiter //
create procedure listar_id_nif()
begin 
    select id,
            substring(nif, 1, length(nif) - 1) as nif_digit,
            right(nif, 1) as nif_letter
    from empleado;
end // 
delimiter ;

call listar_id_nif(); 

## lista el nombre de cada departamento y el valor del presupuesto actual del
## que dispone. para calcular este dato tendrá que restar al valor del
## presupuesto inicial (columna presupuesto) los gastos que se han generado
## (columna gastos). tenga en cuenta que en algunos casos pueden existir
## valores negativos. utilice un alias apropiado para la nueva columna columna
## que está calculando.
delimiter //
create function calcular_presupuesto_actual(presupuesto double, gastos double)
returns double
deterministic 
begin 
    return presupuesto - gastos;
end // 
delimiter ;

select nombre, calcular_presupuesto_actual(presupuesto, gastos) as presupuesto_actual
from departamento;

## lista el nombre de los departamentos y el valor del presupuesto actual
## ordenado de forma ascendente.
select nombre, calcular_presupuesto_actual(presupuesto, gastos) as presupuesto_actual
from departamento
order by presupuesto_actual asc;

## lista el nombre de todos los departamentos ordenados de forma
## ascendente.
delimiter //
create procedure listar_deptos_asc()
begin 
    select nombre
    from departamento
    order by nombre asc;
end //
delimiter ;

call listar_deptos_asc();

## lista el nombre de todos los departamentos ordenados de forma
## descendente.
delimiter //
create procedure listar_deptos_desc()
begin 
    select nombre 
    from departamento 
    order by nombre desc;
end //
delimiter ;

call listar_deptos_desc();

## lista los apellidos y el nombre de todos los empleados, ordenados de forma
## alfabética teniendo en cuenta en primer lugar sus apellidos y luego su
## nombre.
delimiter //
create function lista_empleados_ordenados() 
returns varchar(100) deterministic
begin
    declare result varchar(100);
    set result = (
        select concat(apellido1, ' ', apellido2, ', ', nombre) as empleado
        from empleado
        order by apellido1, apellido2, nombre
    );
    return result;
end //
delimiter ;

select lista_empleados_ordenados() as 'Lista de empleados ordenados';

## devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.
delimiter //
create procedure deptos_3_max()
begin
    select nombre, presupuesto
    from departamento
    order by presupuesto desc
    limit 3;
end //
delimiter ;

call deptos_3_max();

## devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
delimiter //
create procedure deptos_3_min()
begin
    select nombre, presupuesto
    from departamento
    order by presupuesto asc
    limit 3;
end //
delimiter ;

call deptos_3_min();

## devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.
delimiter //
create procedure deptos_2_mayorg()
begin
    select nombre, gastos
    from departamento
    order by gastos desc
    limit 2;
end //
delimiter ;

call deptos_2_mayorg();

## devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.
delimiter //
create procedure deptos_2_menorg()
begin
    select nombre, gastos
    from departamento
    order by gastos asc
    limit 2;
end //
delimiter ;

call deptos_2_menorg();

## devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La
## tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las columnas de la tabla empleado.
delimiter //
create procedure filas_empleado()
begin
    select *
    from empleado
    limit 2, 5;
end //
delimiter ;

call filas_empleado();

## devuelve una lista con el nombre de los departamentos y el presupuesto, de
## aquellos que tienen un presupuesto mayor o igual a 150000 euros.
delimiter //
create procedure deptos_presupuesto_150000()
begin
    select nombre, presupuesto
    from departamento
    where presupuesto >= 150000;
end //
delimiter ;

call deptos_presupuesto_150000();

## devuelve una lista con el nombre de los departamentos y el gasto, de aquellos que tienen menos de 5000 euros de gastos.
delimiter //
create procedure deptos_gasto_5000()
begin
    select nombre, gastos
    from departamento
    where gastos < 5000;
end //
delimiter ;

call deptos_gasto_5000();

## devuelve una lista con el nombre de los departamentos y el presupuesto, de
## aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
delimiter //
create procedure deptos_presupuesto_entre()
begin
    select nombre, presupuesto
    from departamento
    where presupuesto >= 100000 and presupuesto <= 200000;
end //
delimiter ;

call deptos_presupuesto_entre();

## devuelve una lista con el nombre de los departamentos que no tienen un
## presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
delimiter //
create procedure deptos_entre_nobetween()
begin
    select nombre
    from departamento
    where presupuesto < 100000 or presupuesto > 200000;
end //
delimiter ;

call deptos_entre_nobetween();

## devuelve una lista con el nombre de los departamentos que tienen un
## presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
delimiter //
create procedure deptos_entre_between()
begin
    select nombre, presupuesto
    from departamento
    where presupuesto between 100000 and 200000;
end //
delimiter ;

call deptos_entre_between();

## devuelve una lista con el nombre de los departamentos que no tienen un
## presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
delimiter //
create procedure deptos_noentre_between()
begin
    select nombre
    from departamento
    where presupuesto not between 100000 and 200000;
end //
delimiter ;

call deptos_noentre_between();

## devuelve una lista con el nombre de los departamentos, gastos y
## presupuesto, de aquellos departamentos donde los gastos sean mayores que el presupuesto del que disponen.
delimiter //
create procedure deptos_gastos_mayores_presupuesto()
begin
    select nombre, gastos, presupuesto
    from departamento
    where gastos > presupuesto;
end //
delimiter ;

call deptos_gastos_mayores_presupuesto();

## devuelve una lista con el nombre de los departamentos, gastos y
## presupuesto, de aquellos departamentos donde los gastos sean menores que el presupuesto del que disponen.
delimiter //
create procedure deptos_gastos_menores_presupuesto()
begin
    select nombre, gastos, presupuesto
    from departamento
    where gastos < presupuesto;
end //

call deptos_gastos_menores_presupuesto();

## devuelve una lista con el nombre de los departamentos, gastos y
## presupuesto, de aquellos departamentos donde los gastos sean iguales al
## presupuesto del que disponen.
delimiter //
create function gasto_igual_presupuesto()
returns varchar(100) deterministic
begin
    declare nombre_departamento varchar(100);
    select nombre into nombre_departamento from departamento
    where presupuesto = gastos;
    return nombre_departamento;
end//
delimiter ;

select gasto_igual_presupuesto();

## lista todos los datos de los empleados cuyo segundo apellido sea null.
delimiter //
create procedure empleado_apellido2_null()
begin
    select *
    from empleado
    where apellido2 is null;
end//
delimiter ;

call empleado_apellido2_null();

## lista todos los datos de los empleados cuyo segundo apellido no sea null.
delimiter //
create procedure empleado_apellido2_notnull()
begin
    select *
    from empleado
    where apellido2 is not null;
end//
delimiter ;

call empleado_apellido2_notnull();

## lista todos los datos de los empleados cuyo segundo apellido sea lópez.
delimiter //
create procedure empleado_apellido2_lopez()
begin
    select *
    from empleado
    where apellido2 = 'lópez';
end//
delimiter ;

call empleado_apellido2_lopez();

## lista todos los datos de los empleados cuyo segundo apellido
## sea díaz o moreno. sin utilizar el operador in.
delimiter //
create procedure empleado_apellido2_diaz_moreno()
begin
    select *
    from empleado
    where apellido2 = 'díaz' or apellido2 = 'moreno';
end//
delimiter ;

call empleado_apellido2_diaz_moreno();

## lista todos los datos de los empleados cuyo segundo apellido
## sea díaz o moreno. utilizando el operador in.
delimiter //
create procedure empleado_apellido2_diaz_moreno_in()
begin
    select *
    from empleado
    where apellido2 in ('díaz', 'moreno');
end//
delimiter ;

call empleado_apellido2_diaz_moreno_in();

## lista los nombres, apellidos y nif de los empleados que trabajan en el
## departamento 3.
delimiter //
create procedure nombres_apellidos_nif_depto3()
begin
    select nombre, apellido1, apellido2, nif
    from empleado
    where id_departamento = 3;
end //
delimiter ;

call nombres_apellidos_nif_depto3();

## lista los nombres, apellidos y nif de los empleados que trabajan en los
## departamentos 2, 4 o 5.
delimiter //
create procedure nombres_apellidos_nif_depto245()
begin
    select nombre, apellido1, apellido2, nif
    from empleado
    where id_departamento in (2, 4, 5);
end //
delimiter ;

call nombres_apellidos_nif_depto245();

## consultas multitabla (composición interna)

## devuelve un listado con los empleados y los datos de los departamentos
## donde trabaja cada uno.
delimiter //
create procedure lista_empleado_depto()
begin
    select e.id as id_empleado, e.nif, e.nombre as nombre_empleado, e.apellido1, e.apellido2, d.id as id_departamento, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    inner join departamento d on e.id_departamento = d.id;
end //
delimiter ;

call lista_empleado_depto();

## Devuelve un listado con los empleados y los datos de los departamentos
## donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre
## del departamento (en orden alfabético) y en segundo lugar por los apellidos
## y el nombre de los empleados.
delimiter //
create procedure lista_empleado_depto_orden()
begin
    select e.nombre as nombre_empleado, e.apellido1, e.apellido2, e.nif, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    inner join departamento d on e.id_departamento = d.id
    order by d.nombre asc, e.apellido1 asc, e.apellido2 asc, e.nombre asc;
end //
delimiter ;

call lista_empleado_depto_orden();

## devuelve un listado con el identificador y el nombre del departamento,
## solamente de aquellos departamentos que tienen empleados.
delimiter //
create procedure id_nombre_depto_empleados()
begin
    select d.id as identificador, d.nombre as nombre_departamento
    from departamento d
    inner join empleado e on d.id = e.id_departamento;
end//
delimiter ;

call id_nombre_depto_empleados();

## devuelve un listado con el identificador, el nombre del departamento y el
## valor del presupuesto actual del que dispone, solamente de aquellos
## departamentos que tienen empleados.
delimiter //
create procedure deptos_presupuesto_actual()
begin
    select d.id as id_departamento, d.nombre as nombre_departamento, (d.presupuesto - d.gastos) as presupuesto_actual
    from departamento d
    inner join empleado e on d.id = e.id_departamento
    group by d.id;
end //
delimiter ;

call deptos_presupuesto_actual();

## devuelve el nombre del departamento donde trabaja el empleado que tiene
## el nif 38382980m.
delimiter //
create procedure empleado_nif()
begin
    select d.nombre as nombre_departamento
    from departamento d
    inner join empleado e on d.id = e.id_departamento
    where e.nif = '38382980m';
end //
delimiter ;

call empleado_nif();

## Devuelve el nombre del departamento donde trabaja el empleado 
## pepe ruiz santana.
delimiter //
create function deptos_pepe()
returns varchar(100) deterministic
begin
    declare depto_nombre varchar(100);
    select d.nombre into depto_nombre
    from empleado e
    join departamento d on e.id_departamento = d.id
    where e.nombre = 'Pepe' and e.apellido1 = 'Ruiz' and e.apellido2 = 'Santana';
    return depto_nombre;
end //
delimiter ;

select deptos_pepe() as deptos_pepe;

## Devuelve un listado con los datos de los empleados que trabajan en el
## departamento de i+d. ordena el resultado alfabéticamente.
delimiter //
create procedure listar_empleados_i_plus_d()
begin
    select e.*
    from empleado e
    join departamento d on e.id_departamento = d.id
    where d.nombre = 'I+D'
    order by e.nombre, e.apellido1, e.apellido2;
end //
delimiter ;

call listar_empleados_i_plus_d();

## Devuelve un listado con los datos de los empleados que trabajan en el
## departamento de sistemas, contabilidad o i+d. ordena el resultado
## alfabéticamente.
delimiter //
create procedure empleados_deptos_SCI()
begin
    select e.*
    from empleado e
    join departamento d on e.id_departamento = d.id
    where d.nombre in ('Sistemas', 'Contabilidad', 'I+D')
    order by e.nombre, e.apellido1, e.apellido2;
end //
delimiter ;

call empleados_deptos_SCI();

## Devuelve una lista con el nombre de los empleados que tienen los
## departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
delimiter //
create procedure empleados_presupuesto_no_en()
begin
    select e.nombre, e.apellido1, e.apellido2
    from empleado e
    join departamento d on e.id_departamento = d.id
    where d.presupuesto not between 100000 and 200000;
end //
delimiter ;

call empleados_presupuesto_no_en();

## Devuelve un listado con el nombre de los departamentos donde existe
## algún empleado cuyo segundo apellido sea null. tenga en cuenta que no
## debe mostrar nombres de departamentos que estén repetidos.
delimiter //
create procedure deptos_empleado_apellido2_null()
begin
    select distinct d.nombre
    from departamento d
    join empleado e on d.id = e.id_departamento
    where e.apellido2 is null;
end //
delimiter ;

call deptos_empleado_apellido2_null();


## consultas multitabla (composición externa)

## Devuelve un listado con todos los empleados junto con los datos de los
## departamentos donde trabajan. este listado también debe incluir los
## empleados que no tienen ningún departamento asociado.
delimiter //
create procedure empleados_deptos()
begin
    select e.*, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    left join departamento d on e.id_departamento = d.id;
end //
delimiter ;

call empleados_deptos();

## Devuelve un listado donde sólo aparezcan aquellos empleados que no
## tienen ningún departamento asociado.
delimiter //
create procedure empleados_sin_depto()
begin
    select e.*
    from empleado e
    left join departamento d on e.id_departamento = d.id
    where d.id is null;
end //
delimiter ;

call empleados_sin_depto();

## Devuelve un listado donde sólo aparezcan aquellos departamentos que no
## tienen ningún empleado asociado.
delimiter //
create procedure depto_no_empleados()
begin
    select d.*
    from departamento d
    left join empleado e on d.id = e.id_departamento
    where e.id is null;
end //
delimiter ;

call depto_no_empleados();

## Devuelve un listado con todos los empleados junto con los datos de los
## departamentos donde trabajan. el listado debe incluir los empleados que no
## tienen ningún departamento asociado y los departamentos que no tienen
## ningún empleado asociado. ordene el listado alfabéticamente por el
## nombre del departamento.
delimiter //
create procedure todo_empleados_deptos()
begin
    select e.*, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    left join departamento d on e.id_departamento = d.id
    union
    select e.*, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    right join departamento d on e.id_departamento = d.id
    order by nombre_departamento;
end //
delimiter ;

call todo_empleados_deptos();

## Devuelve un listado con los empleados que no tienen ningún departamento
## asociado y los departamentos que no tienen ningún empleado asociado.
## ordene el listado alfabéticamente por el nombre del departamento.
delimiter //
create procedure todo_empleados_no_deptos_orden()
begin
    select e.*, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    left join departamento d on e.id_departamento = d.id
    where d.id is null
    union
    select e.*, d.nombre as nombre_departamento, d.presupuesto, d.gastos
    from empleado e
    right join departamento d on e.id_departamento = d.id
    where e.id is null
    order by nombre_departamento;
end //
delimiter ;

call todo_empleados_no_deptos_orden();

## Consultas Resumen

## Calcula la suma del presupuesto de todos los departamentos.
delimiter //
create function suma_presupuesto()
returns double deterministic
begin
	declare suma_total double;
	select sum(presupuesto) into suma_total from departamento;
	return suma_total;
end//
delimiter ;

select suma_presupuesto() as suma_presupuesto;

## Calcula la media del presupuesto de todos los departamentos.
delimiter //
create function media_presupuesto()
returns double deterministic
begin
	declare presupuesto_media double;
	select avg(presupuesto) into presupuesto_media from departamento;
	return presupuesto_media;
end//
delimiter ;

select media_presupuesto() as media_presupuesto;

## Calcula el valor mínimo del presupuesto de todos los departamentos.
delimiter //
create function minimo_presupuesto()
returns double deterministic
begin
	declare presupuesto_min double;
	select min(presupuesto) into presupuesto_min from departamento;
	return presupuesto_min;
end//
delimiter ;

select minimo_presupuesto() as minimo_presupuesto;

## Calcula el nombre del departamento y el presupuesto que tiene asignado,
## del departamento con menor presupuesto.

delimiter //
create function minimo_presupuesto_nombre()
returns varchar(100) deterministic
begin
    declare min_presupuesto int;
    declare depto_nombre varchar(50);
    declare resultado varchar(100);
    select min(presupuesto) into min_presupuesto from departamento;
    select nombre into depto_nombre from departamento where presupuesto = min_presupuesto limit 1;
    set resultado = concat('Nombre: ', depto_nombre, ', Presupuesto: ', min_presupuesto);
    return resultado;
end//
delimiter ;

select minimo_presupuesto_nombre() as resultado;

## Calcula el valor máximo del presupuesto de todos los departamentos.
delimiter //
create function maximo_presupuesto()
returns double deterministic
begin
	declare presupuesto_max double;
	select max(presupuesto) into presupuesto_max from departamento;
	return presupuesto_max;
end//
delimiter ;

select maximo_presupuesto() as maximo_presupuesto;

## Calcula el nombre del departamento y el presupuesto que tiene asignado,
## del departamento con mayor presupuesto.
delimiter //
create procedure maximo_presupuesto()
begin
    declare max_presupuesto int;
    select max(presupuesto) into max_presupuesto from departamento;
    select nombre, presupuesto
    from departamento
    where presupuesto = max_presupuesto;
end//
delimiter ;

call maximo_presupuesto();

## Calcula el número total de empleados que hay en la tabla empleado.
delimiter //
create procedure numero_empleados()
begin
	select count(id) from empleado;
end//
delimiter ;

call numero_empleados();

## Calcula el número de empleados que no tienen NULL en su segundo
## apellido.
delimiter //
create procedure empleados_no_null()
begin
	select count(id) from empleado where apellido2 is not null;
end//
delimiter ;

drop procedure empleados_no_null;

call empleados_no_null();

## Calcula el número de empleados que hay en cada departamento. Tienes que
## devolver dos columnas, una con el nombre del departamento y otra con el
## número de empleados que tiene asignados.

delimiter //
create procedure nombre_numero_depto()
begin
	select departamento.nombre, count(empleado.id) from departamento inner join empleado on departamento.id = empleado.id_departamento group by departamento.nombre;
end//
delimiter ;

call nombre_numero_depto();

## Calcula el nombre de los departamentos que tienen más de 2 empleados. El
## resultado debe tener dos columnas, una con el nombre del departamento y
## otra con el número de empleados que tiene asignados.

delimiter //
create procedure depto_2()
begin
	select departamento.nombre, count(empleado.id) from departamento inner join empleado on departamento.id = empleado.id_departamento group by departamento.nombre having count(empleado.id)>2;	
end//
delimiter ;
drop procedure depto_2;

call depto_2();

## Calcula el número de empleados que trabajan en cada uno de los
## departamentos. El resultado de esta consulta también tiene que incluir
## aquellos departamentos que no tienen ningún empleado asociado.
delimiter //
create procedure nombre_numero_depto_todos()
begin
	select departamento.nombre, count(empleado.id) from departamento left join empleado on departamento.id = empleado.id_departamento group by departamento.nombre;
end//
delimiter ;

call nombre_numero_depto_todos();

## Calcula el número de empleados que trabajan en cada unos de los
## departamentos que tienen un presupuesto mayor a 200000 euros.
delimiter //
create procedure depto_mayor()
begin
	select departamento.nombre,departamento.presupuesto, count(empleado.id) from departamento left join empleado on departamento.id = empleado.id_departamento where departamento.presupuesto>200000 group by departamento.nombre, departamento.presupuesto;	
end//
delimiter ;

call depto_mayor();

-- Desarrollado por Andres Daza / T.I. 1095916023