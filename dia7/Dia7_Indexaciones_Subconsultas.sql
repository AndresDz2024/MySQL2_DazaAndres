-- ##############################
-- ###### DIA 7 - MySQL 2  ######
-- ##############################

use dia3;

create index index_cliente_code on cliente(codigo_cliente);

create index index_empleado_codigo on empleado(codigo_empleado);

select cliente.nombre_cliente, cliente.telefono, cliente.ciudad, empleado.nombre, empleado.apellido1, empleado.email, empleado.puesto
from cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
where empleado.puesto = "Representante Ventas";

create index index_pedido_codigo on pedido(codigo_pedido);

select pedido.codigo_pedido, pedido.fecha_pedido, pedido.fecha_entrega, pedido.estado, pedido.comentarios, pedido.codigo_cliente
from pedido
where pedido.fecha_pedido between '2009-03-15' and '2009-07-15'
and pedido.codigo_cliente in (select cliente.codigo_cliente from cliente where cliente.ciudad = 'Sotogrande');

create index index_producto_codigo on producto(codigo_producto, gama, proveedor);

create index index_dp_codigo on producto(codigo_producto);

select producto.codigo_producto, producto.nombre, producto.descripcion, producto.cantidad_en_stock, (producto.precio_venta - (producto.precio_venta * 0.1)) as precio_descuento, count(detalle_pedido.codigo_producto) as cantidad_pedidos
from producto
inner join detalle_pedido on producto.codigo_producto = detalle_pedido.codigo_producto
where producto.gama = "Frutales" and producto.proveedor = "Frutales Talavera S.A"
group by producto.codigo_producto;

## Desarrollado por: Andres Santiago Daza Daza / T.I. 1095916023