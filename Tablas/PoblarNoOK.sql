--PoblarNoOK

--Tarifas
--Fallara ya que el dia no esta en el rango de valores permitidos
insert into Tarifas (IDTarifa, dia, horaInicio, horaFin, precio) values ('FUT000', 'Abril', '6:00', '8:00', 89000)

--ZonasDeportivas
--Nos va a saltar un error ya que establecimos como valor nulo el atributo correspondiente al identificador de la zona deportiva (IDZona)
insert into ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area) values (null, 'El Campin', 15, 'Carrera 30 # 57', 'Lote de canchas sinteticas de futbol 5 al aire libre ubicado en Bogota D.C.', '105m x 68m')

--Canchas
--Manda error ya que el IDTarifa no existe en la tabla Tarifas
insert into Canchas (IDCancha, capacidadJugadores, estado, dimensiones, IDZona, descripcion, deporte, idTarifa) values ('FUT110', 10, 'Activa', '25m * 7m', 'BOG001', 'Cancha sintetica de futbol 5 al aire libre', 'Futbol', 'FUT009');

--Adicionales
--Nos va a saltar un error porque la disponibilidad no esta en el rango de valores permitidos
insert into Adicionales (IDAdicional, cantidad, precio, disponibilidad) values ('AD0001', 1, 99000, 2);

--Partidos
--Fallara porque el IDPartido no cumple con el formato establecido
insert into Partidos (IDPartido, resultado) values ('FUTBOL', '3-2');

--Equipos
--No va a permitir la insercion porque el nombre del equipo debe ser unico
insert into Equipos (IDEquipo, nombre, numeroIntegrantes) values ('FUT999', 'Real Madrid', 11);

--EquiposJueganPartidos
--Va a fallar ya que el IDPartido no existe en la tabla Partidos
insert into EquiposJueganPartidos (IDEquipo, IDPartido) values ('FUT501', 'FUT589');

--Pagos
--Nos va a saltar un error ya que el metodo de pago no esta en el rango de valores permitidos
insert into Pagos (IDPago, estado, metodo) values ('534361251234', 'Aprobado', 'Paypal');

--Jugadores
--Fallara ya que se esta haciendo referencia a un IDEquipo que no existe en la tabla Equipos
insert into Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) values ('CC', '1009123456', 'Armando Rafael', 'Mejia Orjuela', null, 'Masculino', 'FUT345');

--TelefonosPorJugador
--No permite ya que se esta intentando insertar un telefono que ya ha sido insertado por el mismo jugador
insert into TelefonosPorJugador (tidJugador, nidJugador, telefono) values ('CC', '1010123456', 3001234567);

--Encargados
--Va a dar error porque la foto no cumple con el formato establecido
insert into Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, aniosExperiencia, IDZona) values ('TI', '1001234567', TO_DATE('2022-05-13','YYYY-MM-DD'), 'MariaGonzalez.pdf', 'Doctorado', 2, 'MED005');

--Calificaciones
--Nos va a saltar un error ya que la calificacion no esta en el rango de valores permitidos
insert into Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) values ('CC', '1010123456', 6, 'Muy buen asesor pero se le forman filas prolongadas.', 'CC', '1010123456');

--Reservaciones
--Fallara porque el IDReserva debe ser unico por lo que es la llave primaria pero ya se encuentra en la tabla
insert into Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('FUT001', 'Hecha', TO_DATE('2024-04-01','YYYY-MM-DD'), TO_DATE('2024-04-10','YYYY-MM-DD'), '2:00 h', 'CC', '1010123456', 'FUT001', 'FUT534', '123456789101');

--AdicionalesPorReservaciones
--Nos va a saltar un error ya que el IDAdicional no cumple con el formato establecido
insert into AdicionalesPorReservaciones (IDAdicional, IDReserva) values ('A0101F', 'FUT001');