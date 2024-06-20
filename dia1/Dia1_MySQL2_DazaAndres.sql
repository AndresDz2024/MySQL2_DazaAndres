-- ####################################
-- ### DIA #1 - Consultas - MySQL2 ####
-- ####################################

create database dia1;

use dia1;

create table persona(
    id int(10) primary key,
    nombre varchar(25) not null,
    direccion varchar(50) not null,
    telefono varchar(20) not null,
    poblacion varchar(50) not null,
    provincia varchar(50) not null,
    codigo_postal varchar(10) not null,
    nif varchar(20) not null,
    numero_seguridad_social varchar(15) not null
);

create table empleado(
    id int(10) primary key,
    tipo enum("ATS", "ATS de zona", "Auxiliar de enfermería", "Celador", "Administrativo") not null,
    foreign key (id) references persona(id)
);

create table medico(
    id int(10) primary key,
    numero_colegiado  varchar(20) not null,
    tipo enum("Titular", "Interino", "Sustituto") not null,
    foreign key (id) references persona(id)
);

create table paciente(
    id int(10) primary key,
    id_medico_asignado int(10),
    foreign key (id) references persona(id),
    foreign key (id_medico_asignado) references medico(id)
);

create table consulta(
    id_consulta int(10) primary key,
    id_medico int(10) not null,
    dia_semana enum("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo") not null,
    hora_inicio time not null,
    hora_final time not null,
    foreign key (id_medico) references medico(id)
);

create table medico_sustituto(
    id_medico int(10) primary key,
    fecha_alta date not null,
    fecha_baja date not null,
    foreign key (id_medico) references medico(id)
);

create table vacaciones(
    id_vacacion int(10) primary key,
    id_empleado int(10) not null,
    fecha_inicio date not null,
    fecha_final date not null,
    estado enum("Planificada", "Disfrutada") not null,
    foreign key (id_empleado) references persona(id)
);

INSERT INTO persona (id, nombre, direccion, telefono, poblacion, provincia, codigo_postal, nif, numero_seguridad_social)
VALUES 
(1, 'Dr. Carlos Hernandez', 'Calle Mayor 5', '654321098', 'Madrid', 'Madrid', '28013', 'NIF201', 'SS301'),
(2, 'Dra. Laura Gonzalez', 'Avenida de América 12', '789012345', 'Barcelona', 'Barcelona', '08015', 'NIF202', 'SS302'),
(3, 'Beatriz Martinez', 'Calle Gran Vía 10', '890123456', 'Valencia', 'Valencia', '46020', 'NIF203', 'SS303'),
(4, 'Andres Lopez', 'Paseo de la Castellana 22', '901234567', 'Madrid', 'Madrid', '28046', 'NIF204', 'SS304'),
(5, 'Sofia Ramirez', 'Calle Colón 15', '012345678', 'Sevilla', 'Sevilla', '41012', 'NIF205', 'SS305'),
(6, 'Alejandro Fernandez', 'Avenida Diagonal 25', '123456789', 'Barcelona', 'Barcelona', '08022', 'NIF206', 'SS306'),
(7, 'Dra. Lucia Vega', 'Calle Serrano 30', '234567890', 'Madrid', 'Madrid', '28004', 'NIF207', 'SS307'),
(8, 'Diego Morales', 'Avenida Blasco Ibáñez 35', '345678901', 'Valencia', 'Valencia', '46008', 'NIF208', 'SS308'),
(9, 'Valentina Ruiz', 'Calle San Fernando 40', '456789012', 'Sevilla', 'Sevilla', '41003', 'NIF209', 'SS309'),
(10, 'Gabriel Soto', 'Gran Vía de les Corts Catalanes 45', '567890123', 'Barcelona', 'Barcelona', '08010', 'NIF210', 'SS310'),
(11, 'Martina Castillo', 'Calle del Príncipe 50', '678901234', 'Madrid', 'Madrid', '28012', 'NIF211', 'SS311'),
(12, 'Samuel Herrera', 'Calle del Marqués de Larios 55', '789012346', 'Málaga', 'Málaga', '29005', 'NIF212', 'SS312'),
(13, 'Elena Muñoz', 'Calle de Alcalá 60', '890123457', 'Madrid', 'Madrid', '28002', 'NIF213', 'SS313'),
(14, 'Javier Ortega', 'Avenida de la Constitución 70', '901234568', 'Sevilla', 'Sevilla', '41018', 'NIF214', 'SS314'),
(15, 'Natalia Flores', 'Calle Larios 80', '012345679', 'Málaga', 'Málaga', '29010', 'NIF215', 'SS315');

