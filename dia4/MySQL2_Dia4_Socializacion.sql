############################################
## Dia #4 - MySQL2 - Seguridad - Usuarios ## 
############################################

create database dia4_MySQL2;

use dia4_MySQL2;

## creacion de usuario camper con acceso desde cualquier parte
create user 'camper'@'%' identified by 'campus2023';

## visualizar permisos de un usuario
show grants for 'camper'@'%';

## crear tabla e insertar datos
create table persona (id int primary key, nombre varchar(255),apellido varchar (255));
insert into persona (id,nombre,apellido) values (1,'Juan','Perez');
insert into persona (id,nombre,apellido) values (2,'Andres','Pastrana');
insert into persona (id,nombre,apellido) values (3,'Pedro','Gómez');
insert into persona (id,nombre,apellido) values (4,'Camilo','Gonzalez');
insert into persona (id,nombre,apellido) values (5,'Stiven','Maldonado');
insert into persona (id,nombre,apellido) values (6,'Ardila','Perez');
insert into persona (id,nombre,apellido) values (7,'Ruben','Gómez');
insert into persona (id,nombre,apellido) values (8,'Andres','Portilla');
insert into persona (id,nombre,apellido) values (9,'Miguel','Carvajal');
insert into persona (id,nombre,apellido) values (10,'Andrea','Gómez');

## Dar permiso de SELECT a usuario
grant select on dia4_MySQL2.persona to 'camper'@'%';

## refrescar permisos de la bbdd
flush privileges;

## añadir permisos para hacer crud
grant update, insert, delete on dia4_MySQL2 to 'camper'@'%';

## Crear otra tabla 
create table persona2(id int PRIMARY key, nombre VARCHAR(255), apellido VARCHAR(255));
INSERT into persona2 (id, nombre, apellido) values (1, 'Carlos', 'Perez');
INSERT into persona2 (id, nombre, apellido) values (2, 'Andres', 'Martinez');
INSERT into persona2 (id, nombre, apellido) values (3, 'Alejandro', 'Gómez');
INSERT into persona2 (id, nombre, apellido) values (4, 'Camila', 'Gonzalez');
INSERT into persona2 (id, nombre, apellido) values (5, 'Stiven', 'Montañas');
INSERT into persona2 (id, nombre, apellido) values (6, 'Ardila', 'Lule');
INSERT into persona2 (id, nombre, apellido) values (7, 'Sebastian', 'Gómez');
insert into persona2 (id,nombre,apellido) values (8,'Andres','Portrilla');
insert into persona2 (id,nombre,apellido) values (9,'Miguel','Carvajal');
insert into persona2 (id,nombre,apellido) values (10,'Andrea','Gómez');

-- PELIGROSO: CREAR UN USUARIO CON PERMISOS A TODO DESDE CUALQUIER LADO CON MALA CONTRASEÑA
create user 'todito'@'%' identified by 'todito';
grant all on *.* to 'todito'@'%';
show grants for 'todito'@'%';

## Denegar permisos
revoke all on *.* from 'todito'@'%';

## crear limite para que solamente se hagan x consultas por hora
alter user 'camper'@'%' with max_queries_per_hour 5;
flush privileges;

## reevisar limites o permisos de usuarios a nivel de motor
select * from mysql.user where host = '%';

## eliminar usuarios
drop user 'todito'@'%';

## solo poner permisos para que consulte una x base de datos, una y tabla, una z columna
grant select (nombre) on dia4_MySQL2.persona to 'camper'@'%';

## Desarrollado por: Andres Daza / T.I. 1095916023