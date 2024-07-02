use AutoRental;

## registrar un cliente
delimiter //
create procedure registrar_cliente(cliente_id int, cliente_nombre1 varchar(25), cliente_nombre2 varchar(25), cliente_apellido1 varchar(25), cliente_apellido2 varchar(25), cliente_email varchar(50), cliente_cedula varchar(25), cliente_celular varchar(25), cliente_ciudad_residencia varchar(25), cliente_direccion varchar(25))
begin
	insert into cliente(id, nombre1, nombre2, apellido1, apellido2, email, cedula, celular, ciudad_residencia, direccion)
    values (cliente_id, cliente_nombre1, cliente_nombre2, cliente_apellido1, cliente_apellido2, cliente_email, cliente_cedula, cliente_celular, cliente_ciudad_residencia, cliente_direccion);
end//
delimiter ;
CALL registrar_cliente('101', 'Alberto', 'Nicol', 'instantaneo', 'Apesta', 'AlbertEinstein@gmail.com', '1234567890', '123-123-123', 'Bucaramanga', 'Rincon de Giron 100#123-123');

## actualizar un cliente dado su id
delimiter //
create procedure actualizar_cliente(id_cliente int, n_id_cliente int, n_cliente_nombre1 varchar(25), n_cliente_nombre2 varchar(25), n_cliente_apellido1 varchar(25), n_cliente_apellido2 varchar(25), n_cliente_email varchar(50), n_cliente_cedula varchar(25), n_cliente_celular varchar(25), n_cliente_ciudad_residencia varchar(25), n_cliente_direccion varchar(25))
begin
	update cliente set id = n_id_cliente, nombre1 = n_cliente_nombre1, nombre2 = n_cliente_nombre2, apellido1 = n_cliente_apellido1, apellido2 = n_cliente_apellido2, email = n_cliente_email, cedula = n_cliente_cedula, celular = n_cliente_celular, ciudad_residencia = n_cliente_ciudad_residencia, direccion = n_cliente_direccion
    where id = id_cliente;
end//
delimiter ;
call actualizar_cliente(12345, 102, 'Juancho','Felipe','Casillas','Vida','JuanchoVida@gmail.com','6333333-3', '633-33-33', 'Piedecuesta', 'barrio 232#232-232');

## registrar empleados
delimiter //
create procedure registrar_empleado(empleado_id int, empleado_nombre1 varchar(25), empleado_nombre2 varchar(25), empleado_apellido1 varchar(25), empleado_apellido2 varchar(25), empleado_email varchar(25), empleado_cedula varchar(25), empleado_celular varchar(25), empleado_ciudad_residencia varchar(25), empleado_direccion varchar(25), empleado_sucursal int)
begin
	declare n_sucursales int;
    select count(*) into n_sucursales from sucursales where sucursales.id = empleado_sucursal;
    if n_sucursales > 0 then
		insert into empleado(id, nombre1, nombre2, apellido1, apellido2, email, cedula, celular, ciudad_residencia, direccion, id_sucursal) values(empleado_id, empleado_nombre1, empleado_nombre2, empleado_apellido1, empleado_apellido2, empleado_email, empleado_cedula, empleado_celular, empleado_ciudad_residencia, empleado_direccion, empleado_sucursal);
	else
		select 'error: la sucursal no existe bro...' as mensaje;
	end if;
end//
delimiter ;
call registrar_empleado(102, 'Cristiano', 'nose', 'Ronaldo', 'nose', 'elBichoSiuu@gmail.com', '7777777777', '123432177', 'niidea', 'sisas', 100);

## Actualizar empleados ya existentes
delimiter //
create procedure actualizar_empleado(empleado_id int, n_empleado_id int, empleado_nombre1 varchar(25), empleado_nombre2 varchar(25), empleado_apellido1 varchar(25), empleado_apellido2 varchar(25), empleado_email varchar(25), empleado_cedula varchar(25), empleado_celular varchar(25), empleado_ciudad_residencia varchar(25), empleado_direccion varchar(25), empleado_sucursal int)
begin
	update empleado set id = n_empleado_id, nombre1 = empleado_nombre1, nombre2 = empleado_nombre2, apellido1 = empleado_apellido1, apellido2 = empleado_apellido2, email = empleado_email, cedula = empleado_cedula, celular = empleado_celular, ciudad_residencia = empleado_ciudad_residencia, direccion = empleado_direccion, id_sucursal = empleado_sucursal
    where id = empleado_id;
