--PoblarOK

--Zonas Deportivas

INSERT INTO ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area) VALUES ('Zona#0001', 'Complejo Deportivo XYZ', 2, 'Calle Principal #123 - 456', 'Complejo deportivo con múltiples instalaciones.', '50m x 100m');
INSERT INTO ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area) VALUES ('Zona#0002', 'Centro Deportivo ABC', 1, 'Avenida Deportiva #789 - 1011', 'Centro deportivo con enfoque en deportes acuáticos.', '30m x 70m');
INSERT INTO ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area) VALUES ('Zona#0003', 'Polideportivo 123', 1, 'Carrera Deportiva #1213 - 1415', 'Polideportivo con amplias áreas verdes.', '80m x 120m');

--Canchas

INSERT INTO Canchas (IDCancha, IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('No.0000001', 'Zona#0001', 10, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 5');
INSERT INTO Canchas (IDCancha, IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('No.0000002', 'Zona#0001', 10, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 5');
INSERT INTO Canchas (IDCancha, IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('No.0000001', 'Zona#0002', 8, 'Mantenimiento', '15m x 30m', 'Baloncesto', 'Cancha de Baloncesto');
INSERT INTO Canchas (IDCancha, IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('No.0000001', 'Zona#0003', 12, 'Activa', '25m x 50m', 'Tenis', 'Cancha de Tenis');

--Tarifas

INSERT INTO Tarifas (IDTarifa, dia, horaInicio, horaFin, precio) VALUES ('No.0000001', 'Lunes', '08:00', '12:00', 200000);
INSERT INTO Tarifas (IDTarifa, dia, horaInicio, horaFin, precio) VALUES ('No.0000002', 'Martes', '18:00', '22:00', 90000);
INSERT INTO Tarifas (IDTarifa, dia, horaInicio, horaFin, precio) VALUES ('No.0000003', 'Miercoles', '15:00', '18:00', 75000);
INSERT INTO Tarifas (IDTarifa, dia, horaInicio, horaFin, precio) VALUES ('No.0000004', 'Jueves', '18:00', '20:00', 80000);

--TarifasPorCancha

INSERT INTO TarifasPorCancha (IDTarifa, IDCancha, IDZona) VALUES ('No.0000001', 'No.0000001', 'Zona#0001');
INSERT INTO TarifasPorCancha (IDTarifa, IDCancha, IDZona) VALUES ('No.0000001', 'No.0000002', 'Zona#0001');
INSERT INTO TarifasPorCancha (IDTarifa, IDCancha, IDZona) VALUES ('No.0000002', 'No.0000001', 'Zona#0001');
INSERT INTO TarifasPorCancha (IDTarifa, IDCancha, IDZona) VALUES ('No.0000003', 'No.0000003', 'Zona#0002');
INSERT INTO TarifasPorCancha (IDTarifa, IDCancha, IDZona) VALUES ('No.0000004', 'No.0000004', 'Zona#0003');

--Adicionales

INSERT INTO Adicionales (IDAdicional, nombre, cantidad, precio, disponibilidad) VALUES ('AD0000001', 'BALON', 2, 100000, 1);
INSERT INTO Adicionales (IDAdicional, nombre, cantidad, precio, disponibilidad) VALUES ('AD0000002', 'PETO', 1, 30000, 0);
INSERT INTO Adicionales (IDAdicional, nombre, cantidad, precio, disponibilidad) VALUES ('AD0000003', 'TENIS', 4, 200000, 1);

--Partidos

INSERT INTO Partidos (IDPartido, resultado) VALUES ('No.0000001', '3-2');
INSERT INTO Partidos (IDPartido, resultado) VALUES ('No.0000002', '6-6');
INSERT INTO Partidos (IDPartido, resultado) VALUES ('No.0000003', '104-98');

--Equipos

INSERT INTO Equipos (IDEquipo, nombre, numeroIntegrantes) VALUES ('No.0000001', 'Real Madrid', 1);
INSERT INTO Equipos (IDEquipo, nombre, numeroIntegrantes) VALUES ('No.0000002', 'Yankees', 1);
INSERT INTO Equipos (IDEquipo, nombre, numeroIntegrantes) VALUES ('No.0000003', 'Roger Federer', 1);

--EquiposJueganPartidos

INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000001', 'No.0000001');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000003', 'No.0000002');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000002', 'No.0000003');

--Jugadores

INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000987654', 'Cristian David', 'Polo Garrido', 'crispo5124@gmail.com', 'Masculino', 'No.0000001');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CE', '1010123457', 'Samuel Felipe', 'Diaz Mamanche', 'samuel.diaz@gmail.com', 'Masculino', 'No.0000002');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('TI', '1001234567', 'Maria Fernanda', 'Gonzalez Garcia', 'margon562@outlook.com', 'Femenino', 'No.0000003');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000012345', 'Andres David', 'Monroy Jimenez', 'monroyj@gmail.com', 'Masculino', NULL);--Encargado
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000023456', 'Santiago Nicolas', 'Ochoa Lopez', 'ochoal@gmail.com', 'Masculino', NULL);--Encargado
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000034567', 'Daniel Esteban', 'Rodriguez', 'rodri10@outlook.com', 'Masculino', NULL);--Encargado

--TelefonosPorJugador

INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000987654', 3001234567);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000987654', 3171234567);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CE', '1010123457', 3151234567);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('TI', '1001234567', 3161234567);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000012345', 3191234567);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000023456', 3201234567);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000034567', 3211234567);

--Encargados

INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000012345', TO_DATE('2014-08-30','YYYY-MM-DD'), 'https://www.Fotos/AndresDavid.jpg', 'Pregrado', 9, 'Zona#0001');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000023456', TO_DATE('2020-11-03','YYYY-MM-DD'), 'https://www.santiagoN/foto.jpg', 'Maestria', 3, 'Zona#0002');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000034567', TO_DATE('2022-05-13','YYYY-MM-DD'), 'https://DanielEs.png', 'Doctorado', 2, 'Zona#0003');

--Calificaciones

INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('TI', '1001234567', 4, 'Muy buen asesor pero se le forman filas prolongadas.', 'CC', '1000012345');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000987654', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000023456');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CE', '1010123457', 5, 'El asesor es muy bueno, se nota que ama su trabajo.', 'CC', '1000034567');

