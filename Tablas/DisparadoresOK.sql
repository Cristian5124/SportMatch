--DisparadoresOK

--DisparadorOK

INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1987654320', 'Melissa', 'Rios Carvajal', 'melissa.rios@gmail.com', 'Femenino', 'FUT501');

SELECT * FROM Equipos

--DisparadorOK

DELETE FROM Jugadores
WHERE tid = 'CC' AND nid = '1987654320';

SELECT * FROM Equipos

--DisparadorOK

INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) VALUES ('FUT999', 'Cumplida', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-04-09','YYYY-MM-DD'), '2:00 h', 'CC', '1010123456', 'FUT001', 'FUT534', '123456789101');

--DisparadorOK

INSERT INTO Canchas (IDCancha, capacidadJugadores, estado, dimensiones, IDZona, descripcion, deporte, idTarifa) VALUES ('FUT133', 10, 'Activa', '25m * 7m', 'BOG001', 'Cancha sintetica de futbol 5 al aire libre', 'Futbol', 'FUT001');

SELECT * FROM ZonasDeportivas

--DisparadorOK

DELETE FROM Canchas
WHERE IDCancha = 'FUT133';

SELECT * FROM ZonasDeportivas

--DisparadorOK

DELETE FROM Canchas
WHERE IDCancha = 'FUT133';

SELECT * FROM ZonasDeportivas

--DisparadorOK

// INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) VALUES ('FUT001', 'Procesando', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-04-11','YYYY-MM-DD'), '5:00 h', 'CC', '1010123456', 'FUT001', 'FUT534', '123456789101');