end//
delimiter ;
call actualizar_empleado(103, 102, 'Cristiano', null,'Ronaldo', 'siuu', 'elBichoSiuu@gmail.com', '7777777777', '123432177', 'niidea', 'sisas', 99);

## registrar vehiculos
delimiter //
create procedure registrar_vehiculo(vehiculo_id int, vehiculo_color varchar(25), vehiculo_motor varchar(25), vehiculo_sunroof varchar(25), vehiculo_capacidad varchar(25), vehiculo_puertas int, vehiculo_modelo varchar(25), vehiculo_referencia varchar(25), vehiculo_placa varchar(25), vehiculo_tipo_vehiculo varchar(25))
begin
    declare tipo_vehiculo_e int;
    select count(*) into tipo_vehiculo_e from vehiculo where tipo_vehiculo = vehiculo_tipo_vehiculo;
    if tipo_vehiculo_e > 0 then
        insert into vehiculo(id, color, motor, sunroof, capacidad, puertas, modelo, referencia, placa, tipo_vehiculo)
        values(vehiculo_id, vehiculo_color, vehiculo_motor, vehiculo_sunroof, vehiculo_capacidad, vehiculo_puertas, vehiculo_modelo, vehiculo_referencia, vehiculo_placa, vehiculo_tipo_vehiculo);
        select 'Vehículo registrado exitosamente.' as mensaje;
    else
        select 'Error: El tipo de vehículo especificado no es válido.' as mensaje;
    end if;
end//
delimiter ;
call registrar_vehiculo(101, 'Rojo', 'Gasolina', 'No', '5 personas', 4, 'Sedán', '2023', 'ABC123', 'Automóvil');

## Actualizar vehiculos
delimiter //
create procedure actualizar_vehiculo( vehiculo_id int, nuevo_vehiculo_id int, vehiculo_color varchar(25), vehiculo_motor varchar(25), vehiculo_sunroof varchar(25), vehiculo_capacidad varchar(25), vehiculo_puertas int, vehiculo_modelo varchar(25), vehiculo_referencia varchar(25), vehiculo_placa varchar(25), vehiculo_tipo_vehiculo varchar(25))
begin
    update vehiculo set id = nuevo_vehiculo_id, color = vehiculo_color, motor = vehiculo_motor, sunroof = vehiculo_sunroof, capacidad = vehiculo_capacidad, puertas = vehiculo_puertas, modelo = vehiculo_modelo, referencia = vehiculo_referencia, placa = vehiculo_placa, tipo_vehiculo = vehiculo_tipo_vehiculo
    where id = vehiculo_id;
    select 'Vehículo actualizado correctamente.' as mensaje;
end//
delimiter ;
call actualizar_vehiculo(101, 102, 'Rojo', 'Gasolina', 'No', '5 personas', 4, 'Sedán', '2023', 'ABC123', 'Automóvil');

## insertar sucursales
delimiter //
create procedure insertar_sucursal(sucursal_id int, sucursal_email varchar(25), sucursal_celular varchar(25), sucursal_telefono varchar(25), sucursal_ciudad varchar(25), sucursal_direccion varchar(25))
begin
    insert into sucursales(id, email, celular, telefono, ciudad, direccion) values(sucursal_id, sucursal_email, sucursal_celular, sucursal_telefono, sucursal_ciudad, sucursal_direccion);
end//
delimiter ;

## actualizar sucursales
delimiter //
create procedure actualizar_sucursal( sucursal_id int, n_sucursal_id int, sucursal_email varchar(25), sucursal_celular varchar(25), sucursal_telefono varchar(25), sucursal_ciudad varchar(25), sucursal_direccion varchar(25))
begin
    update sucursales set id = n_sucursal_id, email = sucursal_email, celular = sucursal_celular, telefono = sucursal_telefono, ciudad = sucursal_ciudad, direccion = sucursal_direccion
    where id = sucursal_id;
end//
delimiter ;

