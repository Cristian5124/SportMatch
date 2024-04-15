--AccionesOK

-- Insertar la tarifa
INSERT INTO Tarifas (IDTarifa, dia, horaInicio, horaFin, precio)
VALUES ('TAR001', 'Lunes', '08:00', '18:00', 50.00);
-- Insertar una cancha asociada a la tarifa a eliminar
INSERT INTO Canchas (IDCancha, IDZona, capacidadJugadores, estado, dimensiones, descripcion, deporte, idTarifa)
VALUES ('CAN001', 'ZON001', 10, 'Disponible', '20x40', 'Cancha de fútbol', 'Fútbol', 'TAR001');
-- Eliminar una tarifa
DELETE FROM Tarifas WHERE IDTarifa = 'TAR001';
-- Verificar que las canchas asociadas sean eliminadas debido a ON DELETE CASCADE
SELECT * FROM Canchas WHERE idTarifa = 'TAR001';


-- Insertar un encargado asociado a la zona deportiva eliminada
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, aniosExperiencia, IDZona)
VALUES ('02', '9876543210', '2024-03-01', 'foto_encargado.jpg', 'Licenciatura en Educación Física', 5, 'ZON001');
-- Eliminar una zona deportiva
DELETE FROM ZonasDeportivas WHERE IDZona = 'ZON001';
-- Verificar que los encargados asociados sean eliminados debido a ON DELETE CASCADE
SELECT * FROM Encargados WHERE IDZona = 'ZON001';



-- Insertar una reserva asociada al jugador eliminado
INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona, IDPartido, IDPago)
VALUES ('RES001', 'En Proceso', '2024-04-01', '2024-04-10', '2 horas', '01', '1234567890', 'CAN001', 'ZON001', NULL, 'PAGO001');
-- Eliminar un jugador
DELETE FROM Jugadores WHERE tid = '01' AND nid = '1234567890';
-- Verificar que las reservaciones asociadas sean eliminadas debido a ON DELETE CASCADE
SELECT * FROM Reservaciones WHERE tidJugador = '01' AND nidJugador = '1234567890';


-- Insertar una calificación asociada al encargado eliminado
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado)
VALUES ('01', '1234567890', 5, 'Buen servicio', '02', '9876543210');
-- Insertar un encargado asociado a la zona deportiva eliminada
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, aniosExperiencia, IDZona)
VALUES ('02', '9876543210', '2024-03-01', 'foto_encargado.jpg', 'Licenciatura en Educación Física', 5, 'ZON001');
-- Eliminar un encargado
DELETE FROM Encargados WHERE tidJugador = '02' AND nidJugador = '9876543210';
-- Verificar que las calificaciones asociadas sean eliminadas debido a ON DELETE CASCADE
SELECT * FROM Calificaciones WHERE tidEncargado = '02' AND nidEncargado = '9876543210';