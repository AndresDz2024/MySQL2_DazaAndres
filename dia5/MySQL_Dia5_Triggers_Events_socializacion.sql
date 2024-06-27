######################################
## Dia5 - MySQL2 Triggers - Eventos ##
######################################

use MySQL2_dia5;

## crear un trigger para insertar o actuallizar una ciudad en país con la nueva poblacion
delimiter //
create trigger after_city_insert_update
after insert on city
for each row
begin
update country
set Population = Population + new.Population
where Code = new.CountryCode;
end//
delimiter ;

## Trigger para insertar o actualizar una ciudad en país con la nueva poblacion despues de haberse eliminado
delimiter //
create trigger after_city_delete_update
after delete on city
for each row
begin
	update country
    set Population = Population - old.Population
    where Code = old.CountryCode;
end//
delimiter ;

## crear una tabla para auditoria de ciudad
create table if not exists city_audit(
	audit_id int auto_increment primary key,
    city_id int,
    action varchar(10),
    old_population int,
    new_population int,
    change_time timestamp default current_timestamp
);

## trigger para insertar auditoria de ciudades
delimiter //
create trigger after_city_insert_audit
after insert on city
for each row
begin
	insert into city_audit(city_id, action, new_population)
    values(new.ID, 'INSERT', new.population);
end//
delimiter ;

## trigger para actualizar auditoria de ciudades
delimiter //
create trigger after_city_update_audit
after update on city
for each row
begin
	insert into city_audit(city_id, action, old_population, new_population)
    values(old.ID, 'UPDATE', old.Population, new.Population);
end//
delimiter ;
INSERT into city (Name, CountryCode, District, Population) values ('Artemis', 'AFG', 'Piso 6', 1250000);
select * from city_audit;
update city set Population = 1550000 where ID = 4080;

-- EVENTOS
-- CREACIÓN DE TABLA PARA BK DE CIUDADES
create table if not exists city_backup(
    ID int not null,
    Name char(35) not null,
    CountryCode char(3) not null,
    District char(20) not null,
    Population int not null,
    PRIMARY KEY (ID)
) Engine=InnoDB DEFAULT charset=utf8mb4;

delimiter //
create event if not exists weekly_city_backup
on schedule every 1 week
do
begin
    truncate table city_backup;
    insert into city_backup(ID,Name,CountryCode,District, Population)
    select Id, Name, CountryCode, District, Population
    from city;
end//
delimiter ;

## Desarrollado por: Andres Santiago Daza Daza / T.I. 1095916023