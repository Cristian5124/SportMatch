--Tuplas

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_fechaSolicitud_fechaReservacion CHECK (fechaSolicitud <= fechaReservacion);