INSERT INTO empleado (id, tipo)
VALUES 
(3, 'Celador'),
(4, 'Auxiliar de enfermería'),
(5, 'Administrativo'),
(6, 'ATS');

INSERT INTO medico (id, numero_colegiado, tipo)
VALUES 
(1, 'Colegio45', 'Interino'),
(2, 'Colegio23', 'Titular'),
(7, 'Colegio12', 'Sustituto');

INSERT INTO paciente (id, medico_asignado)
VALUES 
(8, 2),
(9, 2),
(10, 1),
(11, 7),
(12, 1),
(13, 7),
(14, 1),
(15, 7);

INSERT INTO medico_sustituto (id_medico, fecha_alta, fecha_baja)
VALUES 
(7, '2024-01-01', '2024-03-01');

INSERT INTO consulta (id_consulta, id_medico, dia_semana, hora_inicio, hora_final)
VALUES 
(1, 1, 'Lunes', '10:00:00', '11:00:00'),
(2, 7, 'Martes', '10:00:00', '11:30:00'),
(3, 7, 'Miércoles', '11:00:00', '12:00:00'),
(4, 2, 'Miércoles', '04:00:00', '05:00:00'),
(5, 2, 'Martes', '12:00:00', '12:30:00'),
(6, 7, 'Lunes', '02:00:00', '03:30:00'),
(7, 2, 'Jueves', '05:00:00', '6:00:00'),
(8, 1, 'Viernes', '09:30:00', '10:00:00'),
(9, 7, 'Jueves', '05:40:00', '06:40:00'),
(10, 1, 'Jueves', '07:00:00', '08:30:00');

INSERT INTO vacaciones(id_vacacion, id_empleado, fecha_inicio, fecha_final, estado)
VALUES 
(1, 1, '2024-07-01', '2024-07-10', 'Planificada'),
(2, 1, '2024-01-15', '2024-01-25', 'Disfrutada'),
(3, 4, '2024-08-01', '2024-08-15', 'Planificada'),
(4, 5, '2024-09-01', '2024-09-20', 'Disfrutada'),
(5, 6, '2024-10-01', '2024-10-12', 'Disfrutada');

INSERT INTO vacaciones(id_vacacion, id_empleado, fecha_inicio, fecha_final, estado)
VALUES 
(1, 1, '2024-07-01', '2024-07-10', 'Planificada'),
(2, 1, '2024-01-15', '2024-01-25', 'Disfrutada'),
(3, 4, '2024-08-01', '2024-08-15', 'Planificada'),
(4, 5, '2024-09-01', '2024-09-20', 'Disfrutada'),
(5, 6, '2024-10-01', '2024-10-12', 'Disfrutada'),
(6, 2, '2024-06-01', '2024-06-15', 'Planificada'),
(7, 3, '2024-03-01', '2024-03-10', 'Disfrutada'),
(8, 7, '2024-11-01', '2024-11-15', 'Planificada'),
(9, 2, '2024-12-01', '2024-12-10', 'Planificada');

#### consultas ####
-- Consulta para obtener el número de pacientes asignados a cada médico
SELECT m.id AS id_medico, p.nombre AS nombre_medico, COUNT(pa.id) AS numero_de_pacientes
FROM medico m
JOIN persona p ON m.id = p.id
LEFT JOIN paciente pa ON m.id = pa.id_medico_asignado
GROUP BY m.id, p.nombre
ORDER BY m.id;

