####################################################
### Dia #5 - MySQL2 - Triggers - Eventos - tarea ###
####################################################

use AutoRental;

create table inserciones_nuevas_clientes(
	id int primary key,
    nombre1 varchar(25) not null,
    nombre2 varchar(25),
    apellido1 varchar(25) not null,
    apellido2 varchar(25),
    email varchar(50) not null,
    cedula varchar(25) not null,
    celular varchar(25) not null,
    ciudad_residencia varchar(25) not null,
    direccion varchar(25) not null,
	action varchar(25),
    hora_actualizacion timestamp default current_timestamp
);

## creacion de un trigger (accionario), para registrar en una tabla cada vez que se realize una inserción en la tabla de clientes con su horario
delimiter //
create trigger after_cliente_insert
after insert on cliente
for each row
begin
	insert into inserciones_nuevas_clientes(id, nombre1, nombre2, apellido1, apellido2, email, cedula, celular, ciudad_residencia, direccion, action) values(new.id, new.nombre1, new.nombre2, new.apellido1, new.apellido2, new.email, new.cedula, new.celular, new.ciudad_residencia, new.direccion, "INSERT");
end//
delimiter ;

## creacion de un trigger (accionario), para registrar en una tabla cada vez que se realize una actualización en la tabla de clientes con su horario
delimiter //
create trigger after_cliente_update
after insert on cliente
for each row
begin
	insert into inserciones_nuevas_clientes(id, nombre1, nombre2, apellido1, apellido2, email, cedula, celular, ciudad_residencia, direccion, action) values(new.id, new.nombre1, new.nombre2, new.apellido1, new.apellido2, new.email, new.cedula, new.celular, new.ciudad_residencia, new.direccion, "UPDATE");
end//
delimiter ;

select * from inserciones_nuevas_clientes;

create table backup_clientes(
	id int primary key,
    nombre1 varchar(25) not null,
    nombre2 varchar(25),
    apellido1 varchar(25) not null,
    apellido2 varchar(25),
    email varchar(50) not null,
    cedula varchar(25) not null,
    celular varchar(25) not null,
    ciudad_residencia varchar(25) not null,
    direccion varchar(25) not null
);

## Creacion de un evento, para crear una back up de cliente, de manera que al actualizar un cliente, se guarde el back up
delimiter //
create event daily_city_backup
on schedule every 1 day
do
begin
	truncate table backup_clientes;
	insert into backup_clientes(id, nombre1, nombre2, apellido1, apellido2, email, cedula, celular, ciudad_residencia, direccion) select id, nombre1, nombre2, apellido1, apellido2, email, cedula, celular, ciudad_residencia, direccion
    from cliente;
end//
delimiter ;