## 	Procedimiento para consultar disponibilidad de vehículos para alquiler por tipo de vehiculo, rango de precios y fechas de disponibilidad
delimiter //
create procedure consultar_vehiculos(con_tipo_vehiculo varchar(25), con_fecha_inicio date, con_fecha_fin date, con_precio_min_dia int, con_precio_max_dia int, con_precio_min_semana int, con_precio_max_semana int)
begin
	select vehiculo.id as VehiculoID, vehiculo.color, vehiculo.motor, vehiculo.sunroof, vehiculo.capacidad, vehiculo.puertas, vehiculo.modelo, vehiculo.referencia, vehiculo.placa, vehiculo.tipo_vehiculo, alquileres.valor_alquiler_semana, alquileres.valor_alquiler_dia
    from vehiculo
    left join alquileres on vehiculo.id = alquileres.id_vehiculo
    where vehiculo.tipo_vehiculo = con_tipo_vehiculo and (alquileres.id is null or (alquileres.fecha_salida > con_fecha_fin or alquileres.fecha_llegada < con_fecha_inicio)) and ((ifnull(alquileres.valor_alquiler_dia, 0) between con_precio_min_dia and con_precio_max_dia) or (ifnull(alquileres.valor_alquiler_semana, 0) between con_precio_min_semana and con_precio_max_semana))
    order by vehiculo.id;
end//
delimiter ;
call consultar_vehiculos('Automóvil', '2024-10-01', '2024-10-10', 0, 0, 500000, 550000);

## Hacer alquiler de vehiculos
delimiter //
create procedure registrar_alquiler(alquiler_id int, fecha_salida date, fecha_llegada date, fecha_esperada_llegada date, valor_alquiler_semana int, valor_alquiler_dia int, porcentaje_descuento decimal(5,2), valor_cotizado int, valor_pagado int, vehiculo_id int, empleado_id int, cliente_id int, sucursal_salida_id int, sucursal_llegada_id int)
begin
    declare existencia_vehiculo int;
    declare existencia_empleado int;
    declare existencia_cliente int;
    declare existencia_sucursal_salida int;
    declare existencia_sucursal_llegada int;
	select count(*) into existencia_vehiculo from vehiculo where id = vehiculo_id;
    select count(*) into existencia_empleado from empleado where id = empleado_id;
    select count(*) into existencia_cliente from cliente where id = cliente_id;
    select count(*) into existencia_sucursal_salida from sucursales where id = sucursal_salida_id;
    select count(*) into existencia_sucursal_llegada from sucursales where id = sucursal_llegada_id;
    if existencia_vehiculo > 0 and existencia_empleado > 0 and existencia_cliente > 0 and existencia_sucursal_salida > 0 and existencia_sucursal_llegada > 0 then
        insert into alquileres(id, fecha_salida, fecha_llegada, fecha_esperada_llegada, valor_alquiler_semana, valor_alquiler_dia, porcentaje_descuento, valor_cotizado, valor_pagado, id_vehiculo, id_empleado, id_cliente, id_sucursal_salida, id_sucursal_llegada)
        values(alquiler_id, fecha_salida, fecha_llegada, fecha_esperada_llegada, valor_alquiler_semana, valor_alquiler_dia, porcentaje_descuento, valor_cotizado, valor_pagado, vehiculo_id, empleado_id, cliente_id, sucursal_salida_id, sucursal_llegada_id);
    else
        select 'Error: Verifique la existencia de los elementos requeridos (vehículo, empleado, cliente, sucursal de salida y llegada).' as mensaje;
    end if;
end//
delimiter ;

## Historial de alquileres por cliente
delimiter //
create function historial_alquileres(cliente_id INT) 
returns text deterministic
begin
    declare resultado TEXT;
	select
        group_concat(
            concat('alquiler id: ', alq.id,
                   ', fecha salida: ', alq.fecha_salida,
                   ', fecha llegada: ', alq.fecha_llegada,
                   ', vehículo: ', veh.placa,
                   ', empleado: ', emp.nombre1,
                   ', valor cotizado: ', alq.valor_cotizado
            ) separator '\n') into resultado
    from alquileres alq
    join vehiculo veh on alq.id_vehiculo = veh.id
    join empleado emp on alq.id_empleado = emp.id
    where alq.id_cliente = cliente_id;
    if resultado is null then
        set resultado = 'no se encontraron alquileres para este cliente.';
    end if;
    return resultado;
end //
delimiter ;

select historial_alquileres(1) as Historial;
