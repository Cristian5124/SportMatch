--PoblarOK

--Tarifas

insert into Tarifas (IDTarifa, dia, horaInicio, horaFin, precio) values ('FUT001', 'Lunes', '6:00', '8:00', 89000);
insert into Tarifas (IDTarifa, dia, horaInicio, horaFin, precio) values ('BAS001', 'Martes', '8:00', '10:00', 450000);
insert into Tarifas (IDTarifa, dia, horaInicio, horaFin, precio) values ('TEN001', 'Miercoles', '10:00', '12:00', 50000);
insert into Tarifas (IDTarifa, dia, horaInicio, horaFin, precio) values ('TEN002', 'Jueves', '12:00', '13:00', 25000);

--Zonas Deportivas

insert into ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area) values ('BOG001', 'El Campin', 0, 'Carrera 30 # 57 - 09', 'Lote de canchas sinteticas de futbol 5 al aire libre ubicado en Bogota D.C.', '105m * 68m');
insert into ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area) values ('BAQ003', 'Metropolitano', 0, 'Calle 46 # 1s - 45', 'Lote de zona para juegos de beisbol en estadio ubicado en Barranquilla.', '250m * 100m');
insert into ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area) values ('MED005', 'Atanasio Girardot', 0, 'Calle 74 # 48 - 23', 'Lote de canchas de arena para juegos de tennis en Medellin.', '75m * 45m');

--Canchas

insert into Canchas (IDCancha, capacidadJugadores, estado, dimensiones, IDZona, descripcion, deporte, idTarifa) values ('FUT001', 10, 'Activa', '25m * 7m', 'BOG001', 'Cancha sintetica de futbol 5 al aire libre', 'Futbol', 'FUT001');
insert into Canchas (IDCancha, capacidadJugadores, estado, dimensiones, IDZona, descripcion, deporte, idTarifa) values ('BAS001', 18, 'Activa', '100m * 100m', 'BAQ003', 'Cancha de baseball profesional con capacidad para 18 jugadores', 'Baseball', 'BAS001');
insert into Canchas (IDCancha, capacidadJugadores, estado, dimensiones, IDZona, descripcion, deporte, idTarifa) values ('TEN001', 4, 'Activa', '25m * 7m', 'MED005', 'Cancha de pavimento para tennis con maya de altura intermedia', 'Tennis', 'TEN001');
insert into Canchas (IDCancha, capacidadJugadores, estado, dimensiones, IDZona, descripcion, deporte, idTarifa) values ('TEN002', 4, 'Mantenimiento', '25m * 7m', 'MED005', 'Cancha de pavimento para tennis con maya de altura intermedia', 'Tennis', 'TEN002');

--Adicionales

insert into Adicionales (IDAdicional, cantidad, precio, disponibilidad) values ('AD1234', 1, 99000, 1);
insert into Adicionales (IDAdicional, cantidad, precio, disponibilidad) values ('AD5678', 1, 14500, 0);
insert into Adicionales (IDAdicional, cantidad, precio, disponibilidad) values ('AD9012', 1, 25000, 1);

--Partidos

insert into Partidos (IDPartido, resultado) values ('FUT534', '3-2');
insert into Partidos (IDPartido, resultado) values ('BAS054', '13-4');
insert into Partidos (IDPartido, resultado) values ('TEN245', '6-6');

--Equipos

insert into Equipos (IDEquipo, nombre, numeroIntegrantes) values ('FUT501', 'Real Madrid', 0);
insert into Equipos (IDEquipo, nombre, numeroIntegrantes) values ('BAS009', 'Yankees', 0);
insert into Equipos (IDEquipo, nombre, numeroIntegrantes) values ('TEN205', 'Roger Federer', 0);

--EquiposJueganPartidos

insert into EquiposJueganPartidos (IDEquipo, IDPartido) values ('FUT501', 'FUT534');
insert into EquiposJueganPartidos (IDEquipo, IDPartido) values ('BAS009', 'BAS054');
insert into EquiposJueganPartidos (IDEquipo, IDPartido) values ('TEN205', 'TEN245');

