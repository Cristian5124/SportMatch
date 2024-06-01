----------------------- INDICES -----------------------

CREATE INDEX IDX_Reservaciones_FechaReservacion ON Reservaciones(fechaReservacion);

CREATE INDEX IDX_Canchas_Deporte ON Canchas(deporte);

CREATE INDEX IDX_Adicionales_Nombre ON Adicionales(nombre);

CREATE INDEX IDX_ZonasDeportivas_Nombre ON ZonasDeportivas(nombre);

CREATE INDEX IDX_ZonasDeportivas_Direccion ON ZonasDeportivas(direccion);

------------------VISTAS-------------------

--VISTA DE JUGADORES:
CREATE OR REPLACE VIEW VISTA_JUGADORES AS
SELECT
    tid,
    nid,
    nombre,
    apellido,
    correo,
    sexo,
    IDEquipo
FROM Jugadores;
/

--VISTA DE DISPONIBILIDAD DE CANCHAS:
CREATE OR REPLACE VIEW VISTA_DISPONIBILIDAD_CANCHAS AS
SELECT
    c.IDCancha,
    c.IDZona,
    c.capacidadJugadores,
    c.deporte,
    t.precio,
    z.nombre AS nombreZona
FROM Canchas c
JOIN Tarifas t ON c.IDCancha = t.IDCancha AND c.IDZona = t.IDZona
JOIN ZonasDeportivas z ON c.IDZona = z.IDZona
WHERE c.estado = 'Activa';
/

--VISTA DEL ESTADO DE LA RESERVACION:
CREATE OR REPLACE VIEW VISTA_ESTADO_RESERVACION AS
SELECT
    r.IDReserva,
    r.fechaReservacion,
    r.tiempoTotal,
    r.estado,
    c.IDCancha,
    c.capacidadJugadores,
    c.deporte,
    z.IDZona,
    z.nombre AS nombreZona
FROM Reservaciones r
JOIN Canchas c ON r.IDCancha = c.IDCancha
JOIN ZonasDeportivas z ON c.IDZona = z.IDZona;
/

--VISTA DEL ESTADO DEL PAGO:
CREATE OR REPLACE VIEW VISTA_ESTADO_PAGO AS
SELECT
    p.IDPago,
    p.metodo,
    p.fechaPago,
    p.estado
FROM Pagos p;
/

--VISTA DEL TOTAL PARA LA RESERVA ESPECIFICA:
CREATE OR REPLACE VIEW VISTA_TOTAL_RESERVA_ESPECIFICA AS
SELECT
    r.IDReserva,
    t.precio * r.tiempoTotal AS total
FROM Reservaciones r
JOIN Tarifas t ON r.IDCancha = t.IDCancha AND r.IDZona = t.IDZona;
/

DROP VIEW VISTA_JUGADORES;
DROP VIEW VISTA_DISPONIBILIDAD_CANCHAS;
DROP VIEW VISTA_ESTADO_RESERVACION;
DROP VIEW VISTA_ESTADO_PAGO;
DROP VIEW VISTA_TOTAL_RESERVA_ESPECIFICA;