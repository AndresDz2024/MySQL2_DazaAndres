############################################
## Dia #4 - MySQL2 - Seguridad - Usuarios ## 
############################################

create database AutoRental;

use AutoRental;

create table cliente (
	id int primary key,
    nombre1 varchar(25) not null,
    nombre2 varchar(25),
    apellido1 varchar(25) not null,
    apellido2 varchar(25) not null,
    email varchar(25) not null,
    cedula int(15) not null,
    celular varchar(25),
    ciudad_residencia varchar(25),
    direccion varchar(25)
);

create table sucursales(
	id int primary key,
    email varchar(25),
    celular varchar(25),
    telefono varchar(25),
    ciudad varchar(25),
    direccion varchar(25)
);

create table empleado(
	id int primary key,
    nombre1 varchar(25) not null,
    nombre2 varchar(25),
    apellido1 varchar(25) not null,
    apellido2 varchar(25) not null,
    email varchar(25) not null,
    cedula int(15) not null,
    celular varchar(25) not null,
    ciudad_residencia varchar(25) not null,
    direccion varchar(25) not null,
    id_sucursal int,
    foreign key (id_sucursal) references sucursales(id)
);

create table vehiculo(
	id int primary key,
    color varchar(25) not null,
    motor varchar(25) not null,
    sunroof varchar(25) not null,
    capacidad varchar(25) not null,
    puertas int(3) not null,
    modelo varchar(25) not null,
    referencia varchar(25) not null,
    placa varchar(25) not null,
    tipo_vehiculo varchar(25) not null
);

create table alquileres(
	id int primary key,
    fecha_salida date not null,
    fecha_llegada date not null,
    fecha_esperada_llegada date not null,
    valor_alquiler_semana int(25) not null,
    valor_alquiler_dia int(25) not null,
    porcentaje_descuento decimal(2,2) not null,
    valor_cotizado int(40) not null,
    valor_pagado int(40) not null,
    id_vehiculo int,
    id_empleado int,
    id_cliente int,
    id_secursal_salida int,
    id_sucursal_llegada int,
    foreign key (id_vehiculo) references vehiculo(id),
    foreign key (id_empleado) references empleado(id),
    foreign key (id_cliente) references cliente(id),
    foreign key (id_sucursal_salida) references sucursales(id),
	foreign key (id_sucursal_llegada) references sucursales(id)
);
	

## Desarrollado por: Andres Daza / T.I. 1095916023