--Pagos

insert into Pagos (IDPago, estado, metodo) values ('123456789101', 'Aprobado', 'Efectivo');
insert into Pagos (IDPago, estado, metodo) values ('987654321098', 'Aprobado', 'Tarjeta de Debito');
insert into Pagos (IDPago, estado, metodo) values ('103245069387', 'Procesando', 'Efectivo');

--Jugadores

insert into Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) values ('CC', '1010123456', 'Armando Rafael', 'Mejia Orjuela', 'armejia052@hotmail.com', 'Masculino', 'FUT501');
insert into Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) values ('CC', '1000987654', 'Cristian David', 'Polo Garrido', 'crispo5124@gmail.com', 'Masculino', 'BAS009');
insert into Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) values ('CC', '1010123457', 'Samuel Felipe', 'Diaz Mamanche', 'samuel.diaz@gmail.com', 'Masculino', 'TEN205');
insert into Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) values ('TI', '1001234567', 'Maria Fernanda', 'Gonzalez Garcia', 'margon562@outlook.com', 'Femenino', 'FUT501');

--TelefonosPorJugador

insert into TelefonosPorJugador (tidJugador, nidJugador, telefono) values ('CC', '1010123456', 3001234567);
insert into TelefonosPorJugador (tidJugador, nidJugador, telefono) values ('CC', '1010123456', 3151234567);
insert into TelefonosPorJugador (tidJugador, nidJugador, telefono) values ('CC', '1000987654', 3161234567);
insert into TelefonosPorJugador (tidJugador, nidJugador, telefono) values ('CC', '1010123457', 3171234567);
insert into TelefonosPorJugador (tidJugador, nidJugador, telefono) values ('TI', '1001234567', 3181234567);

--Encargados

insert into Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, aniosExperiencia, IDZona) values ('CC', '1010123456', TO_DATE('2014-08-30','YYYY-MM-DD'), 'https://www.Fotos/ArmandoMejia.jpg', 'Pregrado', 9, 'BOG001');
insert into Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, aniosExperiencia, IDZona) values ('CC', '1000987654', TO_DATE('2020-11-03','YYYY-MM-DD'), 'https://www.cristianpolo/foto.jpg', 'Maestria', 3, 'BAQ003');
insert into Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, aniosExperiencia, IDZona) values ('CC', '1010123457', TO_DATE('2022-05-13','YYYY-MM-DD'), 'https://SamuelDiaz.png', 'Doctorado', 2, 'MED005');

--Calificaciones

insert into Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) values ('TI', '1001234567', 4, 'Muy buen asesor pero se le forman filas prolongadas.', 'CC', '1010123456');
insert into Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) values ('CC', '1000987654', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1010123457');
insert into Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) values ('CC', '1010123457', 5, 'El asesor es muy bueno, se nota que ama su trabajo.', 'CC', '1000987654');

--Reservaciones

insert into Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('FUT001', 'Hecha', TO_DATE('2024-04-01','YYYY-MM-DD'), TO_DATE('2024-04-10','YYYY-MM-DD'), '2:00 h', 'CC', '1010123456', 'FUT001', 'FUT534', '123456789101');
insert into Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('BAS001', 'Cumplida', TO_DATE('2024-03-27','YYYY-MM-DD'), TO_DATE('2024-04-02','YYYY-MM-DD'), '1:30 h', 'CC', '1000987654', 'BAS001', 'BAS054', '987654321098');
insert into Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('TEN015', 'Hecha', TO_DATE('2024-03-30','YYYY-MM-DD'), TO_DATE('2024-04-15','YYYY-MM-DD'), '3:00 h', 'CC', '1010123457', 'TEN001', 'TEN245', '103245069387');

--AdicionalesPorReservaciones

insert into AdicionalesPorReservaciones (IDAdicional, IDReserva) values ('AD1234', 'FUT001');
insert into AdicionalesPorReservaciones (IDAdicional, IDReserva) values ('AD5678', 'BAS001');
insert into AdicionalesPorReservaciones (IDAdicional, IDReserva) values ('AD9012', 'TEN015');