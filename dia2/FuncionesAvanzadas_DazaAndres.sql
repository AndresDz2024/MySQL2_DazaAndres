-- #########################################
-- ### DIA #2 - Consultas Avanzadas - MySQL2
-- #########################################

create database mysql2_dia2;
use mysql2_dia2;

-- TITULO : CONSULTAS AVANZADAS

create table productos(
    id int auto_increment,
    nombre varchar(100),
    precio decimal(10,2), 
    primary key(id)
);

-- truncate table productos;

insert into productos values
    (1,"Pepito",23.2),
    (2,"MousePad",100000.21),
    (3,"Espionap",2500.25),
    (4,"BOB-ESPONJA",1500.25),
    (5,"Cary",23540000.23),
    (6,"OvulAPP",198700.23),
    (7,"PapayAPP",2000.00),
    (8,"Menosprecio",3800.00),
    (9,"PerfumeMascotas",2300.00),
    (10,"Perfume La Cumbre", 35000.25),
    (11,"Nevera M800",3000.12),
    (12,"Crema Suave", 2845.00),
    (13,"juego de mesa La Cabellera",9800.00),
    (14,"Cargador iPhone",98000.00);
    
## Crear funcion la cual retorne nombre del producto con el precio mas iva(19%)
## donde si vale mas de 1000 se aplica un descuento del 20%
delimiter //
create function TotalConIva(precio  decimal(10,2), iva decimal(5,3))
returns decimal(10,2) deterministic
begin
	if precio > 1000 then
		return (precio+(precio*iva))-((precio+(precio*iva))*0.2);
	else 
		return precio + (precio*iva);
	end if;
end//
delimiter ;

drop function TotalConIva;

select TotalConIva(25000, 0.19);

## extrapolar funcion con datos de tablas

select TotalConIva(precio, 0.19) from productos;

## funcion para obtener el precio de un producto dado su nombre
delimiter //
create function obtener_precio_producto_total(nombre_producto varchar(100))
returns decimal(10,2) deterministic
begin
	declare precio_producto decimal(10,2);
    select TotalConIva(precio, 0.19) into precio_producto from productos
    where nombre = nombre_producto;
    return precio_producto;
end//
delimiter ;

drop function obtener_precio_producto;

select obtener_precio_producto_total('PEPITO') as precio;

delimiter //
create function obtener_precio_producto(nombre_producto varchar(100))
returns decimal(10,2) deterministic
begin
	declare precio_producto decimal(10,2);
    select precio into precio_producto from productos
    where nombre = nombre_producto;
    return precio_producto;
end//
delimiter ;

select obtener_precio_productos('PEPITO') as precio;

delimiter //
create function precio_promedio_productos()
returns decimal(10,2) deterministic
begin
	declare promedio decimal(10,2);
    select avg(precio) into promedio from productos;
    return promedio;
end//
delimiter ;

select precio_promedio_productos();

## procedimiento para insertar un nuevo producto
delimiter //
create procedure insertar_producto(in nombre_producto varchar(100), in precio_producto decimal(10,2))
begin
	insert into productos(nombre, precio)
    values (nombre_producto, precio_producto);
end//
delimiter ;
call insertar_producto('gorra', 50000.00);

delimiter //
create procedure eliminar_producto(in nombre_producto varchar(100))
begin
	delete from productos where nombre = nombre_producto;
end//
delimiter ;
call eliminar_producto('gorra');

## Desarrollado por Andres Santiago Daza Daza / T.I. 1095916023