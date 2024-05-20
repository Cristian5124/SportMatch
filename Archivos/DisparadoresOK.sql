--DisparadoresOK

--DisparadorOK

INSERT INTO Canchas (IDCancha, IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('No.4444444', 'Zona#0001', 10, 'Activa', '25m x 7m', 'Futbol','Cancha sintetica de futbol 5 al aire libre');

SELECT * FROM ZonasDeportivas;

--DisparadorOK

DELETE FROM Canchas
WHERE IDCancha = 'No.4444444';

SELECT * FROM ZonasDeportivas;

--DisparadorOK

INSERT INTO ZonasDeportivas (nombre, cantidadCanchas, direccion, descripcion, area) VALUES ('Polideportivo PEPESIERRA', 1, 'Carrera Deportiva #1213 - 1415', 'Polideportivo con amplias áreas verdes.', '80m x 120m');
SELECT * FROM ZonasDeportivas;

--DisparadorOK

INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0002', 14, 'Activa', '30m x 20m', 'Futbol', 'Cancha de Futbol 7');
SELECT * FROM Canchas;

--DisparadorOK

INSERT INTO Tarifas (dia, horaInicio, horaFin, precio) VALUES ('Festivo', '20:00', '24:00', 200000);
SELECT * FROM Tarifas;

--DisparadorOK

INSERT INTO Adicionales (nombre, cantidad, precio, disponibilidad) values ('MALETA', 2, 5000, 1);
SELECT * FROM Adicionales;