-- Consulta para obtener el total de días de vacaciones planificadas y disfrutadas por empleado
SELECT p.id AS id_empleado, p.nombre AS nombre_empleado,
       SUM(DATEDIFF(v.fecha_final, v.fecha_inicio) + 1) AS total_dias_planificadas,
       SUM(CASE WHEN v.estado = 'Disfrutada' THEN DATEDIFF(v.fecha_final, v.fecha_inicio) + 1 ELSE 0 END) AS total_dias_disfrutadas
FROM vacaciones v
JOIN persona p ON v.id_empleado = p.id
GROUP BY p.id, p.nombre
ORDER BY p.id;

-- Consulta para obtener la cantidad de horas de consulta por médico, ordenados de mayor a menor
SELECT m.id AS id_medico, p.nombre AS nombre_medico,
       SUM(TIMESTAMPDIFF(HOUR, c.hora_inicio, c.hora_final)) AS horas_consulta_semana
FROM medico m
JOIN consulta c ON m.id = c.id_medico
JOIN persona p ON m.id = p.id
GROUP BY m.id, p.nombre
ORDER BY horas_consulta_semana DESC;

-- Consulta para obtener el número de sustituciones realizadas por cada médico sustituto
-- Consulta para obtener el número de sustituciones realizadas por cada médico sustituto
SELECT s.id_medico, p.nombre, COUNT(*) as numero_de_sustituciones
FROM medico_sustituto s
JOIN persona p ON s.id_medico = p.id
GROUP BY s.id_medico, p.nombre;

-- Consulta para contar cuántos médicos están actualmente en sustitución
SELECT COUNT(*) AS medicos_en_sustitucion
FROM medico_sustituto;

-- Consulta para obtener las horas totales de consulta por médico por día de la semana
SELECT c.id_medico, p.nombre, c.dia_semana,
       SUM(TIMESTAMPDIFF(HOUR, c.hora_inicio, c.hora_final)) AS horas_totales
FROM consulta c
JOIN persona p ON c.id_medico = p.id
GROUP BY c.id_medico, p.nombre, c.dia_semana;

-- Consulta para encontrar el médico con la mayor cantidad de pacientes asignados
SELECT m.id AS id_medico, p.nombre, COUNT(pa.id) AS numero_de_pacientes
FROM medico m
JOIN persona p ON m.id = p.id
LEFT JOIN paciente pa ON m.id = pa.id_medico_asignado
GROUP BY m.id, p.nombre
ORDER BY numero_de_pacientes DESC
LIMIT 1;

-- Consulta para encontrar empleados con más de 10 días de vacaciones disfrutadas
SELECT e.id AS id_empleado, p.nombre, SUM(DATEDIFF(v.fecha_final, v.fecha_inicio) + 1) AS dias_disfrutados
FROM empleado e
JOIN persona p ON e.id = p.id
JOIN vacaciones v ON e.id = v.id_empleado
WHERE v.estado = 'Disfrutada'
GROUP BY e.id, p.nombre
HAVING dias_disfrutados > 10;

-- Consulta para obtener los médicos que están actualmente realizando una sustitución
SELECT s.id_medico, p.nombre
FROM medico_sustituto s
JOIN persona p ON s.id_medico = p.id
WHERE s.fecha_baja IS NULL OR s.fecha_baja > CURDATE();

-- Consulta para obtener el promedio de horas de consulta por médico por día de la semana
SELECT c.id_medico, p.nombre, c.dia_semana,
       AVG(TIMESTAMPDIFF(HOUR, c.hora_inicio, c.hora_final)) AS promedio_horas
FROM consulta c
JOIN persona p ON c.id_medico = p.id
GROUP BY c.id_medico, p.nombre, c.dia_semana;


-- Desarrollado por Andres Daza / T.I. 1095916023