--Reservaciones -- NECESITAMOS LA HORA DE INICIO DEL JUEGO CUANDO SE RESERVA UNA CANCHA, HAY QUE COLOCAR UN NUEVO ATRIBUTO HORAINICIO ó COLOCAR TIMESTAMP PARA TENER FECHA Y HORA AL MISMO TIEMPO
                -- LOS PAGOS NO ESTÁN ASOCIADOS A LAS RESERVACIONES Y POR ELLO SON NULL, HAY QUE CREAR UNA DEPENDENCIA ENTRE EL ESTADO DE LA RESERVA Y EL ESTADO DEL PAGO, CUANDO EL PAGO ESTE "APROBADO" LA RESERVA CAMBIA A "COMPLETADA" Y SE AGREGA LA RELACION CON EL PAGO
    --De Canchas
INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('No.0000001', 'Completada', TO_DATE('2024-04-01','YYYY-MM-DD'), TO_DATE('2024-04-10','YYYY-MM-DD'), '2:00 h', 'CC', '1000987654', 'No.0000001', 'No.0000001', NULL);
INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('No.0000002', 'Procesando', TO_DATE('2024-03-27','YYYY-MM-DD'), TO_DATE('2024-04-02','YYYY-MM-DD'), '1:30 h', 'CE', '1010123457', 'No.0000002', 'No.0000003', NULL);
INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('No.0000003', 'Cancelada', TO_DATE('2024-03-30','YYYY-MM-DD'), TO_DATE('2024-04-15','YYYY-MM-DD'), '3:00 h', 'TI', '1001234567', 'No.0000003', 'No.0000002', NULL);
    --De Adicionales
INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('No.0000004', 'Completada', TO_DATE('2024-05-01','YYYY-MM-DD'), TO_DATE('2024-06-10','YYYY-MM-DD'), '2:00 h', 'CC', '1000987654', NULL, NULL, NULL);
INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('No.0000005', 'Completada', TO_DATE('2024-05-27','YYYY-MM-DD'), TO_DATE('2024-06-02','YYYY-MM-DD'), '2:30 h', 'CE', '1010123457', NULL, NULL, NULL);
INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('No.0000006', 'Completada', TO_DATE('2024-05-30','YYYY-MM-DD'), TO_DATE('2024-06-15','YYYY-MM-DD'), '4:00 h', 'TI', '1001234567', NULL, NULL, NULL);

--Pagos

INSERT INTO Pagos (IDPago, estado, metodo) VALUES ('Fact_No.1', 'Aprobado', 'Efectivo');
INSERT INTO Pagos (IDPago, estado, metodo) VALUES ('Fact_No.2', 'Procesando', 'Tarjeta de Debito');
INSERT INTO Pagos (IDPago, estado, metodo) VALUES ('Fact_No.3', 'Rechazado', 'Tarjeta de Credito');
INSERT INTO Pagos (IDPago, estado, metodo) VALUES ('Fact_No.4', 'Aprobado', 'Tarjeta de Credito');
INSERT INTO Pagos (IDPago, estado, metodo) VALUES ('Fact_No.5', 'Aprobado', 'Tarjeta de Credito');
INSERT INTO Pagos (IDPago, estado, metodo) VALUES ('Fact_No.6', 'Aprobado', 'Tarjeta de Credito');

--AdicionalesPorReservaciones

INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDReserva) VALUES ('AD0000001', 'No.0000004');
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDReserva) VALUES ('AD0000002', 'No.0000005');
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDReserva) VALUES ('AD0000003', 'No.0000006');