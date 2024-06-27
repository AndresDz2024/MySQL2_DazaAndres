use AutoRental;

## Crear usuarios
create user 'empleado'@'localhost' identified by 'contraseña_empleado';
create user 'director'@'localhost' identified by 'contraseña_director';
create user 'cliente'@'localhost' identified by 'contraseña_cliente';

## permisos para usar procedimientos y funciones
grant execute on function AutoRental.historial_alquileres to 'cliente'@'localhost';
grant execute on procedure AutoRental.registrar_alquiler to 'cliente'@'localhost';
grant execute on procedure AutoRental.consultar_vehiculos to 'cliente'@'localhost';

grant execute on procedure AutoRental.insertar_sucursal to 'empleado'@'localhost';
grant execute on procedure AutoRental.actualizar_sucursal to 'empleado'@'localhost';
grant execute on procedure AutoRental.registrar_vehiculo to 'empleado'@'localhost';
grant execute on procedure AutoRental.actualizar_vehiculo to 'empleado'@'localhost';
grant execute on procedure AutoRental.registrar_cliente to 'empleado'@'localhost';
grant execute on procedure AutoRental.actualizar_cliente to 'empleado'@'localhost';

grant execute on procedure AutoRental.registrar_empleado to 'director'@'localhost';
grant execute on procedure AutoRental.actualizar_empleado to 'director'@'localhost';

## verificar privilegios de cada usuario
SHOW GRANTS FOR 'cliente'@'localhost';
SHOW GRANTS FOR 'empleado'@'localhost';
SHOW GRANTS FOR 'director'@'localhost';


