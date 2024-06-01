--------------------------------------------------------xTablas--------------------------------------------------------

DROP TABLE Tarifas;
DROP TABLE EquiposJueganPartidos;
DROP TABLE TelefonosPorJugador;
DROP TABLE Calificaciones;
DROP TABLE AdicionalesPorReservaciones;
DROP TABLE Reservaciones;
DROP TABLE Pagos;
DROP TABLE Encargados;
DROP TABLE Jugadores;
DROP TABLE Equipos;
DROP TABLE Canchas;
DROP TABLE Adicionales;
DROP TABLE ZonasDeportivas;
DROP TABLE Partidos;

--------------------------------------------------------Tablas--------------------------------------------------------

CREATE TABLE Tarifas (
    IDTarifa CHAR(10) NOT NULL,
    IDCancha CHAR(10) NOT NULL,
    IDZona CHAR(9) NOT NULL,
    dia VARCHAR(10) NOT NULL,
    horaInicio CHAR(5) NOT NULL,
    precio NUMBER(7) NOT NULL
);

CREATE TABLE Canchas (
    IDCancha CHAR(10) NOT NULL,
    IDZona CHAR(9) NOT NULL,
    capacidadJugadores NUMBER(2) NOT NULL,
    estado VARCHAR(15) NOT NULL,
    dimensiones VARCHAR(40) NOT NULL,
    deporte	VARCHAR(15) NOT NULL,
    descripcion	VARCHAR(100) NOT NULL
);

CREATE TABLE AdicionalesPorReservaciones (
    IDAdicional CHAR(9) NOT NULL,
    IDZona CHAR(9) NOT NULL,
    IDReserva CHAR(10) NOT NULL,
    cantidadAdicional NUMBER(2) NOT NULL
);

CREATE TABLE Adicionales (
    IDAdicional CHAR(9) NOT NULL,
    IDZona CHAR(9) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    cantidad NUMBER(3) NOT NULL,
    precioUnitario NUMBER(7) NOT NULL,
    disponibilidad NUMBER(1) NOT NULL
);

CREATE TABLE Partidos (
    IDPartido CHAR(10) NOT NULL,
    resultado VARCHAR(15) NOT NULL
);

CREATE TABLE Reservaciones (
    IDReserva CHAR(10) NOT NULL,
    estado VARCHAR(15) NOT NULL,
    fechaSolicitud DATE NOT NULL,
    fechaReservacion DATE NOT NULL,
    tiempoTotal NUMBER(2) NOT NULL,
    tidJugador CHAR(2) NOT NULL,
    nidJugador VARCHAR(10) NOT NULL,
    IDCancha CHAR(10),
    IDZona CHAR(9),
    IDPartido CHAR(10),
    IDPago CHAR(15)
);

CREATE TABLE Pagos (
    IDPago CHAR(15) NOT NULL,
    estado VARCHAR(15) NOT NULL,
    metodo VARCHAR(20) NOT NULL,
    fechaPago DATE
);

CREATE TABLE ZonasDeportivas (
    IDZona CHAR(9) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    cantidadCanchas NUMBER(2) NOT NULL,
    direccion VARCHAR(40) NOT NULL,
    descripcion VARCHAR(100),
    area VARCHAR(40) NOT NULL
);

CREATE TABLE Encargados (
    tidJugador CHAR(2) NOT NULL,
    nidJugador VARCHAR(10) NOT NULL,
    fechaContratacion DATE NOT NULL, 
    foto VARCHAR(100) NOT NULL,
    estudios VARCHAR(15) NOT NULL,
    experiencia NUMBER(2) NOT NULL,
    IDZona CHAR(9)
);

CREATE TABLE Calificaciones (
    tidJugador CHAR(2) NOT NULL,
    nidJugador VARCHAR(10) NOT NULL,
    calificacion NUMBER(1) NOT NULL,
    feedback VARCHAR(100) NOT NULL,
    tidEncargado CHAR(2) NOT NULL,
    nidEncargado VARCHAR(10) NOT NULL
);

CREATE TABLE Jugadores (
    tid CHAR(2) NOT NULL,
    nid VARCHAR(10) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    correo VARCHAR(60),
    sexo VARCHAR(10) NOT NULL,
    IDEquipo CHAR(10)
);

CREATE TABLE TelefonosPorJugador (
    tidJugador CHAR(2) NOT NULL,
    nidJugador VARCHAR(10) NOT NULL,
    telefono NUMBER(10) NOT NULL
);

CREATE TABLE Equipos (
    IDEquipo CHAR(10) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    numeroIntegrantes NUMBER(2) NOT NULL
);

CREATE TABLE EquiposJueganPartidos (
    IDEquipo CHAR(10) NOT NULL,
    IDPartido CHAR(10) NOT NULL
);

--------------------------------------------------------Llaves Primarias (PK)--------------------------------------------------------

ALTER TABLE Tarifas ADD CONSTRAINT PK_Tarifas PRIMARY KEY(IDTarifa);
ALTER TABLE Canchas ADD CONSTRAINT PK_Canchas PRIMARY KEY(IDCancha, IDZona);
ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT PK_AdicionalesPorReservaciones PRIMARY KEY(IDReserva, IDAdicional, IDZona);
ALTER TABLE Adicionales ADD CONSTRAINT PK_Adicionales PRIMARY KEY(IDAdicional, IDZona);
ALTER TABLE Partidos ADD CONSTRAINT PK_Partidos PRIMARY KEY(IDPartido);
ALTER TABLE Reservaciones ADD CONSTRAINT PK_Reservaciones PRIMARY KEY(IDReserva);
ALTER TABLE Pagos ADD CONSTRAINT PK_pagos PRIMARY KEY(IDPago);
ALTER TABLE ZonasDeportivas ADD CONSTRAINT PK_ZonasDeportivas PRIMARY KEY(IDZona);
ALTER TABLE Encargados ADD CONSTRAINT PK_Encargados PRIMARY KEY(tidJugador, nidJugador);
ALTER TABLE Calificaciones ADD CONSTRAINT PK_Calificaciones PRIMARY KEY(tidJugador, nidJugador, tidEncargado, nidEncargado);
ALTER TABLE Jugadores ADD CONSTRAINT PK_Jugadores PRIMARY KEY(tid, nid);
ALTER TABLE TelefonosPorJugador ADD CONSTRAINT PK_TelefonosPorJugador PRIMARY KEY(tidJugador, nidJugador, telefono);
ALTER TABLE Equipos ADD CONSTRAINT PK_Equipos PRIMARY KEY(IDEquipo);
ALTER TABLE EquiposJueganPartidos ADD CONSTRAINT PK_EquiposJueganPartidos PRIMARY KEY(IDEquipo, IDPartido);

--------------------------------------------------------Llaves Unicas (UK)--------------------------------------------------------

ALTER TABLE ZonasDeportivas ADD CONSTRAINT UK_ZonasDeportivas_Direccion UNIQUE(direccion);
ALTER TABLE Encargados ADD CONSTRAINT UK_Encargados UNIQUE(foto);
ALTER TABLE Jugadores ADD CONSTRAINT UK_Jugadores UNIQUE(correo);
ALTER TABLE Equipos ADD CONSTRAINT UK_Equipos UNIQUE(nombre);
ALTER TABLE Adicionales ADD CONSTRAINT UK_Adicionales UNIQUE(nombre);
ALTER TABLE Tarifas ADD CONSTRAINT UK_Tarifas UNIQUE(dia, horaInicio, IDCancha, IDZona); --AGREGADO
ALTER TABLE ZonasDeportivas ADD CONSTRAINT UK_ZonasDeportivas_Nombre UNIQUE(nombre); --AGREGADO
ALTER TABLE Reservaciones ADD CONSTRAINT UK_Reservaciones UNIQUE(fechaReservacion, IDCancha, IDZona); --AGREGADO

--------------------------------------------------------Llaves Foraneas (FK) + ACCIONES DE REFERENCIA--------------------------------------------------------

ALTER TABLE Tarifas ADD CONSTRAINT FK_Tarifas_Canchas FOREIGN KEY(IDCancha, IDZona) REFERENCES Canchas(IDCancha, IDZona) ON DELETE CASCADE;
ALTER TABLE Canchas ADD CONSTRAINT FK_Canchas_ZonasDeportivas FOREIGN KEY(IDZona) REFERENCES ZonasDeportivas(IDZona) ON DELETE CASCADE;
ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT FK_AdicionalesPorReservaciones_Adicionales FOREIGN KEY(IDAdicional, IDZona) REFERENCES Adicionales(IDAdicional, IDZona) ON DELETE CASCADE;
ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT FK_AdicionalesPorReservaciones_Reservaciones FOREIGN KEY(IDReserva) REFERENCES Reservaciones(IDReserva) ON DELETE CASCADE;
ALTER TABLE Adicionales ADD CONSTRAINT FK_Adicionales_ZonasDeportivas FOREIGN KEY(IDZona) REFERENCES ZonasDeportivas(IDZona) ON DELETE SET NULL; --AGREGADO
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Canchas FOREIGN KEY(IDCancha, IDZona) REFERENCES Canchas(IDCancha, IDZona) ON DELETE SET NULL;
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Partidos FOREIGN KEY(IDPartido) REFERENCES Partidos(IDPartido) ON DELETE SET NULL;
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Pagos FOREIGN KEY(IDPago) REFERENCES Pagos(IDPago) ON DELETE CASCADE;
ALTER TABLE Encargados ADD CONSTRAINT FK_Encargados_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE Encargados ADD CONSTRAINT FK_Encargados_ZonasDeportivas FOREIGN KEY(IDZona) REFERENCES ZonasDeportivas(IDZona) ON DELETE SET NULL;
ALTER TABLE Calificaciones ADD CONSTRAINT FK_Calificaciones_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE Calificaciones ADD CONSTRAINT FK_Calificaciones_Encargados FOREIGN KEY(tidEncargado, nidEncargado) REFERENCES Encargados(tidJugador, nidJugador) ON DELETE CASCADE;
ALTER TABLE Jugadores ADD CONSTRAINT FK_Jugadores_Equipos FOREIGN KEY(IDEquipo) REFERENCES Equipos(IDEquipo) ON DELETE SET NULL;
ALTER TABLE TelefonosPorJugador ADD CONSTRAINT FK_TelefonosPorJugador_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE EquiposJueganPartidos ADD CONSTRAINT FK_EquiposJueganPartidos_Equipos FOREIGN KEY(IDEquipo) REFERENCES Equipos(IDEquipo) ON DELETE CASCADE;
ALTER TABLE EquiposJueganPartidos ADD CONSTRAINT FK_EquiposJueganPartidos_Partidos FOREIGN KEY(IDPartido) REFERENCES Partidos(IDPartido) ON DELETE CASCADE;

--------------------------------------------------------Atributos--------------------------------------------------------

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_dia CHECK (dia IN ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo', 'Festivo'));

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_horaInicio CHECK (REGEXP_LIKE(horaInicio,'^([0-1]{1}[0-9]{1}|2[0-4]{1})(:)00')); --Solo horas 0:00, 1:00, 2:00, 3:00...24:00

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_precio CHECK (precio > 0);

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_capacidadJugadores CHECK (capacidadJugadores > 0);

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_estado CHECK (estado in ('Activa', 'Mantenimiento', 'Inactiva'));

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_dimensiones CHECK (REGEXP_LIKE(dimensiones,'^([0-9]{1,4})(m)(\s)(\x)(\s)([0-9]{1,4})(m)'));

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_deporte CHECK (deporte in ('Futbol', 'Microfutbol', 'Baloncesto', 'Tenis', 'Volleyball', 'Padel'));

ALTER TABLE Adicionales ADD CONSTRAINT CK_Adicionales_disponibilidad CHECK (disponibilidad in (0, 1));

ALTER TABLE Adicionales ADD CONSTRAINT CK_Adicionales_precioUnitario CHECK (precioUnitario > 0);

ALTER TABLE Adicionales ADD CONSTRAINT CK_Adicionales_cantidad CHECK (cantidad >= 0);

ALTER TABLE Partidos ADD CONSTRAINT CK_Partidos_resultado CHECK (REGEXP_LIKE(resultado,'^([0-9]{1,3})(-)([0-9]{1,3})'));

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_estado CHECK (estado in ('Completada', 'Cancelada', 'Procesando'));

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_tiempoTotal CHECK (tiempoTotal BETWEEN 1 AND 24); --AGREGADO

ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT CK_AdicionalesPorReservaciones_cantidadAdicional CHECK (cantidadAdicional > 0); --AGREGADO

ALTER TABLE Pagos ADD CONSTRAINT CK_Pagos_estado CHECK (estado in ('Aprobado', 'Rechazado', 'Procesando'));

ALTER TABLE Pagos ADD CONSTRAINT CK_Pagos_metodo CHECK (metodo in ('Efectivo', 'Tarjeta de Credito', 'Tarjeta de Debito', 'Transferencia', 'PSE'));

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_cantidadCanchas CHECK (cantidadCanchas >= 0);

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_direccion CHECK (direccion like ('%#%-%'));

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_area CHECK (REGEXP_LIKE(area,'^([0-9]{1,4})(m)(\s)(\x)(\s)([0-9]{1,4})(m)'));

ALTER TABLE Encargados ADD CONSTRAINT CK_Encargados_foto CHECK (foto like ('https://%.%'));

ALTER TABLE Encargados ADD CONSTRAINT CK_Encargados_estudios CHECK (estudios in ('Sin Estudios', 'Primaria', 'Secundaria', 'Pregrado', 'Tecnico', 'Maestria', 'Doctorado'));

ALTER TABLE Encargados ADD CONSTRAINT CK_Encargados_experiencia CHECK (experiencia >= 0);

ALTER TABLE Calificaciones ADD CONSTRAINT CK_Calificaciones_calificacion CHECK (calificacion in (0, 1, 2, 3, 4, 5));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_tid CHECK (tid in ('CC', 'TI', 'CE', 'PA'));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_nid CHECK (REGEXP_LIKE(nid,'^([1-9]{1})([0-9]{9})'));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_correo CHECK (correo like ('%@%.%'));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_sexo CHECK (sexo in ('Masculino', 'Femenino'));

ALTER TABLE TelefonosPorJugador ADD CONSTRAINT CK_TelefonosPorJugador_telefono CHECK (telefono >= 1000000000);

ALTER TABLE Equipos ADD CONSTRAINT CK_Equipos_numeroIntegrantes CHECK (numeroIntegrantes >= 0);

--------------------------------------------------------Tuplas--------------------------------------------------------

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_fechaSolicitud_fechaReservacion CHECK (fechaSolicitud <= fechaReservacion);

ALTER TABLE Calificaciones ADD CONSTRAINT CK_Calificaciones_tidJugador_nidJugador_tidEncargado_nidEncargado CHECK (tidJugador != tidEncargado OR nidJugador != nidEncargado);

--------------------------------------------------------Disparadores--------------------------------------------------------

--Disparador para automatizar la fechaSolicitud de reservaciones a la fecha actual

CREATE OR REPLACE TRIGGER TG_Reservaciones_BI_fechaSolicitud
BEFORE INSERT ON Reservaciones
FOR EACH ROW
BEGIN
    :NEW.fechaSolicitud := SYSDATE;
END;
/

--Disparador para aumentar la cantidad de canchas en ZonasDeportivas cuando se crea una nueva Cancha

CREATE OR REPLACE TRIGGER TG_ZonasDeportivas_AI_Aumentar_cantidadCanchas
AFTER INSERT ON Canchas
FOR EACH ROW
BEGIN
    UPDATE ZonasDeportivas
    SET cantidadCanchas = cantidadCanchas + 1
    WHERE IDZona = :NEW.IDZona;
END;
/

--Disparador para disminuir la cantidad de canchas en ZonasDeportivas cuando se elimina una Cancha

CREATE OR REPLACE TRIGGER TG_ZonasDeportivas_AI_Disminuir_cantidadCanchas
AFTER DELETE ON Canchas
FOR EACH ROW
BEGIN
    UPDATE ZonasDeportivas
    SET cantidadCanchas = cantidadCanchas - 1
    WHERE IDZona = :OLD.IDZona;
END;
/

--Disparador para garantizar que siempre las zonas arraquen con cero cantidad de canchas
CREATE OR REPLACE TRIGGER TG_ZonasDeportivas_BI_cantidadCanchas
BEFORE INSERT ON ZonasDeportivas
FOR EACH ROW
BEGIN
    :NEW.cantidadCanchas := 0;
END;
/

--Disparador para verificar que la fecha de contratación del encargado sea inferior a la fecha actual

CREATE OR REPLACE TRIGGER TG_Encargados_BIU_fechaContratacion
BEFORE INSERT OR UPDATE ON Encargados
FOR EACH ROW
BEGIN
    IF TRUNC(:NEW.fechaContratacion) > TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de contratación no puede ser posterior a la fecha actual.');
    END IF;
END;
/

-- Disparador para verificar que solo se pueda eliminar las reservaciones con estado 'Cancelada'

CREATE OR REPLACE TRIGGER TG_Reservaciones_BD
BEFORE DELETE ON Reservaciones
FOR EACH ROW
BEGIN
    IF :OLD.estado IN ('Completada', 'Procesando') THEN
        RAISE_APPLICATION_ERROR(-20203, 'NO SE PUEDE ELIMINAR ESTA RESERVACIÓN');
    END IF;
END;
/

-- Disparador para verificar que NO se puedan modificar las calificaciones

CREATE OR REPLACE TRIGGER TG_Calificaciones_BU
BEFORE UPDATE ON Calificaciones
FOR EACH ROW
BEGIN
    IF :OLD.calificacion <> :NEW.calificacion OR :OLD.feedback <> :NEW.feedback THEN
        RAISE_APPLICATION_ERROR(-20206, 'No se pueden modificar las calificaciones.');
    END IF;
END;
/

-- Disparador para verificar que NO se puedan eliminar las calificaciones

CREATE OR REPLACE TRIGGER TG_Calificaciones_BD
BEFORE DELETE ON Calificaciones
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20204, 'No se pueden eliminar las calificaciones.');
END;
/

--Disparador para verificar que solamente se pueda modificar el precio de la tarifa

CREATE OR REPLACE TRIGGER TG_Tarifas_BU
BEFORE UPDATE ON Tarifas
FOR EACH ROW
BEGIN
    IF :OLD.IDCancha != :NEW.IDCancha OR :OLD.IDZona != :NEW.IDZona OR :OLD.dia != :NEW.dia OR :OLD.horaInicio != :NEW.horaInicio THEN
        RAISE_APPLICATION_ERROR(-20205, 'Solo se puede modificar el precio de la tarifa.');
    END IF;
END;
/

--Disparador para autoincrementar el valor de IDZona

CREATE OR REPLACE TRIGGER TG_ZonasDeportivas_BI_IDZona
BEFORE INSERT ON ZonasDeportivas
FOR EACH ROW
DECLARE
    last_id NUMBER;
BEGIN
    -- Obtener el último IDZona insertado
    SELECT TO_NUMBER(SUBSTR(MAX(IDZona), 6)) INTO last_id FROM ZonasDeportivas;

    -- Incrementar el último IDZona

    --Si no se ha insertado ninguno, empieza en 0
    IF last_id IS NULL THEN
        last_id := 0;
    END IF;

    -- Generar el nuevo IDZona con 4 dígitos
    :NEW.IDZona := 'Zona#' || LPAD(last_id + 1, 4, '0');
END;
/

--Disparador para autoincrementar el valor de IDCancha

CREATE OR REPLACE TRIGGER TG_Canchas_BI_IDCancha
BEFORE INSERT ON Canchas
FOR EACH ROW
DECLARE
    last_id NUMBER;
BEGIN
    -- Obtener el último IDCancha insertado para la zona específica
    SELECT TO_NUMBER(SUBSTR(MAX(IDCancha), 4)) 
    INTO last_id 
    FROM Canchas
    WHERE IDZona = :NEW.IDZona;

    -- Incrementar el último IDCancha

    --Si no se ha insertado ninguno, empieza en 0
    IF last_id IS NULL THEN
        last_id := 0;
    END IF;

    -- Generar el nuevo IDCancha con 7 dígitos
    :NEW.IDCancha := 'No.' || LPAD(last_id + 1, 7, '0');
END;
/

--Disparador para autoincrementar el valor de IDTarifa

CREATE OR REPLACE TRIGGER TG_Tarifas_BI_IDTarifa
BEFORE INSERT ON Tarifas
FOR EACH ROW
DECLARE
    last_id NUMBER;
BEGIN
    -- Obtener el último IDTarifa insertado
    SELECT TO_NUMBER(SUBSTR(MAX(IDTarifa), 4)) INTO last_id FROM Tarifas;

    -- Incrementar el último IDTarifa

    --Si no se ha insertado ninguno, empieza en 0
    IF last_id IS NULL THEN
        last_id := 0;
    END IF;

    -- Generar el nuevo IDTarifa con 7 dígitos
    :NEW.IDTarifa := 'No.' || LPAD(last_id + 1, 7, '0');
END;
/

--Disparador para autoincrementar el valor de IDAdicional

CREATE OR REPLACE TRIGGER TG_Adicionales_BI_IDAdicional
BEFORE INSERT ON Adicionales
FOR EACH ROW
DECLARE
    last_id NUMBER;
BEGIN
    -- Obtener el último IDAdicional insertado para la zona específica
    SELECT TO_NUMBER(SUBSTR(MAX(IDAdicional), 3)) 
    INTO last_id 
    FROM Adicionales
    WHERE IDZona = :NEW.IDZona;

    -- Incrementar el último IDAdicional

    --Si no se ha insertado ninguno, empieza en 0
    IF last_id IS NULL THEN
        last_id := 0;
    END IF;

    -- Generar el nuevo IDAdicional con 7 dígitos
    :NEW.IDAdicional := 'AD' || LPAD(last_id + 1, 7, '0');
END;
/

--Disparador para autoincrementar el valor de IDPartido

CREATE OR REPLACE TRIGGER TG_Partidos_BI_IDPartido
BEFORE INSERT ON Partidos
FOR EACH ROW
DECLARE
    last_id NUMBER;
BEGIN
    -- Obtener el último IDPartido insertado
    SELECT TO_NUMBER(SUBSTR(MAX(IDPartido), 4)) INTO last_id FROM Partidos;

    -- Incrementar el último IDPartido

    --Si no se ha insertado ninguno, empieza en 0
    IF last_id IS NULL THEN
        last_id := 0;
    END IF;

    -- Generar el nuevo IDPartido con 7 dígitos
    :NEW.IDPartido := 'No.' || LPAD(last_id + 1, 7, '0');
END;
/

--Disparador para autoincrementar el valor de IDEquipo

CREATE OR REPLACE TRIGGER TG_Equipos_BI_IDEquipo
BEFORE INSERT ON Equipos
FOR EACH ROW
DECLARE
    last_id NUMBER;
BEGIN
    -- Obtener el último IDEquipo insertado
    SELECT TO_NUMBER(SUBSTR(MAX(IDEquipo), 4)) INTO last_id FROM Equipos;

    -- Incrementar el último IDEquipo

    --Si no se ha insertado ninguno, empieza en 0
    IF last_id IS NULL THEN
        last_id := 0;
    END IF;

    -- Generar el nuevo IDEquipo con 7 dígitos
    :NEW.IDEquipo := 'No.' || LPAD(last_id + 1, 7, '0');
END;
/

--Disparador para autoincrementar el valor de IDReserva y que al insertar crea automáticamente un pago asociado con estado "Procesando".

CREATE OR REPLACE TRIGGER TG_Reservaciones_BI_IDReserva_IDPago
BEFORE INSERT ON Reservaciones
FOR EACH ROW
DECLARE
    last_id NUMBER;
    v_idPago CHAR(15);
BEGIN
    -- Obtener el último IDReserva insertado
    SELECT TO_NUMBER(SUBSTR(MAX(IDReserva), 4)) INTO last_id FROM Reservaciones;

    -- Incrementar el último IDReserva

    --Si no se ha insertado ninguno, empieza en 0
    IF last_id IS NULL THEN
        last_id := 0;
    END IF;

    -- Generar el nuevo IDReserva con 7 dígitos
    :NEW.IDReserva := 'No.' || LPAD(last_id + 1, 7, '0');

    --Colocar el estado de la reserva en Procesando
    :NEW.estado := 'Procesando';

    -- Generar un nuevo ID de pago único
    v_idPago := 'Fact_' || 'No.' || LPAD(last_id + 1, 7, '0');

    -- Asignar el nuevo ID de pago a la reservación
    :NEW.IDPago := v_idPago;

    -- Insertar el nuevo pago asociado con estado 'Procesando'
    INSERT INTO Pagos (IDPago, estado, metodo, fechaPago) VALUES (v_idPago, 'Procesando', 'Efectivo', NULL);
END;
/

--Disparador para actualizar el estado de la reservación cuando el estado del pago cambia

CREATE OR REPLACE TRIGGER TG_Pagos_AU_estado
AFTER UPDATE OF estado ON Pagos
FOR EACH ROW
BEGIN
    IF :NEW.estado = 'Aprobado' THEN -- Aqui quiero que inserte automaticamente la fecha actual como fechaPago en pagos
        
        UPDATE Reservaciones
        SET estado = 'Completada'
        WHERE IDPago = :OLD.IDPago;

        -- Insertar la fecha actual como fechaPago en Pagos
        /*
        UPDATE Pagos
        SET fechaPago = SYSDATE
        WHERE IDPago = :OLD.IDPago;
        */
        
    ELSIF :NEW.estado = 'Rechazado' THEN
        UPDATE Reservaciones
        SET estado = 'Cancelada'
        WHERE IDPago = :OLD.IDPago;
    END IF;
END;
/

-- Disparador para garantizar que no se pueda reservar una cancha en estado Mantenimiento o Inactiva.

CREATE OR REPLACE TRIGGER TG_Reservaciones_BI_EstadoCanchas
BEFORE INSERT ON Reservaciones
FOR EACH ROW
BEGIN
    DECLARE
        v_estadoCancha VARCHAR(15);
    BEGIN
        -- validar si IDCancha no es NULL
        IF :NEW.IDCancha IS NOT NULL THEN
            -- Obtener el estado de la cancha correspondiente a la reserva
            SELECT estado INTO v_estadoCancha
            FROM Canchas
            WHERE IDCancha = :NEW.IDCancha AND IDZona = :NEW.IDZona;

            -- Verificar si el estado de la cancha permite la reserva
            IF v_estadoCancha IN ('Mantenimiento', 'Inactiva') THEN
                RAISE_APPLICATION_ERROR(-20204, 'No se puede reservar una cancha en estado de Mantenimiento o Inactiva.');
            END IF;
        END IF;
    END;
END;
/

--------------------------------------------------------DisparadoresOK-------------------------------------------------------
--(Algunas requieren de poblar)
--DisparadorOK

INSERT INTO Canchas (IDCancha, IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('No.0000003', 'Zona#0001', 10, 'Activa', '25m x 7m', 'Futbol','Cancha sintetica de futbol 5 al aire libre');
SELECT * FROM ZonasDeportivas;

--DisparadorOK

DELETE FROM Canchas
WHERE IDCancha = 'No.0000003' AND IDZona = 'Zona#0001';
SELECT * FROM ZonasDeportivas;

--DisparadorOK

INSERT INTO ZonasDeportivas (nombre, cantidadCanchas, direccion, descripcion, area) VALUES ('Polideportivo PEPESIERRA', 1, 'Cra 100 #90 - 15', 'Polideportivo amplio.', '100m x 120m');
SELECT * FROM ZonasDeportivas;

--DisparadorOK

INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CE', '1010123457', TO_DATE('2025-08-14','YYYY-MM-DD'), 'https://osaki.png', 'Maestria', 3, 'Zona#0004');
SELECT * FROM Encargados;

--DisparadorOK

INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0003', 14, 'Activa', '30m x 20m', 'Futbol', 'Cancha de Futbol 7');
SELECT * FROM Canchas;

--DisparadorOK

INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, horaFin, precio) VALUES ('No.0000001', 'Zona#0001', 'Festivo', '20:00', '23:00', 200000);
SELECT * FROM Tarifas;

--DisparadorOK

INSERT INTO Adicionales (nombre, precioUnitario, disponibilidad) values ('MALETA', 5000, 1);
SELECT * FROM Adicionales;

--DisparadorOK

INSERT INTO Partidos (resultado) VALUES ('300-200');
SELECT * FROM Partidos;

--DisparadorOK

INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Reall Vardrid', 12);
SELECT * FROM Equipos;

--DisparadorOK

INSERT INTO Reservaciones (fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona, IDPartido) VALUES (TO_DATE('2024-05-10','YYYY-MM-DD'), TO_DATE('2024-05-21','YYYY-MM-DD'), 2, 'CC', '1000987654');
SELECT * FROM Reservaciones;
SELECT * FROM Pagos;

--DisparadorOK

UPDATE Pagos SET estado = 'Aprobado'
WHERE IDPago = 'Fact_No.0000001';
SELECT * FROM Reservaciones;
SELECT * FROM Pagos;

--------------------------------------------------------XDisparadores--------------------------------------------------------

DROP TRIGGER TG_Reservaciones_BI_fechaSolicitud;
DROP TRIGGER TG_ZonasDeportivas_AI_Aumentar_cantidadCanchas;
DROP TRIGGER TG_ZonasDeportivas_AI_Disminuir_cantidadCanchas;
DROP TRIGGER TG_ZonasDeportivas_BI_cantidadCanchas;
DROP TRIGGER TG_Encargados_BIU_fechaContratacion;
DROP TRIGGER TG_Reservaciones_BD;
DROP TRIGGER TG_Calificaciones_BU;
DROP TRIGGER TG_Calificaciones_BD;
DROP TRIGGER TG_Tarifas_BU;
DROP TRIGGER TG_ZonasDeportivas_BI_IDZona;
DROP TRIGGER TG_Canchas_BI_IDCancha;
DROP TRIGGER TG_Tarifas_BI_IDTarifa;
DROP TRIGGER TG_Adicionales_BI_IDAdicional;
DROP TRIGGER TG_Partidos_BI_IDPartido;
DROP TRIGGER TG_Equipos_BI_IDEquipo;
DROP TRIGGER TG_Reservaciones_BI_IDReserva_IDPago;
DROP TRIGGER TG_Pagos_AU_estado;
DROP TRIGGER TG_Reservaciones_BI_EstadoCanchas;

--------------------------------------------------------PoblarOK--------------------------------------------------------

--ZonasDeportivas

INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 1', 'Calle Principal #1 - 1', 'Zona deportiva con múltiples instalaciones.', '60m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 2', 'Avenida Deportiva #1 - 2', 'Zona deportiva con enfoque en deportes acuáticos.', '40m x 80m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 3', 'Carrera Deportiva #1 - 3', 'Zona deportiva con amplias áreas verdes.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 4', 'Calle Principal #1 - 4', 'Zona deportiva con múltiples instalaciones.', '30m x 60m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 5', 'Avenida Deportiva #1 - 5', 'Zona deportiva con enfoque en deportes acuáticos.', '50m x 100m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 6', 'Carrera Deportiva #1 - 6', 'Zona deportiva con amplias áreas verdes.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 7', 'Calle Principal #1 - 7', 'Zona deportiva con múltiples instalaciones.', '40m x 80m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 8', 'Avenida Deportiva #1 - 8', 'Zona deportiva con enfoque en deportes acuáticos.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 9', 'Carrera Deportiva #1 - 9', 'Zona deportiva con amplias áreas verdes.', '30m x 60m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 10', 'Calle Principal #2 - 1', 'Zona deportiva con múltiples instalaciones.', '50m x 100m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 11', 'Avenida Deportiva #2 - 2', 'Zona deportiva con enfoque en deportes acuáticos.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 12', 'Carrera Deportiva #2 - 3', 'Zona deportiva con amplias áreas verdes.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 13', 'Calle Principal #2 - 4', 'Zona deportiva con múltiples instalaciones.', '30m x 60m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 14', 'Avenida Deportiva #2 - 5', 'Zona deportiva con enfoque en deportes acuáticos.', '50m x 100m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 15', 'Carrera Deportiva #2 - 6', 'Zona deportiva con amplias áreas verdes.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 16', 'Calle Principal #2 - 7', 'Zona deportiva con múltiples instalaciones.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 17', 'Avenida Deportiva #2 - 8', 'Zona deportiva con enfoque en deportes acuáticos.', '30m x 60m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 18', 'Carrera Deportiva #2 - 9', 'Zona deportiva con amplias áreas verdes.', '50m x 100m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 19', 'Calle Principal #3 - 1', 'Zona deportiva con múltiples instalaciones.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 20', 'Avenida Deportiva #3 - 2', 'Zona deportiva con enfoque en deportes acuáticos.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 21', 'Carrera Deportiva #1 - 10', 'Zona deportiva con amplias áreas verdes.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 22', 'Avenida Deportiva #1 - 14', 'Zona deportiva con enfoque en deportes acuáticos.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 23', 'Carrera Deportiva #1 - 15', 'Zona deportiva con amplias áreas verdes.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 24', 'Calle Principal #1 - 16', 'Zona deportiva con múltiples instalaciones.', '30m x 60m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 25', 'Avenida Deportiva #1 - 17', 'Zona deportiva con enfoque en deportes acuáticos.', '50m x 100m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 26', 'Carrera Deportiva #1 - 18', 'Zona deportiva con amplias áreas verdes.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 27', 'Calle Principal #1 - 19', 'Zona deportiva con múltiples instalaciones.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 28', 'Avenida Deportiva #1 - 20', 'Zona deportiva con enfoque en deportes acuáticos.', '30m x 60m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 29', 'Carrera Deportiva #1 - 21', 'Zona deportiva con amplias áreas verdes.', '50m x 100m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 30', 'Calle Principal #1 - 22', 'Zona deportiva con múltiples instalaciones.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 31', 'Avenida Deportiva #1 - 23', 'Zona deportiva con enfoque en deportes acuáticos.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 32', 'Carrera Deportiva #1 - 24', 'Zona deportiva con amplias áreas verdes.', '30m x 60m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 33', 'Calle Principal #1 - 25', 'Zona deportiva con múltiples instalaciones.', '50m x 100m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 34', 'Avenida Deportiva #1 - 26', 'Zona deportiva con enfoque en deportes acuáticos.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 35', 'Carrera Deportiva #1 - 27', 'Zona deportiva con amplias áreas verdes.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 36', 'Calle Principal #1 - 28', 'Zona deportiva con múltiples instalaciones.', '30m x 60m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 37', 'Avenida Deportiva #1 - 29', 'Zona deportiva con enfoque en deportes acuáticos.', '50m x 100m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 38', 'Carrera Deportiva #1 - 30', 'Zona deportiva con amplias áreas verdes.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 39', 'Calle Principal #1 - 31', 'Zona deportiva con múltiples instalaciones.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 40', 'Avenida Deportiva #1 - 32', 'Zona deportiva con enfoque en deportes acuáticos.', '30m x 60m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 41', 'Carrera Deportiva #1 - 33', 'Zona deportiva con amplias áreas verdes.', '50m x 100m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 42', 'Calle Principal #1 - 34', 'Zona deportiva con múltiples instalaciones.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 43', 'Avenida Deportiva #1 - 35', 'Zona deportiva con enfoque en deportes acuáticos.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 44', 'Carrera Deportiva #1 - 36', 'Zona deportiva con amplias áreas verdes.', '30m x 60m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 45', 'Calle Principal #1 - 37', 'Zona deportiva con múltiples instalaciones.', '50m x 100m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 46', 'Avenida Deportiva #1 - 38', 'Zona deportiva con enfoque en deportes acuáticos.', '80m x 120m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 47', 'Carrera Deportiva #1 - 39', 'Zona deportiva con amplias áreas verdes.', '100m x 150m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 48', 'Calle Principal #1 - 40', 'Zona deportiva con múltiples instalaciones.', '30m x 60m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 49', 'Avenida Deportiva #1 - 41', 'Zona deportiva con enfoque en deportes acuáticos.', '50m x 100m');
INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area) VALUES ('Zona Deportiva 50', 'Carrera Deportiva #1 - 42', 'Zona deportiva con amplias áreas verdes.', '80m x 120m');

--Canchas

INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0001', 10, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 5');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0002', 8, 'Activa', '15m x 30m', 'Baloncesto', 'Cancha de Baloncesto');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0003', 12, 'Activa', '25m x 50m', 'Tenis', 'Cancha de Tenis');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0004', 6, 'Activa', '8m x 16m', 'Volleyball', 'Cancha de Volleyball');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0005', 8, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 7');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0006', 4, 'Activa', '12m x 24m', 'Baloncesto', 'Cancha de Baloncesto');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0007', 10, 'Activa', '20m x 40m', 'Tenis', 'Cancha de Tenis');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0008', 2, 'Activa', '6m x 12m', 'Microfutbol', 'Cancha de Microfutbol');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0009', 6, 'Activa', '8m x 16m', 'Volleyball', 'Cancha de Volleyball');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0010', 8, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 7');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0011', 4, 'Activa', '12m x 24m', 'Baloncesto', 'Cancha de Baloncesto');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0012', 10, 'Activa', '20m x 40m', 'Tenis', 'Cancha de Tenis');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0013', 2, 'Activa', '6m x 12m', 'Microfutbol', 'Cancha de Microfutbol');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0014', 6, 'Activa', '8m x 16m', 'Volleyball', 'Cancha de Volleyball');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0015', 8, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 7');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0016', 4, 'Activa', '12m x 24m', 'Baloncesto', 'Cancha de Baloncesto');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0017', 10, 'Activa', '20m x 40m', 'Tenis', 'Cancha de Tenis');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0018', 2, 'Activa', '6m x 12m', 'Microfutbol', 'Cancha de Microfutbol');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0019', 6, 'Activa', '8m x 16m', 'Volleyball', 'Cancha de Volleyball');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0020', 8, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 7');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0021', 4, 'Activa', '12m x 24m', 'Baloncesto', 'Cancha de Baloncesto');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0022', 10, 'Activa', '20m x 40m', 'Tenis', 'Cancha de Tenis');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0023', 2, 'Activa', '6m x 12m', 'Microfutbol', 'Cancha de Microfutbol');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0024', 6, 'Activa', '8m x 16m', 'Volleyball', 'Cancha de Volleyball');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0025', 8, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 7');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0026', 4, 'Activa', '12m x 24m', 'Baloncesto', 'Cancha de Baloncesto');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0027', 10, 'Activa', '20m x 40m', 'Tenis', 'Cancha de Tenis');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0028', 2, 'Activa', '6m x 12m', 'Microfutbol', 'Cancha de Microfutbol');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0029', 6, 'Mantenimiento', '8m x 16m', 'Volleyball', 'Cancha de Volleyball');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0030', 8, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 7');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0031', 4, 'Mantenimiento', '12m x 24m', 'Baloncesto', 'Cancha de Baloncesto');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0032', 10, 'Activa', '20m x 40m', 'Tenis', 'Cancha de Tenis');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0033', 2, 'Activa', '6m x 12m', 'Microfutbol', 'Cancha de Microfutbol');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0034', 6, 'Mantenimiento', '8m x 16m', 'Volleyball', 'Cancha de Volleyball');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0035', 8, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 7');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0036', 4, 'Mantenimiento', '12m x 24m', 'Baloncesto', 'Cancha de Baloncesto');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0037', 10, 'Activa', '20m x 40m', 'Tenis', 'Cancha de Tenis');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0038', 2, 'Activa', '6m x 12m', 'Microfutbol', 'Cancha de Microfutbol');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0039', 6, 'Mantenimiento', '8m x 16m', 'Volleyball', 'Cancha de Volleyball');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0040', 8, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 7');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0041', 4, 'Mantenimiento', '12m x 24m', 'Baloncesto', 'Cancha de Baloncesto');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0042', 10, 'Activa', '20m x 40m', 'Tenis', 'Cancha de Tenis');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0043', 2, 'Activa', '6m x 12m', 'Microfutbol', 'Cancha de Microfutbol');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0044', 6, 'Mantenimiento', '8m x 16m', 'Volleyball', 'Cancha de Volleyball');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0045', 8, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 7');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0046', 4, 'Mantenimiento', '12m x 24m', 'Baloncesto', 'Cancha de Baloncesto');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0047', 10, 'Activa', '20m x 40m', 'Tenis', 'Cancha de Tenis');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0048', 2, 'Activa', '6m x 12m', 'Microfutbol', 'Cancha de Microfutbol');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0049', 6, 'Mantenimiento', '8m x 16m', 'Volleyball', 'Cancha de Volleyball');
INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0050', 8, 'Activa', '10m x 20m', 'Futbol', 'Cancha de Futbol 7');

--Tarifas

INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0001', 'Lunes', '06:00', 200000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0002', 'Martes', '07:00', 80000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0003', 'Miercoles', '08:00', 150000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0004', 'Jueves', '09:00', 100000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0005', 'Viernes', '10:00', 120000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0006', 'Sabado', '11:00', 80000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0007', 'Domingo', '12:00', 150000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0008', 'Lunes', '13:00', 90000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0009', 'Martes', '14:00', 110000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0010', 'Miercoles', '15:00', 130000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0011', 'Jueves', '16:00', 100000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0012', 'Viernes', '17:00', 120000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0013', 'Sabado', '18:00', 80000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0014', 'Domingo', '19:00', 150000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0015', 'Lunes', '20:00', 90000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0016', 'Martes', '21:00', 110000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0017', 'Miercoles', '22:00', 130000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0018', 'Jueves', '23:00', 100000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0019', 'Viernes', '00:00', 120000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0020', 'Sabado', '01:00', 80000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0021', 'Domingo', '02:00', 150000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0022', 'Lunes', '03:00', 90000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0023', 'Martes', '04:00', 110000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0024', 'Miercoles', '05:00', 130000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0025', 'Jueves', '06:00', 100000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0026', 'Viernes', '07:00', 120000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0027', 'Sabado', '08:00', 80000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0028', 'Domingo', '09:00', 150000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0029', 'Lunes', '10:00', 90000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0030', 'Martes', '11:00', 110000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0031', 'Miercoles', '12:00', 130000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0032', 'Jueves', '13:00', 100000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0033', 'Viernes', '14:00', 120000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0034', 'Sabado', '15:00', 80000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0035', 'Domingo', '16:00', 150000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0036', 'Lunes', '17:00', 90000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0037', 'Martes', '18:00', 110000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0038', 'Miercoles', '19:00', 130000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0039', 'Jueves', '20:00', 100000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0040', 'Viernes', '21:00', 120000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0041', 'Sabado', '22:00', 80000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0042', 'Domingo', '23:00', 150000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0043', 'Lunes', '00:00', 90000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0044', 'Martes', '01:00', 110000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0045', 'Miercoles', '02:00', 130000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0046', 'Jueves', '03:00', 100000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0047', 'Viernes', '04:00', 120000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0048', 'Sabado', '05:00', 80000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0049', 'Domingo', '06:00', 150000);
INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio) VALUES ('No.0000001', 'Zona#0050', 'Lunes', '07:00', 90000);

--Adicionales

INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0001', 'Balón de Fútbol', 10, 10000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0002', 'Balón de Baloncesto', 5, 15000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0003', 'Balón de Voleibol', 8, 12000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0004', 'Balón de Tenis', 3, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0005', 'Balón de Microfútbol', 6, 8000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0006', 'Cono de Entrenamiento', 20, 5000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0007', 'Peto de Entrenamiento', 15, 3000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0008', 'Cronómetro', 2, 10000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0009', 'Silbato', 4, 5000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0010', 'Red de Voleibol', 1, 30000, 0);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0011', 'Red de Tenis', 2, 25000, 0);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0012', 'Red de Baloncesto', 3, 35000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0013', 'Guantes de Portero', 5, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0014', 'Casco de Ciclismo', 2, 15000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0015', 'Rodilleras', 4, 8000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0016', 'Cinta de Correr', 1, 50000, 0);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0017', 'Pesas', 10, 10000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0018', 'Bicicleta Estática', 2, 30000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0019', 'Pelota de Golf', 3, 25000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0020', 'Raqueta de Tenis', 5, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0021', 'Raqueta de Squash', 4, 25000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0022', 'Raqueta de Bádminton', 6, 15000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0023', 'Pelota de Ping Pong', 8, 5000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0024', 'Mancuernas', 10, 8000, 0);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0025', 'Colchoneta de Yoga', 3, 10000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0026', 'Pelota de Pilates', 5, 15000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0027', 'Cuerda de Saltar', 10, 5000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0028', 'Aro de Hula Hula', 6, 3000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0029', 'Pelota de Rugby', 4, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0030', 'Pelota de Béisbol', 5, 15000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0031', 'Bate de Béisbol', 2, 25000, 0);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0032', 'Casco de Béisbol', 3, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0033', 'Guantes de Béisbol', 4, 15000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0034', 'Pelota de Softball', 5, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0035', 'Bate de Softball', 2, 25000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0036', 'Casco de Softball', 3, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0037', 'Guantes de Softball', 4, 15000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0038', 'Pelota de Cricket', 5, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0039', 'Bate de Cricket', 2, 25000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0040', 'Casco de Cricket', 3, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0041', 'Guantes de Cricket', 4, 15000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0042', 'Pelota de Hockey', 5, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0043', 'Stick de Hockey', 2, 25000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0044', 'Casco de Hockey', 3, 20000, 0);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0045', 'Guantes de Hockey', 4, 15000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0046', 'Cama de yoga', 5, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0047', 'Palos de Golf', 2, 25000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0048', 'Guantes de Golf', 4, 15000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0049', 'Pelota de Squash', 5, 20000, 1);
INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad) VALUES ('Zona#0050', 'Disco de 1kg', 2, 25000, 0);

--Partidos

INSERT INTO Partidos (resultado) VALUES ('4-3');
INSERT INTO Partidos (resultado) VALUES ('5-2');
INSERT INTO Partidos (resultado) VALUES ('1-0');
INSERT INTO Partidos (resultado) VALUES ('3-1');
INSERT INTO Partidos (resultado) VALUES ('2-2');
INSERT INTO Partidos (resultado) VALUES ('0-0');
INSERT INTO Partidos (resultado) VALUES ('3-0');
INSERT INTO Partidos (resultado) VALUES ('2-0');
INSERT INTO Partidos (resultado) VALUES ('1-1');
INSERT INTO Partidos (resultado) VALUES ('4-2');
INSERT INTO Partidos (resultado) VALUES ('3-2');
INSERT INTO Partidos (resultado) VALUES ('2-1');
INSERT INTO Partidos (resultado) VALUES ('4-3');
INSERT INTO Partidos (resultado) VALUES ('5-2');
INSERT INTO Partidos (resultado) VALUES ('1-0');
INSERT INTO Partidos (resultado) VALUES ('3-1');
INSERT INTO Partidos (resultado) VALUES ('2-2');
INSERT INTO Partidos (resultado) VALUES ('0-0');
INSERT INTO Partidos (resultado) VALUES ('3-0');
INSERT INTO Partidos (resultado) VALUES ('2-0');
INSERT INTO Partidos (resultado) VALUES ('1-1');
INSERT INTO Partidos (resultado) VALUES ('4-2');
INSERT INTO Partidos (resultado) VALUES ('3-2');
INSERT INTO Partidos (resultado) VALUES ('2-1');
INSERT INTO Partidos (resultado) VALUES ('4-3');
INSERT INTO Partidos (resultado) VALUES ('5-2');
INSERT INTO Partidos (resultado) VALUES ('1-0');
INSERT INTO Partidos (resultado) VALUES ('3-1');
INSERT INTO Partidos (resultado) VALUES ('2-2');
INSERT INTO Partidos (resultado) VALUES ('0-0');
INSERT INTO Partidos (resultado) VALUES ('3-0');
INSERT INTO Partidos (resultado) VALUES ('2-0');
INSERT INTO Partidos (resultado) VALUES ('1-1');
INSERT INTO Partidos (resultado) VALUES ('4-2');
INSERT INTO Partidos (resultado) VALUES ('3-2');
INSERT INTO Partidos (resultado) VALUES ('2-1');
INSERT INTO Partidos (resultado) VALUES ('4-3');
INSERT INTO Partidos (resultado) VALUES ('5-2');
INSERT INTO Partidos (resultado) VALUES ('1-0');
INSERT INTO Partidos (resultado) VALUES ('3-1');
INSERT INTO Partidos (resultado) VALUES ('2-2');
INSERT INTO Partidos (resultado) VALUES ('0-0');
INSERT INTO Partidos (resultado) VALUES ('3-0');
INSERT INTO Partidos (resultado) VALUES ('2-0');
INSERT INTO Partidos (resultado) VALUES ('1-1');
INSERT INTO Partidos (resultado) VALUES ('4-2');
INSERT INTO Partidos (resultado) VALUES ('3-2');
INSERT INTO Partidos (resultado) VALUES ('2-1');
INSERT INTO Partidos (resultado) VALUES ('4-3');
INSERT INTO Partidos (resultado) VALUES ('5-2');

--Equipos

INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Real Madrid', 11);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Yankees', 18);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Lions', 15);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo1', 10);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo2', 12);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo3', 15);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo4', 11);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo5', 9);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo6', 10);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo7', 12);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo8', 15);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo9', 11);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo10', 9);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo11', 10);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo12', 12);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo13', 15);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo14', 11);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo15', 9);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo16', 10);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo17', 12);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo18', 15);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo19', 11);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo20', 9);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo21', 10);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo22', 12);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo23', 15);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo24', 11);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo25', 9);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo26', 10);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo27', 12);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo28', 15);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo29', 11);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo30', 9);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo31', 10);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo32', 12);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo33', 15);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo34', 11);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo35', 9);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo36', 10);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo37', 12);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo38', 15);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo39', 11);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo40', 9);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo41', 10);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo42', 12);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo43', 15);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo44', 11);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo45', 9);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo46', 10);
INSERT INTO Equipos (nombre, numeroIntegrantes) VALUES ('Equipo47', 12);

--EquiposJueganPartidos

INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000001', 'No.0000001');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000002', 'No.0000002');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000003', 'No.0000003');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000004', 'No.0000004');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000005', 'No.0000005');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000006', 'No.0000006');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000007', 'No.0000007');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000008', 'No.0000008');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000009', 'No.0000009');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000010', 'No.0000010');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000011', 'No.0000011');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000012', 'No.0000012');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000013', 'No.0000013');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000014', 'No.0000014');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000015', 'No.0000015');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000016', 'No.0000016');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000017', 'No.0000017');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000018', 'No.0000018');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000019', 'No.0000019');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000020', 'No.0000020');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000021', 'No.0000021');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000022', 'No.0000022');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000023', 'No.0000023');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000024', 'No.0000024');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000025', 'No.0000025');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000026', 'No.0000026');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000027', 'No.0000027');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000028', 'No.0000028');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000029', 'No.0000029');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000030', 'No.0000030');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000031', 'No.0000031');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000032', 'No.0000032');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000033', 'No.0000033');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000034', 'No.0000034');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000035', 'No.0000035');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000036', 'No.0000036');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000037', 'No.0000037');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000038', 'No.0000038');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000039', 'No.0000039');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000040', 'No.0000040');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000041', 'No.0000041');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000042', 'No.0000042');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000043', 'No.0000043');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000044', 'No.0000044');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000045', 'No.0000045');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000046', 'No.0000046');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000047', 'No.0000047');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000048', 'No.0000048');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000049', 'No.0000049');
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) VALUES ('No.0000050', 'No.0000050');

--Jugadores

INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000056', 'Andres David', 'Monroy Jimenez', 'monroyj@gmail.com', 'Masculino', 'No.0000001'); --Encargado
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000057', 'Santiago Nicolas', 'Ochoa Lopez', 'ochoal@gmail.com', 'Masculino','No.0000001'); --Encargado
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000000', 'Daniel Esteban', 'Rodriguez Orjuela', 'rodri10@outlook.com', 'Masculino', 'No.0000001'); --Encargado
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000001', 'Andres David', 'Vargas Montoya', 'andresvargas@gmail.com', 'Masculino', 'No.0000001'); --Encargado
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000002', 'Juan Pablo', 'Gomez Figueroa', 'jpgf@gmail.com', 'Masculino', 'No.0000001'); --Encargado
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000003', 'Camila', 'Gomez Figueroa', 'cgf@gmail.com', 'Femenino', 'No.0000001'); --Encargado
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000004', 'Sara', 'Lopez Armera', 'sara.lopez@gmail.com', 'Femenino', 'No.0000001'); --Encargado
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000005', 'Santiago', 'Parra Lesmes', 'santiago.parra@gmail.com', 'Masculino', 'No.0000001'); --Encargado
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000006', 'Juan', 'Perez Rodriguez', 'juan.perez@gmail.com', 'Masculino', 'No.0000001'); --Encargado
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000007', 'Cristian David', 'Polo Garrido', 'crispo5124@gmail.com', 'Masculino', 'No.0000002');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CE', '1000000008', 'Samuel Felipe', 'Diaz Mamanche', 'samuel.diaz@gmail.com', 'Masculino', 'No.0000003');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('TI', '1000000009', 'Maria Fernanda', 'Gonzalez Garcia', 'margon562@outlook.com', 'Femenino', 'No.0000004');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000010', 'Carlos', 'Gonzalez Ramirez', 'carlos.gonzalez@gmail.com', 'Masculino', 'No.0000005');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000011', 'Laura', 'Hernandez Lopez', 'laura.hernandez@gmail.com', 'Femenino', 'No.0000006');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000012', 'Pedro', 'Martinez Garcia', 'pedro.martinez@gmail.com', 'Masculino', 'No.0000007');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000013', 'Ana', 'Sanchez Rodriguez', 'ana.sanchez@gmail.com', 'Femenino', 'No.0000008');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000014', 'Diego', 'Lopez Perez', 'diego.lopez@gmail.com', 'Masculino', 'No.0000009');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000015', 'Maria', 'Gomez Fernandez', 'maria.gomez@gmail.com', 'Femenino', 'No.0000010');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000016', 'Juan', 'Rodriguez Hernandez', 'juan.rodriguez@gmail.com', 'Masculino', 'No.0000011');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000017', 'Carolina', 'Perez Martinez', 'carolina.perez@gmail.com', 'Femenino', 'No.0000012');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000018', 'Andres', 'Fernandez Sanchez', 'andres.fernandez@gmail.com', 'Masculino', 'No.0000013');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000019', 'Luisa', 'Hernandez Rodriguez', 'luisa.hernandez@gmail.com', 'Femenino', 'No.0000014');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000020', 'Maria', 'Lopez Ramirez', 'maria.lopez@gmail.com', 'Femenino', 'No.0000015');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000021', 'Pedro', 'Gonzalez Torres', 'pedro.gonzalez@gmail.com', 'Masculino', 'No.0000016');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000022', 'Laura', 'Sanchez Gomez', 'laura.sanchez@gmail.com', 'Femenino', 'No.0000017');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000023', 'Carlos', 'Martinez Rodriguez', 'carlos.martinez@gmail.com', 'Masculino', 'No.0000018');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000024', 'Ana', 'Fernandez Perez', 'ana.fernandez@gmail.com', 'Femenino', 'No.0000019');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000025', 'David', 'Hernandez Lopez', 'david.hernandez@gmail.com', 'Masculino', 'No.0000020');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000026', 'Sofia', 'Perez Ramirez', 'sofia.perez@gmail.com', 'Femenino', 'No.0000021');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000027', 'Daniel', 'Gomez Torres', 'daniel.gomez@gmail.com', 'Masculino', 'No.0000022');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000028', 'Valentina', 'Sanchez Gomez', 'valentina.sanchez@gmail.com', 'Femenino', 'No.0000023');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000029', 'Alejandro', 'Martinez Rodriguez', 'alejandro.martinez@gmail.com', 'Masculino', 'No.0000024');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000030', 'Camila', 'Fernandez Perez', 'camila.fernandez@gmail.com', 'Femenino', 'No.0000025');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000031', 'Mateo', 'Hernandez Lopez', 'mateo.hernandez@gmail.com', 'Masculino', 'No.0000026');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000032', 'Isabella', 'Perez Ramirez', 'isabella.perez@gmail.com', 'Femenino', 'No.0000027');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000033', 'Javier', 'Gomez Torres', 'javier.gomez@gmail.com', 'Masculino', 'No.0000028');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000034', 'Mariana', 'Sanchez Gomez', 'mariana.sanchez@gmail.com', 'Femenino', 'No.0000029');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000035', 'Gabriel', 'Martinez Rodriguez', 'gabriel.martinez@gmail.com', 'Masculino', 'No.0000030');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000036', 'Lucia', 'Fernandez Perez', 'lucia.fernandez@gmail.com', 'Femenino', 'No.0000031');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000037', 'Sebastian', 'Hernandez Lopez', 'sebastian.hernandez@gmail.com', 'Masculino', 'No.0000032');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000038', 'Valeria', 'Perez Ramirez', 'valeria.perez@gmail.com', 'Femenino', 'No.0000033');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000039', 'Nicolas', 'Gomez Torres', 'nicolas.gomez@gmail.com', 'Masculino', 'No.0000034');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000040', 'Emma', 'Sanchez Gomez', 'emma.sanchez@gmail.com', 'Femenino', 'No.0000035');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000041', 'Matias', 'Martinez Rodriguez', 'matias.martinez@gmail.com', 'Masculino', 'No.0000036');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000042', 'Sara', 'Fernandez Perez', 'sara.fernandez@gmail.com', 'Femenino', 'No.0000037');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000043', 'Felipe', 'Hernandez Lopez', 'felipe.hernandez@gmail.com', 'Masculino', 'No.0000038');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000044', 'Juliana', 'Perez Ramirez', 'juliana.perez@gmail.com', 'Femenino', 'No.0000039');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000045', 'Diego', 'Gomez Torres', 'diego.gomez@gmail.com', 'Masculino', 'No.0000040');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000046', 'Catalina', 'Sanchez Gomez', 'catalina.sanchez@gmail.com', 'Femenino', 'No.0000041');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000047', 'Juan', 'Martinez Rodriguez', 'juan.martinez@gmail.com', 'Masculino', 'No.0000042');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000048', 'Carolina', 'Fernandez Perez', 'carolina.fernandez@gmail.com', 'Femenino', 'No.0000043');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000049', 'Andres', 'Hernandez Lopez', 'andres.hernandez@gmail.com', 'Masculino', 'No.0000044');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000050', 'Luisa', 'Perez Ramirez', 'luisa.perez@gmail.com', 'Femenino', 'No.0000045');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000051', 'Pedro', 'Gomez Torres', 'pedro.gomez@gmail.com', 'Masculino', 'No.0000046');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000052', 'Laura', 'Rios Ochoa', 'laura.rios@gmail.com', 'Femenino', 'No.0000047');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000053', 'Carlos', 'Maecha Lopez', 'carlos.maecha@gmail.com', 'Masculino', 'No.0000048');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000054', 'Ana', 'Duran Burgos', 'ana.duran@gmail.com', 'Femenino', 'No.0000049');
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1000000055', 'David', 'Lozano Jimenez', 'david.lozano@gmail.com', 'Masculino', 'No.0000050');

--TelefonosPorJugador

INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000000', 3000000001);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000001', 3000000002);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000002', 3000000003);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000003', 3000000004);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000004', 3000000005);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000005', 3000000006);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000006', 3000000007);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000007', 3000000008);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CE', '1000000008', 3000000009);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('TI', '1000000009', 3000000010);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000010', 3000000011);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000011', 3000000012);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000012', 3000000013);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000013', 3000000014);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000014', 3000000015);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000015', 3000000016);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000016', 3000000017);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000017', 3000000018);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000018', 3000000019);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000019', 3000000020);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000020', 3000000021);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000021', 3000000022);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000022', 3000000023);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000023', 3000000024);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000024', 3000000025);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000025', 3000000026);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000026', 3000000027);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000027', 3000000028);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000028', 3000000029);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000029', 3000000030);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000030', 3000000031);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000031', 3000000032);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000032', 3000000033);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000033', 3000000034);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000034', 3000000035);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000035', 3000000036);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000036', 3000000037);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000037', 3000000038);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000038', 3000000039);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000039', 3000000040);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000040', 3000000041);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000041', 3000000042);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000042', 3000000043);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000043', 3000000044);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000044', 3000000045);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000045', 3000000046);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000046', 3000000047);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000047', 3000000048);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000048', 3000000049);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000049', 3000000050);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000050', 3000000051);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000051', 3000000052);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000052', 3000000053);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000053', 3000000054);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000054', 3000000055);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000055', 3000000056);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000056', 3000000057);
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) VALUES ('CC', '1000000057', 3000000058);

--Encargados

INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000056', TO_DATE('2014-08-30','YYYY-MM-DD'), 'https://www.Fotos/AndresDavid.jpg', 'Pregrado', 9, 'Zona#0001');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000057', TO_DATE('2020-11-03','YYYY-MM-DD'), 'https://www.santiagoN/foto.jpg', 'Maestria', 3, 'Zona#0002');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000000', TO_DATE('2022-05-13','YYYY-MM-DD'), 'https://DanielEs.png', 'Doctorado', 2, 'Zona#0003');
Insert INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000001', TO_DATE('2023-01-15','YYYY-MM-DD'), 'https://AndresD.jpg', 'Pregrado', 5, 'Zona#0004');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000002', TO_DATE('2023-02-20','YYYY-MM-DD'), 'https://JuanP.jpg', 'Maestria', 4, 'Zona#0005');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000003', TO_DATE('2023-03-25','YYYY-MM-DD'), 'https://CamilaG.jpg', 'Doctorado', 3, 'Zona#0006');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000004', TO_DATE('2023-04-30','YYYY-MM-DD'), 'https://SaraL.jpg', 'Pregrado', 2, 'Zona#0007');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000005', TO_DATE('2023-05-05','YYYY-MM-DD'), 'https://SantiagoP.jpg', 'Maestria', 1, 'Zona#0008');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000006', TO_DATE('2023-06-10','YYYY-MM-DD'), 'https://JuanPe.jpg', 'Doctorado', 6, 'Zona#0009');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000007', TO_DATE('2023-07-15','YYYY-MM-DD'), 'https://CristianD.jpg', 'Pregrado', 7, 'Zona#0010');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CE', '1000000008', TO_DATE('2023-08-20','YYYY-MM-DD'), 'https://SamuelF.jpg', 'Maestria', 8, 'Zona#0011');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('TI', '1000000009', TO_DATE('2023-09-25','YYYY-MM-DD'), 'https://MariaF.jpg', 'Doctorado', 9, 'Zona#0012');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000010', TO_DATE('2023-10-30','YYYY-MM-DD'), 'https://CarlosG.jpg', 'Pregrado', 10, 'Zona#0013');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000011', TO_DATE('2023-11-05','YYYY-MM-DD'), 'https://LauraH.jpg', 'Maestria', 11, 'Zona#0014');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000012', TO_DATE('2023-12-10','YYYY-MM-DD'), 'https://PedroM.jpg', 'Doctorado', 12, 'Zona#0015');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000013', TO_DATE('2024-01-15','YYYY-MM-DD'), 'https://AnaS.jpg', 'Pregrado', 13, 'Zona#0016');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000014', TO_DATE('2024-02-20','YYYY-MM-DD'), 'https://DiegoL.jpg', 'Maestria', 14, 'Zona#0017');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000015', TO_DATE('2024-03-25','YYYY-MM-DD'), 'https://MariaG.jpg', 'Doctorado', 15, 'Zona#0018');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000016', TO_DATE('2024-04-30','YYYY-MM-DD'), 'https://JuanR.jpg', 'Pregrado', 16, 'Zona#0019');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000017', TO_DATE('2024-05-05','YYYY-MM-DD'), 'https://CarolinaP.jpg', 'Maestria', 17, 'Zona#0020');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000018', TO_DATE('2023-06-10','YYYY-MM-DD'), 'https://AndresF.jpg', 'Doctorado', 18, 'Zona#0021');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000019', TO_DATE('2023-07-15','YYYY-MM-DD'), 'https://LuisaH.jpg', 'Pregrado', 19, 'Zona#0022');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000020', TO_DATE('2023-08-20','YYYY-MM-DD'), 'https://MariaL.jpg', 'Maestria', 20, 'Zona#0023');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000021', TO_DATE('2023-09-25','YYYY-MM-DD'), 'https://PedroG.jpg', 'Doctorado', 21, 'Zona#0024');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000022', TO_DATE('2023-10-30','YYYY-MM-DD'), 'https://LauraS.jpg', 'Pregrado', 22, 'Zona#0025');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000023', TO_DATE('2023-11-05','YYYY-MM-DD'), 'https://CarlosM.jpg', 'Maestria', 23, 'Zona#0026');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000024', TO_DATE('2023-12-10','YYYY-MM-DD'), 'https://AnaF.jpg', 'Doctorado', 24, 'Zona#0027');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000025', TO_DATE('2010-01-15','YYYY-MM-DD'), 'https://DavidH.jpg', 'Pregrado', 25, 'Zona#0028');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000026', TO_DATE('2010-02-20','YYYY-MM-DD'), 'https://SofiaP.jpg', 'Maestria', 26, 'Zona#0029');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000027', TO_DATE('2010-03-25','YYYY-MM-DD'), 'https://DanielG.jpg', 'Doctorado', 27, 'Zona#0030');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000028', TO_DATE('2010-04-30','YYYY-MM-DD'), 'https://ValentinaS.jpg', 'Pregrado', 28, 'Zona#0031');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000029', TO_DATE('2010-05-05','YYYY-MM-DD'), 'https://AlejandroM.jpg', 'Maestria', 29, 'Zona#0032');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000030', TO_DATE('2010-06-10','YYYY-MM-DD'), 'https://CamilaF.jpg', 'Doctorado', 30, 'Zona#0033');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000031', TO_DATE('2010-07-15','YYYY-MM-DD'), 'https://MateoH.jpg', 'Pregrado', 31, 'Zona#0034');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000032', TO_DATE('2011-08-20','YYYY-MM-DD'), 'https://IsabellaP.jpg', 'Maestria', 32, 'Zona#0035');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000033', TO_DATE('2011-09-25','YYYY-MM-DD'), 'https://JavierG.jpg', 'Doctorado', 33, 'Zona#0036');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000034', TO_DATE('2011-10-30','YYYY-MM-DD'), 'https://MarianaS.jpg', 'Pregrado', 34, 'Zona#0037');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000035', TO_DATE('2011-11-05','YYYY-MM-DD'), 'https://GabrielM.jpg', 'Maestria', 35, 'Zona#0038');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000036', TO_DATE('2011-12-10','YYYY-MM-DD'), 'https://LuciaF.jpg', 'Doctorado', 36, 'Zona#0039');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000037', TO_DATE('2011-01-15','YYYY-MM-DD'), 'https://SebastianH.jpg', 'Pregrado', 37, 'Zona#0040');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000038', TO_DATE('2011-02-20','YYYY-MM-DD'), 'https://ValeriaP.jpg', 'Maestria', 38, 'Zona#0041');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000039', TO_DATE('2011-03-25','YYYY-MM-DD'), 'https://NicolasG.jpg', 'Doctorado', 39, 'Zona#0042');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000040', TO_DATE('2011-04-30','YYYY-MM-DD'), 'https://EmmaS.jpg', 'Pregrado', 40, 'Zona#0043');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000041', TO_DATE('2011-05-05','YYYY-MM-DD'), 'https://MatiasM.jpg', 'Maestria', 41, 'Zona#0044');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000042', TO_DATE('2011-06-10','YYYY-MM-DD'), 'https://SaraF.jpg', 'Doctorado', 42, 'Zona#0045');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000043', TO_DATE('2011-07-15','YYYY-MM-DD'), 'https://FelipeH.jpg', 'Pregrado', 43, 'Zona#0046');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000044', TO_DATE('2011-08-20','YYYY-MM-DD'), 'https://JulianaP.jpg', 'Maestria', 44, 'Zona#0047');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000045', TO_DATE('2011-09-25','YYYY-MM-DD'), 'https://DiegoG.jpg', 'Doctorado', 45, 'Zona#0048');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000046', TO_DATE('2011-10-30','YYYY-MM-DD'), 'https://CatalinaS.jpg', 'Pregrado', 46, 'Zona#0049');
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) VALUES ('CC', '1000000047', TO_DATE('2011-11-05','YYYY-MM-DD'), 'https://JuanM.jpg', 'Maestria', 47, 'Zona#0050');

--Calificaciones

INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000000', 4, 'Muy buen asesor pero se le forman filas prolongadas.', 'CC', '1000000056');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000001', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000000057');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000002', 5, 'El asesor es muy bueno, se nota que ama su trabajo.', 'CC', '1000000047');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000003', 2, 'Mal asesor, a veces se le olvidan las citas.', 'CC', '1000000046');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000004', 3, 'Regular asesor, no es muy atento.', 'CC', '1000000045');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000005', 4, 'Buen asesor, pero a veces se le olvidan las citas.', 'CC', '1000000044');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000006', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000000043');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000007', 4, 'Buen asesor, pero a veces se le olvidan las citas.', 'CC', '1000000042');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CE', '1000000008', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000000041');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('TI', '1000000009', 4, 'Buen asesor, pero a veces se le olvidan las citas.', 'CC', '1000000040');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000010', 3, 'Regular asesor, no es muy atento.', 'CC', '1000000039');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000011', 2, 'Mal asesor, a veces se le olvidan las citas.', 'CC', '1000000038');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000012', 1, 'Pésimo asesor, no es atento.', 'CC', '1000000037');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000013', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000000036');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000014', 4, 'Buen asesor, pero a veces se le olvidan las citas.', 'CC', '1000000035');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000015', 3, 'Regular asesor, no es muy atento.', 'CC', '1000000034');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000016', 2, 'Mal asesor, a veces se le olvidan las citas.', 'CC', '1000000033');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000017', 1, 'Pésimo asesor, no es atento.', 'CC', '1000000032');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000018', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000000031');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000019', 4, 'Buen asesor, pero a veces se le olvidan las citas.', 'CC', '1000000030');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000020', 3, 'Regular asesor, no es muy atento.', 'CC', '1000000029');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000021', 2, 'Mal asesor, a veces se le olvidan las citas.', 'CC', '1000000028');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000022', 1, 'Pésimo asesor, no es atento.', 'CC', '1000000027');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000023', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000000026');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000024', 4, 'Buen asesor, pero a veces se le olvidan las citas.', 'CC', '1000000025');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000025', 3, 'Regular asesor, no es muy atento.', 'CC', '1000000024');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000026', 2, 'Mal asesor, a veces se le olvidan las citas.', 'CC', '1000000023');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000027', 1, 'Pésimo asesor, no es atento.', 'CC', '1000000022');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000028', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000000021');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000029', 4, 'Buen asesor, pero a veces se le olvidan las citas.', 'CC', '1000000020');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000030', 3, 'Regular asesor, no es muy atento.', 'CC', '1000000019');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000031', 2, 'Mal asesor, a veces se le olvidan las citas.', 'CC', '1000000018');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000032', 1, 'Pésimo asesor, no es atento.', 'CC', '1000000017');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000033', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000000016');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000034', 4, 'Buen asesor, pero a veces se le olvidan las citas.', 'CC', '1000000015');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000035', 3, 'Regular asesor, no es muy atento.', 'CC', '1000000014');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000036', 2, 'Mal asesor, a veces se le olvidan las citas.', 'CC', '1000000013');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000037', 1, 'Pésimo asesor, no es atento.', 'CC', '1000000012');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000038', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000000011');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000039', 4, 'Buen asesor, pero a veces se le olvidan las citas.', 'CC', '1000000010');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000040', 3, 'Regular asesor, no es muy atento.', 'TI', '1000000009');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000041', 2, 'Mal asesor, a veces se le olvidan las citas.', 'CE', '1000000008');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000042', 1, 'Pésimo asesor, no es atento.', 'CC', '1000000007');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000043', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000000006');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000044', 4, 'Buen asesor, pero a veces se le olvidan las citas.', 'CC', '1000000005');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000045', 3, 'Regular asesor, no es muy atento.', 'CC', '1000000004');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000046', 2, 'Mal asesor, a veces se le olvidan las citas.', 'CC', '1000000003');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000047', 1, 'Pésimo asesor, no es atento.', 'CC', '1000000002');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000056', 5, 'Excelente asesor, muy buen trabajo.', 'CC', '1000000001');
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) VALUES ('CC', '1000000057', 4, 'Buen asesor, pero a veces se le olvidan las citas.', 'CC', '1000000000');

--Reservaciones

    --De Canchas

INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('15/06/2024 08:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000000', 'No.0000001', 'Zona#0001');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('15/06/2024 10:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000001', 'No.0000001', 'Zona#0002');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('15/06/2024 12:00','DD/MM/YYYY HH24:MI'), 3, 'CC', '1000000002', 'No.0000001', 'Zona#0003');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('16/06/2024 14:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000003', 'No.0000001', 'Zona#0004');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('16/06/2024 15:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000004', 'No.0000001', 'Zona#0005');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('16/06/2024 17:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000005', 'No.0000001', 'Zona#0006');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('17/06/2024 08:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000006', 'No.0000001', 'Zona#0007');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('17/06/2024 10:00','DD/MM/YYYY HH24:MI'), 3, 'CC', '1000000007', 'No.0000001', 'Zona#0008');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('17/06/2024 13:00','DD/MM/YYYY HH24:MI'), 4, 'CE', '1000000008', 'No.0000001', 'Zona#0009');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('18/06/2024 08:00','DD/MM/YYYY HH24:MI'), 2, 'TI', '1000000009', 'No.0000001', 'Zona#0010');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('18/06/2024 10:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000010', 'No.0000001', 'Zona#0011');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('18/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000011', 'No.0000001', 'Zona#0012');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('19/06/2024 08:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000012', 'No.0000001', 'Zona#0013');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('19/06/2024 09:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000013', 'No.0000001', 'Zona#0014');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('19/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000014', 'No.0000001', 'Zona#0015');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('20/06/2024 08:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000015', 'No.0000001', 'Zona#0016');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('20/06/2024 10:00','DD/MM/YYYY HH24:MI'), 3, 'CC', '1000000016', 'No.0000001', 'Zona#0017');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('20/06/2024 13:00','DD/MM/YYYY HH24:MI'), 4, 'CC', '1000000017', 'No.0000001', 'Zona#0018');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('21/06/2024 08:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000018', 'No.0000001', 'Zona#0019');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('21/06/2024 10:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000019', 'No.0000001', 'Zona#0020');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('21/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000020', 'No.0000001', 'Zona#0021');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('22/06/2024 08:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000021', 'No.0000001', 'Zona#0022');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('22/06/2024 09:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000022', 'No.0000001', 'Zona#0023');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('22/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000023', 'No.0000001', 'Zona#0024');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('23/06/2024 08:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000024', 'No.0000001', 'Zona#0025');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona) values (TO_DATE('23/06/2024 09:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000025', 'No.0000001', 'Zona#0026');

    --De Adicionales

INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('20/06/2024 10:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000026');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('20/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000027');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('20/06/2024 13:00','DD/MM/YYYY HH24:MI'), 4, 'CC', '1000000028');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('21/06/2024 08:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000029');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('21/06/2024 10:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000030');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('21/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000031');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('22/06/2024 08:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000032');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('22/06/2024 09:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000033');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('22/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000034');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('23/06/2024 08:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000035');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('23/06/2024 09:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000036');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('23/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000037');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('24/06/2024 08:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000038');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('24/06/2024 10:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000039');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('24/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000040');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('25/06/2024 08:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000041');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('25/06/2024 09:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000042');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('25/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000043');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('26/06/2024 08:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000044');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('26/06/2024 09:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000045');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('26/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000046');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('27/06/2024 08:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000047');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('27/06/2024 09:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000048');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('27/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000049');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('28/06/2024 08:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000050');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('28/06/2024 09:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000000051');
INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador) values (TO_DATE('28/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000052');

--Pagos -- Es automatico, pero podemos actualizar valores para que los pagos queden aprobados

UPDATE Pagos SET estado = 'Aprobado', metodo = 'PSE', fechaPago = SYSDATE
WHERE IDPago = 'Fact_No.0000001';
UPDATE Pagos SET estado = 'Aprobado', metodo = 'Transferencia', fechaPago = SYSDATE
WHERE IDPago = 'Fact_No.0000002';
UPDATE Pagos SET estado = 'Aprobado', metodo = 'Tarjeta de Debito', fechaPago = SYSDATE
WHERE IDPago = 'Fact_No.0000003';
UPDATE Pagos SET estado = 'Aprobado', metodo = 'Tarjeta de Credito', fechaPago = SYSDATE
WHERE IDPago = 'Fact_No.0000004';
UPDATE Pagos SET estado = 'Aprobado', fechaPago = SYSDATE
WHERE IDPago = 'Fact_No.0000005';
UPDATE Pagos SET estado = 'Aprobado', metodo = 'PSE', fechaPago = SYSDATE
WHERE IDPago = 'Fact_No.0000006';
UPDATE Pagos SET estado = 'Aprobado', metodo = 'Transferencia', fechaPago = SYSDATE
WHERE IDPago = 'Fact_No.0000007';
UPDATE Pagos SET estado = 'Aprobado', metodo = 'Tarjeta de Debito', fechaPago = SYSDATE
WHERE IDPago = 'Fact_No.0000008';
UPDATE Pagos SET estado = 'Aprobado', metodo = 'Tarjeta de Credito', fechaPago = SYSDATE
WHERE IDPago = 'Fact_No.0000009';
UPDATE Pagos SET estado = 'Aprobado', fechaPago = SYSDATE
WHERE IDPago = 'Fact_No.0000010';

--AdicionalesPorReservaciones

INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0001', 'No.0000001', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0002', 'No.0000002', 8);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0003', 'No.0000003', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0004', 'No.0000004', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0005', 'No.0000005', 5);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0006', 'No.0000006', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0007', 'No.0000007', 4);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0008', 'No.0000008', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0009', 'No.0000009', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0010', 'No.0000010', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0011', 'No.0000011', 4);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0012', 'No.0000012', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0013', 'No.0000013', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0014', 'No.0000014', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0015', 'No.0000015', 4);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0016', 'No.0000016', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0017', 'No.0000017', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0018', 'No.0000018', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0019', 'No.0000019', 4);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0020', 'No.0000020', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0021', 'No.0000021', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0022', 'No.0000022', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0023', 'No.0000023', 4);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0024', 'No.0000024', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0025', 'No.0000025', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0026', 'No.0000026', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0027', 'No.0000027', 4);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0028', 'No.0000028', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0029', 'No.0000029', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0030', 'No.0000030', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0031', 'No.0000031', 4);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0032', 'No.0000032', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0033', 'No.0000033', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0034', 'No.0000034', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0035', 'No.0000035', 4);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0036', 'No.0000036', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0037', 'No.0000037', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0038', 'No.0000038', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0039', 'No.0000039', 4);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0040', 'No.0000040', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0041', 'No.0000041', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0042', 'No.0000042', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0043', 'No.0000043', 4);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0044', 'No.0000044', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0045', 'No.0000045', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0046', 'No.0000046', 2);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0047', 'No.0000047', 4);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0048', 'No.0000048', 1);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0049', 'No.0000049', 3);
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0050', 'No.0000050', 2);

--------------------------------------------------------Consultas Gerenciales--------------------------------------------------------

--Consulta 1
// Consultar la actividad en cada una de las canchas durante el año.

/*
COMO Administrador
QUIERO Consultar la actividad en cada una de las canchas en el ultimo semestre
PARA PODER aumentar o disminuir el valor de reserva de la cancha teniendo en cuenta su ocupación durante el año

DETALLE:
Mes, Numero de reservas por cancha, IDZona, IDCancha, Precio de cancha
ORDER BY:
Mes
*/

SELECT EXTRACT(MONTH FROM fechaReservacion) AS Mes, IDZona, IDCancha, COUNT(*) AS NumeroReservaciones
FROM Reservaciones
WHERE IDCancha IS NOT NULL AND IDZona IS NOT NULL
GROUP BY EXTRACT(MONTH FROM fechaReservacion), IDZona, IDCancha
ORDER BY EXTRACT(MONTH FROM fechaReservacion), IDZona ASC;

--Consulta 2
// Consultar el feedback de los clientes por cancha durante el trimestre lectivo

/*
COMO Administrador
QUIERO Consultar el feedback de los clientes por cancha
PARA PODER llevar a cabo mejoras en las zonas deportivas y canchas alquiladas y de esta manera poder aumentar el costo del servicio

DETALLE:
Feedback, calificaciones menores o iguales a 4 estrellas

ORDER BY:
id de cancha
*/

SELECT calificacion, feedback FROM Calificaciones
WHERE calificacion <= 4;

--Consulta 3
// Consultar el total de ingresos generados por reserva durante el mes

/*
COMO Administrador
QUIERO Consultar el total de ingresos generados por reserva
PARA PODER mantener una gestión financiera clara y poder destinar recursos para mejoras de la infraestructura tanto a nivel físico (canchas y zonas deportivas) como a nivel tecnológico (base de datos y plataforma de reservaciones)

DETALLE:
Suma de los pagos realizados, id de reserva, id de cliente

ORDER BY:
amount
*/

--No se puede hacer aun porque no se ha hecho la relacion entre Reservaciones y Pagos con tarifas

--Consultas Operativas

--Consulta 1
// Consultar pagos realizados

/*
COMO Encargado de la zona deportiva
QUIERO conocer la información de los usuarios de reservación
PARA PODER hacer una gestion y analisis de la situación económica

DETALLE:
idUsuario, nombre, apellido, monto, fecha de pago
ORDER BY:
fecha de pago
*/

--No se puede hacer aun porque no se ha hecho la relacion entre Reservaciones y Pagos con tarifas

--Consulta 2
// Consultar acerca de los equipos

/*
COMO Encargado de la zona deportiva
QUIERO conocer la información de los equipos
PARA PODER conocer el número promedio de jugadores por cancha que juegan un partido en los establecimientos

DETALLE:
Equipo.id,
COUNT(Jugador.id) AS NumeroJugadores,
COUNT(DISTINCT Cancha.id) AS NumeroCanchas
GROUP BY:
Equipo.id
*/

SELECT IDEquipo, COUNT(IDJugador) AS NumeroJugadores, COUNT(DISTINCT IDCancha) AS NumeroCanchas FROM Equipos, Jugadores, Canchas;

--Consulta 3
// Consultar la actividad mensual en las zonas deportivas

/*
COMO Encargado de la zona deportiva
QUIERO conocer la actividad mensual en las canchas
PARA PODER asignar precios acorde a la utilización de las mismas

DETALLE:
Cancha.id,
COUNT(Reservacion.id) AS TotalReservaciones,
SUM(TIMESTAMPDIFF(MINUTE, Reservacion.FechaInicio, Reservacion.FechaFin)) AS DuracionTotalEnMinutos
GROUP BY:
Cancha.id;
*/

SELECT Canchas.IDCancha, COUNT(Reservaciones.IDReserva) AS TotalReservaciones, SUM(TIMESTAMPDIFF(MINUTE, Reservaciones.fechaReservacion, Reservaciones.fechaReservacion)) AS DuracionTotalEnMinutos FROM Canchas
JOIN Reservaciones ON Canchas.IDCancha = Reservaciones.IDCancha AND Canchas.IDZona = Reservaciones.IDZona
WHERE EXTRACT(MONTH FROM fechaReservacion) = EXTRACT(MONTH FROM SYSDATE)
GROUP BY Canchas.IDCancha;

--Consulta 4
// Consultar las canchas disponibles en las zonas deportivas

/*
COMO Encargado de la zona deportiva
QUIERO conocer las canchas disponibles en las zonas deportivas disponibles
PARA PODER ofrecerle al usuario un mejor servicio de atención

DETALLE:
Cancha.id,
Cancha.Nombre AS NombreCancha
*/

SELECT Canchas.IDCancha, Canchas.descripcion AS NombreCancha FROM Canchas
JOIN ZonasDeportivas ON Canchas.IDZona = ZonasDeportivas.IDZona
WHERE Canchas.estado = 'Activa';

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

------------------------xVistas------------------------------------

DROP VIEW VISTA_JUGADORES;
DROP VIEW VISTA_DISPONIBILIDAD_CANCHAS;
DROP VIEW VISTA_ESTADO_RESERVACION;
DROP VIEW VISTA_ESTADO_PAGO;
DROP VIEW VISTA_TOTAL_RESERVA_ESPECIFICA;

--------------------------------------------------------Componentes--------------------------------------------------------

--CRUDE

// Paquete para la gestión de reservaciones

CREATE OR REPLACE PACKAGE PC_Reservaciones AS

    PROCEDURE up_reservacion(IDReserva2 IN CHAR, IDPartido2 IN CHAR);
    PROCEDURE ad_reservacionCancha(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDZona2 IN CHAR);
    PROCEDURE ad_reservacionAdicional(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR);
    PROCEDURE de_reservacion(IDReserva2 IN CHAR);
    FUNCTION co_reservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE up_adicionalPorReservacion(IDReserva2 IN CHAR, IDAdicional2 IN CHAR, IDZona2 IN CHAR, cantidadAdicional2 IN NUMBER);
    PROCEDURE ad_adicionalPorReservacion(IDReserva2 IN CHAR, IDAdicional2 IN CHAR, IDZona2 IN CHAR, cantidadAdicional2 IN NUMBER);
    FUNCTION co_adicionalesPorReservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_adicionalPorReservacion(IDReserva2 IN CHAR, IDAdicional2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE up_pago(IDPago2 IN CHAR, estado2 IN VARCHAR, metodo2 IN VARCHAR);
    FUNCTION co_pago(IDPago2 IN CHAR) RETURN SYS_REFCURSOR;

END PC_Reservaciones;
/

// Paquete para la gestión de Jugadores

CREATE OR REPLACE PACKAGE PC_Jugadores AS
    
    PROCEDURE up_jugador(tid2 IN CHAR, nid2 IN VARCHAR, correo2 IN VARCHAR);
    PROCEDURE ad_jugador(tid2 IN CHAR, nid2 IN VARCHAR, nombre2 IN VARCHAR, apellido2 IN VARCHAR, correo2 IN VARCHAR, sexo2 IN VARCHAR, IDEquipo2 IN CHAR);
    PROCEDURE de_jugador(tid2 IN CHAR, nid2 IN VARCHAR);
    FUNCTION co_jugador(tid2 IN CHAR, nid2 IN VARCHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, telefono2 IN NUMBER);
    PROCEDURE de_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, telefono2 IN NUMBER);
    FUNCTION co_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, fechaContratacion2 IN DATE, foto2 IN VARCHAR, estudios2 IN VARCHAR, experiencia2 IN VARCHAR, IDZona2 IN CHAR);
    PROCEDURE up_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, foto2 IN VARCHAR);
    PROCEDURE de_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR);
    FUNCTION co_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, calificacion2 IN NUMBER, feedback2 IN VARCHAR, tidEncargado2 IN CHAR, nidEncargado2 IN VARCHAR);
    FUNCTION co_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR;

END PC_Jugadores;
/

// Paquete para la gestión de Zonas Deportivas

CREATE OR REPLACE PACKAGE PC_ZonasDeportivas AS

    PROCEDURE ad_zona(nombre2 IN VARCHAR, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR);
    PROCEDURE up_zona(IDZona2 IN CHAR, cantidadCanchas2 IN NUMBER);
    PROCEDURE de_zona(IDZona2 IN CHAR);
    FUNCTION co_zona(IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_cancha(IDZona2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR);
    PROCEDURE up_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR, estado2 IN VARCHAR);
    PROCEDURE de_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR);
    FUNCTION co_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_tarifa(IDCancha2 IN CHAR, IDZona2 IN CHAR, dia2 IN VARCHAR, horaInicio2 IN VARCHAR, precio2 IN NUMBER);
    PROCEDURE up_tarifa(IDTarifa2 IN CHAR, precio2 IN NUMBER);
    PROCEDURE de_tarifa(IDTarifa2 IN CHAR);
    FUNCTION co_tarifa(IDTarifa2 IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_adicional(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidad2 IN NUMBER, precioUnitario2 IN NUMBER, disponibilidad2 IN NUMBER);
    PROCEDURE up_adicionalPrecio(IDAdicional2 IN CHAR, IDZona2 IN CHAR, precioUnitario2 IN NUMBER);
    PROCEDURE up_adicionalDisponibilidad(IDAdicional2 IN CHAR, IDZona2 IN CHAR, disponibilidad2 IN NUMBER);
    PROCEDURE de_adicional(IDAdicional2 IN CHAR, IDZona2 IN CHAR);
    FUNCTION co_adicional(IDAdicional2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_adicionalPorNombre(nombre2 IN VARCHAR) RETURN SYS_REFCURSOR;

END PC_ZonasDeportivas;
/

// Paquete para la gestión de Equipos

CREATE OR REPLACE PACKAGE PC_Equipos AS

    PROCEDURE ad_equipo(nombre2 IN VARCHAR, numeroIntegrantes2 IN NUMBER);
    PROCEDURE up_equipoNombre(IDEquipo2 IN CHAR, nombre2 IN VARCHAR);
    PROCEDURE up_equipoNumeroIntegrantes(IDEquipo2 IN CHAR, numeroIntegrantes2 IN NUMBER);
    PROCEDURE de_equipo(IDEquipo2 IN CHAR);
    FUNCTION co_equipo(IDEquipo2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_equipoPorNombre(nombre2 IN VARCHAR) RETURN SYS_REFCURSOR;

END PC_Equipos;
/

// Paquete para la gestión de Partidos

CREATE OR REPLACE PACKAGE PC_Partidos AS

    PROCEDURE ad_partido(resultado2 IN VARCHAR);
    PROCEDURE de_partido(IDPartido2 IN CHAR);
    FUNCTION co_partido(IDPartido2 IN CHAR) RETURN SYS_REFCURSOR;

END PC_Partidos;
/

--CRUDI

// Implementación del paquete para la gestión de reservaciones

CREATE OR REPLACE PACKAGE BODY PC_Reservaciones AS

    PROCEDURE up_reservacion(IDReserva2 IN CHAR, IDPartido2 IN CHAR) IS
        BEGIN
            UPDATE Reservaciones SET IDPartido = IDPartido2
            WHERE IDReserva = IDReserva2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20001, 'No se pudo actualizar la reservación');
    END up_reservacion;

    PROCEDURE ad_reservacionCancha(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDZona2 IN CHAR) IS
        BEGIN
            INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona)
            VALUES (fechaReservacion2, tiempoTotal2, tidJugador2, nidJugador2, IDCancha2, IDZona2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20002, 'No se pudo agregar la reservación');
    END ad_reservacionCancha;

    PROCEDURE ad_reservacionAdicional(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador)
            VALUES (fechaReservacion2, tiempoTotal2, tidJugador2, nidJugador2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20003, 'No se pudo agregar la reservación');
    END ad_reservacionAdicional;

    PROCEDURE de_reservacion(IDReserva2 IN CHAR) IS
        BEGIN
            DELETE FROM Reservaciones
            WHERE IDReserva = IDReserva2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20004, 'No se pudo eliminar la reservación');
    END de_reservacion;

    FUNCTION co_reservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Reservaciones
            WHERE IDReserva = IDReserva2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, 'No se pudo consultar la reservación');
    END co_reservacion;

    PROCEDURE up_adicionalPorReservacion(IDReserva2 IN CHAR, IDAdicional2 IN CHAR, IDZona2 IN CHAR, cantidadAdicional2 IN NUMBER) IS
        BEGIN
            UPDATE AdicionalesPorReservaciones SET cantidadAdicional = cantidadAdicional2
            WHERE IDReserva = IDReserva2 AND IDAdicional = IDAdicional2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006, 'No se pudo actualizar el adicional por reservación');
    END up_adicionalPorReservacion;

    PROCEDURE ad_adicionalPorReservacion(IDReserva2 IN CHAR, IDAdicional2 IN CHAR, IDZona2 IN CHAR, cantidadAdicional2 IN NUMBER) IS
        BEGIN
            INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional)
            VALUES (IDAdicional2, IDZona2, IDReserva2, cantidadAdicional2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20007, 'No se pudo agregar el adicional por reservación');
    END ad_adicionalPorReservacion;

    FUNCTION co_adicionalesPorReservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM AdicionalesPorReservaciones
            WHERE IDReserva = IDReserva2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20008, 'No se pudo consultar los adicionales por reservación');
    END co_adicionalesPorReservacion;

    FUNCTION co_adicionalPorReservacion(IDReserva2 IN CHAR, IDAdicional2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM AdicionalesPorReservaciones
            WHERE IDReserva = IDReserva2 AND IDAdicional = IDAdicional2 AND IDZona = IDZona2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20009, 'No se pudo consultar el adicional por reservación');
    END co_adicionalPorReservacion;

    PROCEDURE up_pago(IDPago2 IN CHAR, estado2 IN VARCHAR, metodo2 IN VARCHAR) IS
        BEGIN
            UPDATE Pagos SET estado = estado2, metodo = metodo2, fechaPago = SYSDATE
            WHERE IDPago = IDPago2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20010, 'No se pudo actualizar el pago');
    END up_pago;

    FUNCTION co_pago(IDPago2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Pagos
            WHERE IDPago = IDPago2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20011, 'No se pudo consultar el pago');
    END co_pago;

END PC_Reservaciones;
/

// Implementación del paquete para la gestión de Jugadores

CREATE OR REPLACE PACKAGE BODY PC_Jugadores AS

    PROCEDURE up_jugador(tid2 IN CHAR, nid2 IN VARCHAR, correo2 IN VARCHAR) IS
        BEGIN
            UPDATE Jugadores SET correo = correo2
            WHERE tid = tid2 AND nid = nid2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20017, 'No se pudo actualizar el jugador');
    END up_jugador;

    PROCEDURE ad_jugador(tid2 IN CHAR, nid2 IN VARCHAR, nombre2 IN VARCHAR, apellido2 IN VARCHAR, correo2 IN VARCHAR, sexo2 IN VARCHAR, IDEquipo2 IN CHAR) IS
        BEGIN
            INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo)
            VALUES (tid2, nid2, nombre2, apellido2, correo2, sexo2, IDEquipo2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20018, 'No se pudo agregar el jugador');
    END ad_jugador;

    PROCEDURE de_jugador(tid2 IN CHAR, nid2 IN VARCHAR) IS
        BEGIN
            DELETE FROM Jugadores
            WHERE tid = tid2 AND nid = nid2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20019, 'No se pudo eliminar el jugador');
    END de_jugador;

    FUNCTION co_jugador(tid2 IN CHAR, nid2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Jugadores
            WHERE tid = tid2 AND nid = nid2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20020, 'No se pudo consultar el jugador');
    END co_jugador;

    PROCEDURE ad_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, telefono2 IN NUMBER) IS
        BEGIN
            INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono)
            VALUES (tidJugador2, nidJugador2, telefono2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20021, 'No se pudo agregar el teléfono por jugador');
    END ad_telefonosPorJugador;

    PROCEDURE de_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, telefono2 IN NUMBER) IS
        BEGIN
            DELETE FROM TelefonosPorJugador
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2 AND telefono = telefono2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20022, 'No se pudo eliminar el teléfono por jugador');
    END de_telefonosPorJugador;

    FUNCTION co_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM TelefonosPorJugador
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20023, 'No se pudo consultar los teléfonos por jugador');
    END co_telefonosPorJugador;

    PROCEDURE ad_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, fechaContratacion2 IN DATE, foto2 IN VARCHAR, estudios2 IN VARCHAR, experiencia2 IN VARCHAR, IDZona2 IN CHAR) IS
        BEGIN
            INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona)
            VALUES (tidJugador2, nidJugador2, fechaContratacion2, foto2, estudios2, experiencia2, IDZona2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20024, 'No se pudo agregar el encargado');
    END ad_encargado;

    PROCEDURE up_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, foto2 IN VARCHAR) IS
        BEGIN
            UPDATE Encargados SET foto = foto2
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20025, 'No se pudo actualizar el encargado');
    END up_encargado;

    PROCEDURE de_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) IS
        BEGIN
            DELETE FROM Encargados
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20026, 'No se pudo eliminar el encargado');
    END de_encargado;

    FUNCTION co_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Encargados
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20027, 'No se pudo consultar el encargado');
    END co_encargado;

    PROCEDURE ad_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, calificacion2 IN NUMBER, feedback2 IN VARCHAR, tidEncargado2 IN CHAR, nidEncargado2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado)
            VALUES (tidJugador2, nidJugador2, calificacion2, feedback2, tidEncargado2, nidEncargado2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20028, 'No se pudo agregar la calificación');
    END ad_calificacion;

    FUNCTION co_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Calificaciones
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20029, 'No se pudo consultar la calificación');
    END co_calificacion;

END PC_Jugadores;
/

// Implementación del paquete para la gestión de Zonas Deportivas

CREATE OR REPLACE PACKAGE BODY PC_ZonasDeportivas AS

    PROCEDURE ad_zona(nombre2 IN VARCHAR, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR) IS
        BEGIN
            INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area)
            VALUES (nombre2, direccion2, descripcion2, area2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20030, 'No se pudo agregar la zona deportiva');
        END ad_zona;

    PROCEDURE up_zona(IDZona2 IN CHAR, cantidadCanchas2 IN NUMBER) IS
        BEGIN
            UPDATE ZonasDeportivas SET cantidadCanchas = cantidadCanchas2
            WHERE IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20031, 'No se pudo actualizar la zona deportiva');
        END up_zona;

    PROCEDURE de_zona(IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM ZonasDeportivas
            WHERE IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20032, 'No se pudo eliminar la zona deportiva');
        END de_zona;

    FUNCTION co_zona(IDZona2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM ZonasDeportivas
            WHERE IDZona = IDZona2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20033, 'No se pudo consultar la zona deportiva');
        END co_zona;

    PROCEDURE ad_cancha(IDZona2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion)
            VALUES (IDZona2, capacidadJugadores2, estado2, dimensiones2, deporte2, descripcion2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20034, 'No se pudo agregar la cancha');
        END ad_cancha;

    PROCEDURE up_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR, estado2 IN VARCHAR) IS
        BEGIN
            UPDATE Canchas SET estado = estado2
            WHERE IDCancha = IDCancha2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20035, 'No se pudo actualizar la cancha');
        END up_cancha;

    PROCEDURE de_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM Canchas
            WHERE IDCancha = IDCancha2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20036, 'No se pudo eliminar la cancha');
        END de_cancha;

    FUNCTION co_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Canchas
            WHERE IDCancha = IDCancha2 AND IDZona = IDZona2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20037, 'No se pudo consultar la cancha');
        END co_cancha;

    PROCEDURE ad_tarifa(IDCancha2 IN CHAR, IDZona2 IN CHAR, dia2 IN VARCHAR, horaInicio2 IN VARCHAR, precio2 IN NUMBER) IS
        BEGIN
            INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio)
            VALUES (IDCancha2, IDZona2, dia2, horaInicio2, precio2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20038, 'No se pudo agregar la tarifa');
        END ad_tarifa;

    PROCEDURE up_tarifa(IDTarifa2 IN CHAR, precio2 IN NUMBER) IS
        BEGIN
            UPDATE Tarifas SET precio = precio2
            WHERE IDTarifa = IDTarifa2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20039, 'No se pudo actualizar la tarifa');
        END up_tarifa;

    PROCEDURE de_tarifa(IDTarifa2 IN CHAR) IS
        BEGIN
            DELETE FROM Tarifas
            WHERE IDTarifa = IDTarifa2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20040, 'No se pudo eliminar la tarifa');
        END de_tarifa;

    FUNCTION co_tarifa(IDTarifa2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Tarifas
            WHERE IDTarifa = IDTarifa2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20041, 'No se pudo consultar la tarifa');
        END co_tarifa;

    PROCEDURE ad_adicional(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidad2 IN NUMBER, precioUnitario2 IN NUMBER, disponibilidad2 IN NUMBER) IS
        BEGIN
            INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad)
            VALUES (IDZona2, nombre2, cantidad2, precioUnitario2, disponibilidad2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20042, 'No se pudo agregar el adicional');
        END ad_adicional;

    PROCEDURE up_adicionalPrecio(IDAdicional2 IN CHAR, IDZona2 IN CHAR, precioUnitario2 IN NUMBER) IS
        BEGIN
            UPDATE Adicionales SET precioUnitario = precioUnitario2
            WHERE IDAdicional = IDAdicional2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20043, 'No se pudo actualizar el precio del adicional');
        END up_adicionalPrecio;

    PROCEDURE up_adicionalDisponibilidad(IDAdicional2 IN CHAR, IDZona2 IN CHAR, disponibilidad2 IN NUMBER) IS
        BEGIN
            UPDATE Adicionales SET disponibilidad = disponibilidad2
            WHERE IDAdicional = IDAdicional2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20044, 'No se pudo actualizar la disponibilidad del adicional');
        END up_adicionalDisponibilidad;

    PROCEDURE de_adicional(IDAdicional2 IN CHAR, IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM Adicionales
            WHERE IDAdicional = IDAdicional2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20045, 'No se pudo eliminar el adicional');
        END de_adicional;

    FUNCTION co_adicional(IDAdicional2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Adicionales
            WHERE IDAdicional = IDAdicional2 AND IDZona = IDZona2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20046, 'No se pudo consultar el adicional');
        END co_adicional;

    FUNCTION co_adicionalPorNombre(nombre2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Adicionales
            WHERE nombre = nombre2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20047, 'No se pudo consultar el adicional por nombre');
        END co_adicionalPorNombre;

END PC_ZonasDeportivas;
/

// Implementación del paquete para la gestión de Equipos

CREATE OR REPLACE PACKAGE BODY PC_Equipos AS

    PROCEDURE ad_equipo(nombre2 IN VARCHAR, numeroIntegrantes2 IN NUMBER) IS
        BEGIN
            INSERT INTO Equipos (nombre, numeroIntegrantes)
            VALUES (nombre2, numeroIntegrantes2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20048, 'No se pudo agregar el equipo');
    END ad_equipo;

    PROCEDURE up_equipoNombre(IDEquipo2 IN CHAR, nombre2 IN VARCHAR) IS
        BEGIN
            UPDATE Equipos SET nombre = nombre2
            WHERE IDEquipo = IDEquipo2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20049, 'No se pudo actualizar el nombre del equipo');
    END up_equipoNombre;

    PROCEDURE up_equipoNumeroIntegrantes(IDEquipo2 IN CHAR, numeroIntegrantes2 IN NUMBER) IS
        BEGIN
            UPDATE Equipos SET numeroIntegrantes = numeroIntegrantes2
            WHERE IDEquipo = IDEquipo2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20050, 'No se pudo actualizar el número de integrantes del equipo');
    END up_equipoNumeroIntegrantes;

    PROCEDURE de_equipo(IDEquipo2 IN CHAR) IS
        BEGIN
            DELETE FROM Equipos
            WHERE IDEquipo = IDEquipo2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20051, 'No se pudo eliminar el equipo');
    END de_equipo;

    FUNCTION co_equipo(IDEquipo2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Equipos
            WHERE IDEquipo = IDEquipo2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20052, 'No se pudo consultar el equipo');
    END co_equipo;

    FUNCTION co_equipoPorNombre(nombre2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Equipos
            WHERE nombre = nombre2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20053, 'No se pudo consultar el equipo por nombre');
    END co_equipoPorNombre;

END PC_Equipos;
/

// Implementación del paquete para la gestión de Partidos

CREATE OR REPLACE PACKAGE BODY PC_Partidos AS

    PROCEDURE ad_partido(resultado2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Partidos (resultado)
            VALUES (resultado2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20054, 'No se pudo agregar el partido');
    END ad_partido;

    PROCEDURE de_partido(IDPartido2 IN CHAR) IS
        BEGIN
            DELETE FROM Partidos
            WHERE IDPartido = IDPartido2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20055, 'No se pudo eliminar el partido');
    END de_partido;

    FUNCTION co_partido(IDPartido2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Partidos
            WHERE IDPartido = IDPartido2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20056, 'No se pudo consultar el partido');
    END co_partido;

END PC_Partidos;
/

--XCRUD

DROP PACKAGE PC_Reservaciones;
DROP PACKAGE PC_Jugadores;
DROP PACKAGE PC_ZonasDeportivas;
DROP PACKAGE PC_Equipos;
DROP PACKAGE PC_Partidos;

--CRUDOK

// PC_Reservaciones : Insertar una nueva reservación

EXECUTE PC_Reservaciones.ad_reservacionCancha(TO_DATE('23/06/2024 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000000', 'No.0000001', 'Zona#0002');

SELECT * FROM Reservaciones;

-- Actualizar un pago

EXECUTE PC_Reservaciones.up_pago('Fact_No.0000011', 'Aprobado', 'Efectivo');

SELECT * FROM Pagos;

// PC_Jugadores : Actualizar la foto de un encargado

EXECUTE PC_Jugadores.up_encargado('CC', '1000000056', 'https://www.foto.com/Andres.jpg');

SELECT * FROM Encargados;

-- Agregar un nuevo jugador

EXECUTE PC_Jugadores.ad_jugador('CC', '1000000060', 'Carlos Emilio', 'Gonzales Ruiz', 'carlos.gon@gmail.com', 'Masculino', 'No.0000001');

SELECT * FROM Jugadores;

-- Consultar la informacion de un jugador

VARIABLE consultarJugador REFCURSOR;
EXECUTE :consultarJugador := PA_Administrador.co_jugador('CC', '1000000001');
PRINT :consultarJugador;

// PC_ZonasDeportivas : Eliminar un adicional de una zona deportiva

EXECUTE PC_ZonasDeportivas.de_adicional('AD0000001', 'Zona#0001');

SELECT * FROM Adicionales;

// PC_Equipos : Consultar la información de un equipo por su nombre

VARIABLE consultarEquipo REFCURSOR;
EXECUTE :consultarEquipo := PC_Equipos.co_equipoPorNombre('Real Madrid');
PRINT :consultarEquipo;

SELECT * FROM Equipos;

// PC_Partidos : Agregar un nuevo partido

EXECUTE PC_Partidos.ad_partido('1-5');

SELECT * FROM Partidos;

--CRUDNoOK

// PC_Reservaciones : Insertar una reservación con fechaReservacion antes de la fecha actual

EXECUTE PC_Reservaciones.ad_reservacionCancha(TO_DATE('23/08/2020 11:00','DD/MM/YYYY HH24:MI'), 1, 'CC', '1000000000', 'No.0000001', 'Zona#0002');

SELECT * FROM Reservaciones;

// PC_Jugadores : Actualizar el correo de un jugador que no existe

EXECUTE PC_Jugadores.up_jugador('CC', '1000000090', 'carlosalberto@gmail.com');

SELECT * FROM Jugadores;

// PC_ZonasDeportivas : Eliminar una zona deportiva que no existe

EXECUTE PC_ZonasDeportivas.de_zona('Zona#1000');

SELECT * FROM ZonasDeportivas;

// PC_Equipos : Consultar un equipo que no existe

VARIABLE consultarEquipo REFCURSOR;
EXECUTE :consultarEquipo := PC_Equipos.co_equipo('No.1000000');
PRINT :consultarEquipo;

SELECT * FROM Equipos;

// PC_Partidos : Agregar un nuevo partido con un resultado que no cumple con el formato

EXECUTE PC_Partidos.ad_partido('1.jpg');

SELECT * FROM Partidos;

--------------------------------------------------------Seguridad--------------------------------------------------------

--ActoresE

// Paquete Administrador

CREATE OR REPLACE PACKAGE PA_Administrador AS

    -- Jugadores
    PROCEDURE up_jugador(tid2 IN CHAR, nid2 IN VARCHAR, correo2 IN VARCHAR);
    PROCEDURE ad_jugador(tid2 IN CHAR, nid2 IN VARCHAR, nombre2 IN VARCHAR, apellido2 IN VARCHAR, correo2 IN VARCHAR, sexo2 IN VARCHAR, IDEquipo2 IN CHAR);
    PROCEDURE de_jugador(tid2 IN CHAR, nid2 IN VARCHAR);
    FUNCTION co_jugador(tid2 IN CHAR, nid2 IN VARCHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, telefono2 IN NUMBER);
    PROCEDURE de_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, telefono2 IN NUMBER);
    FUNCTION co_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, fechaContratacion2 IN DATE, foto2 IN VARCHAR, estudios2 IN VARCHAR, experiencia2 IN VARCHAR, IDZona2 IN CHAR);
    PROCEDURE up_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, foto2 IN VARCHAR);
    PROCEDURE de_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR);
    FUNCTION co_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR;

    -- Zonas Deportivas
    PROCEDURE ad_zona(nombre2 IN VARCHAR, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR);
    PROCEDURE up_zona(IDZona2 IN CHAR, cantidadCanchas2 IN NUMBER);
    PROCEDURE de_zona(IDZona2 IN CHAR);
    FUNCTION co_zona(IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_adicional(IDAdicional2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_adicionalPorNombre(nombre2 IN VARCHAR) RETURN SYS_REFCURSOR;
    
    -- Reservaciones
    PROCEDURE up_reservacion(IDReserva2 IN CHAR, IDPartido2 IN CHAR);
    PROCEDURE de_reservacion(IDReserva2 IN CHAR);
    FUNCTION co_reservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_adicionalPorReservacion(IDReserva2 IN CHAR, IDAdicional2 IN CHAR, IDZona2 IN CHAR, cantidadAdicional2 IN NUMBER);
    FUNCTION co_adicionalesPorReservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE up_pago(IDPago2 IN CHAR, estado2 IN VARCHAR, metodo2 IN VARCHAR);
    FUNCTION co_pago(IDPago2 IN CHAR) RETURN SYS_REFCURSOR;

    -- Equipos
    PROCEDURE ad_equipo(nombre2 IN VARCHAR, numeroIntegrantes2 IN NUMBER);
    PROCEDURE up_equipoNombre(IDEquipo2 IN CHAR, nombre2 IN VARCHAR);
    PROCEDURE up_equipoNumeroIntegrantes(IDEquipo2 IN CHAR, numeroIntegrantes2 IN NUMBER);
    PROCEDURE de_equipo(IDEquipo2 IN CHAR);
    FUNCTION co_equipo(IDEquipo2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_equipoPorNombre(nombre2 IN VARCHAR) RETURN SYS_REFCURSOR;

    -- Partidos
    PROCEDURE de_partido(IDPartido2 IN CHAR);
    FUNCTION co_partido(IDPartido2 IN CHAR) RETURN SYS_REFCURSOR;

END PA_Administrador;
/

// Paquete Encargado Zona Deportiva

CREATE OR REPLACE PACKAGE PA_EncargadoZonaDeportiva AS

    -- Zonas Deportivas
    FUNCTION co_zona(IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_cancha(IDZona2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR);
    PROCEDURE up_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR, estado2 IN VARCHAR);
    PROCEDURE de_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR);
    FUNCTION co_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_tarifa(IDCancha2 IN CHAR, IDZona2 IN CHAR, dia2 IN VARCHAR, horaInicio2 IN VARCHAR, precio2 IN NUMBER);
    PROCEDURE up_tarifa(IDTarifa2 IN CHAR, precio2 IN NUMBER);
    PROCEDURE de_tarifa(IDTarifa2 IN CHAR);
    FUNCTION co_tarifa(IDTarifa2 IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE ad_adicional(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidad2 IN NUMBER, precioUnitario2 IN NUMBER, disponibilidad2 IN NUMBER);
    PROCEDURE up_adicionalPrecio(IDAdicional2 IN CHAR, IDZona2 IN CHAR, precioUnitario2 IN NUMBER);
    PROCEDURE up_adicionalDisponibilidad(IDAdicional2 IN CHAR, IDZona2 IN CHAR, disponibilidad2 IN NUMBER);
    PROCEDURE de_adicional(IDAdicional2 IN CHAR, IDZona2 IN CHAR);
    FUNCTION co_adicional(IDAdicional2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_adicionalPorNombre(nombre2 IN VARCHAR) RETURN SYS_REFCURSOR;

    -- Reservaciones
    PROCEDURE ad_reservacionCancha(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDZona2 IN CHAR);
    PROCEDURE ad_reservacionAdicional(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR);
    FUNCTION co_reservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_pago(IDPago2 IN CHAR) RETURN SYS_REFCURSOR;

    -- Jugadores
    PROCEDURE ad_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, calificacion2 IN NUMBER, feedback2 IN VARCHAR, tidEncargado2 IN CHAR, nidEncargado2 IN VARCHAR);
    FUNCTION co_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR;

END PA_EncargadoZonaDeportiva;
/

// Paquete Usuario

CREATE OR REPLACE PACKAGE PA_Usuario AS

    -- Reservaciones
    PROCEDURE ad_reservacionCancha(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDZona2 IN CHAR);
    PROCEDURE ad_reservacionAdicional(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR);
    FUNCTION co_reservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_pago(IDPago2 IN CHAR) RETURN SYS_REFCURSOR;

    -- Jugadores
    PROCEDURE ad_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, calificacion2 IN NUMBER, feedback2 IN VARCHAR, tidEncargado2 IN CHAR, nidEncargado2 IN VARCHAR);
    FUNCTION co_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR;

END PA_Usuario;
/

--ActoresI

// Implementación del paquete Administrador

CREATE OR REPLACE PACKAGE BODY PA_Administrador AS

    -- Jugadores
    
    PROCEDURE up_jugador(tid2 IN CHAR, nid2 IN VARCHAR, correo2 IN VARCHAR) IS
        BEGIN
            UPDATE Jugadores SET correo = correo2
            WHERE tid = tid2 AND nid = nid2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20017, 'No se pudo actualizar el jugador');
    END up_jugador;

    PROCEDURE ad_jugador(tid2 IN CHAR, nid2 IN VARCHAR, nombre2 IN VARCHAR, apellido2 IN VARCHAR, correo2 IN VARCHAR, sexo2 IN VARCHAR, IDEquipo2 IN CHAR) IS
        BEGIN
            INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo)
            VALUES (tid2, nid2, nombre2, apellido2, correo2, sexo2, IDEquipo2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20018, 'No se pudo agregar el jugador');
    END ad_jugador;

    PROCEDURE de_jugador(tid2 IN CHAR, nid2 IN VARCHAR) IS
        BEGIN
            DELETE FROM Jugadores
            WHERE tid = tid2 AND nid = nid2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20019, 'No se pudo eliminar el jugador');
    END de_jugador;

    FUNCTION co_jugador(tid2 IN CHAR, nid2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Jugadores
            WHERE tid = tid2 AND nid = nid2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20020, 'No se pudo consultar el jugador');
    END co_jugador;

    PROCEDURE ad_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, telefono2 IN NUMBER) IS
        BEGIN
            INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono)
            VALUES (tidJugador2, nidJugador2, telefono2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20021, 'No se pudo agregar el teléfono por jugador');
    END ad_telefonosPorJugador;

    PROCEDURE de_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, telefono2 IN NUMBER) IS
        BEGIN
            DELETE FROM TelefonosPorJugador
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2 AND telefono = telefono2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20022, 'No se pudo eliminar el teléfono por jugador');
    END de_telefonosPorJugador;

    FUNCTION co_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM TelefonosPorJugador
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20023, 'No se pudo consultar los teléfonos por jugador');
    END co_telefonosPorJugador;

    PROCEDURE ad_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, fechaContratacion2 IN DATE, foto2 IN VARCHAR, estudios2 IN VARCHAR, experiencia2 IN VARCHAR, IDZona2 IN CHAR) IS
        BEGIN
            INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona)
            VALUES (tidJugador2, nidJugador2, fechaContratacion2, foto2, estudios2, experiencia2, IDZona2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20024, 'No se pudo agregar el encargado');
    END ad_encargado;

    PROCEDURE up_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, foto2 IN VARCHAR) IS
        BEGIN
            UPDATE Encargados SET foto = foto2
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20025, 'No se pudo actualizar el encargado');
    END up_encargado;

    PROCEDURE de_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) IS
        BEGIN
            DELETE FROM Encargados
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20026, 'No se pudo eliminar el encargado');
    END de_encargado;

    FUNCTION co_encargado(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Encargados
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20027, 'No se pudo consultar el encargado');
    END co_encargado;

    FUNCTION co_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Calificaciones
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20029, 'No se pudo consultar la calificación');
    END co_calificacion;

    -- Zonas Deportivas

    PROCEDURE ad_zona(nombre2 IN VARCHAR, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR) IS
        BEGIN
            INSERT INTO ZonasDeportivas (nombre, direccion, descripcion, area)
            VALUES (nombre2, direccion2, descripcion2, area2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20030, 'No se pudo agregar la zona deportiva');
        END ad_zona;

    PROCEDURE up_zona(IDZona2 IN CHAR, cantidadCanchas2 IN NUMBER) IS
        BEGIN
            UPDATE ZonasDeportivas SET cantidadCanchas = cantidadCanchas2
            WHERE IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20031, 'No se pudo actualizar la zona deportiva');
        END up_zona;

    PROCEDURE de_zona(IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM ZonasDeportivas
            WHERE IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20032, 'No se pudo eliminar la zona deportiva');
        END de_zona;

    FUNCTION co_zona(IDZona2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM ZonasDeportivas
            WHERE IDZona = IDZona2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20033, 'No se pudo consultar la zona deportiva');
        END co_zona;

        FUNCTION co_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Canchas
            WHERE IDCancha = IDCancha2 AND IDZona = IDZona2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20037, 'No se pudo consultar la cancha');
        END co_cancha;

        FUNCTION co_adicional(IDAdicional2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Adicionales
            WHERE IDAdicional = IDAdicional2 AND IDZona = IDZona2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20046, 'No se pudo consultar el adicional');
        END co_adicional;

    FUNCTION co_adicionalPorNombre(nombre2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Adicionales
            WHERE nombre = nombre2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20047, 'No se pudo consultar el adicional por nombre');
        END co_adicionalPorNombre;

    -- Reservaciones

    PROCEDURE up_reservacion(IDReserva2 IN CHAR, IDPartido2 IN CHAR) IS
        BEGIN
            UPDATE Reservaciones SET IDPartido = IDPartido2
            WHERE IDReserva = IDReserva2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20001, 'No se pudo actualizar la reservación');
    END up_reservacion;

    PROCEDURE de_reservacion(IDReserva2 IN CHAR) IS
        BEGIN
            DELETE FROM Reservaciones
            WHERE IDReserva = IDReserva2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20004, 'No se pudo eliminar la reservación');
    END de_reservacion;

    FUNCTION co_reservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Reservaciones
            WHERE IDReserva = IDReserva2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, 'No se pudo consultar la reservación');
    END co_reservacion;

    PROCEDURE ad_adicionalPorReservacion(IDReserva2 IN CHAR, IDAdicional2 IN CHAR, IDZona2 IN CHAR, cantidadAdicional2 IN NUMBER) IS
        BEGIN
            INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional)
            VALUES (IDAdicional2, IDZona2, IDReserva2, cantidadAdicional2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20007, 'No se pudo agregar el adicional por reservación');
    END ad_adicionalPorReservacion;

    FUNCTION co_adicionalesPorReservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM AdicionalesPorReservaciones
            WHERE IDReserva = IDReserva2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20008, 'No se pudo consultar los adicionales por reservación');
    END co_adicionalesPorReservacion;

    PROCEDURE up_pago(IDPago2 IN CHAR, estado2 IN VARCHAR, metodo2 IN VARCHAR) IS
        BEGIN
            UPDATE Pagos SET estado = estado2, metodo = metodo2, fechaPago = SYSDATE
            WHERE IDPago = IDPago2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20010, 'No se pudo actualizar el pago');
    END up_pago;

    FUNCTION co_pago(IDPago2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Pagos
            WHERE IDPago = IDPago2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20011, 'No se pudo consultar el pago');
    END co_pago;

    -- Equipos

    PROCEDURE ad_equipo(nombre2 IN VARCHAR, numeroIntegrantes2 IN NUMBER) IS
        BEGIN
            INSERT INTO Equipos (nombre, numeroIntegrantes)
            VALUES (nombre2, numeroIntegrantes2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20048, 'No se pudo agregar el equipo');
    END ad_equipo;

    PROCEDURE up_equipoNombre(IDEquipo2 IN CHAR, nombre2 IN VARCHAR) IS
        BEGIN
            UPDATE Equipos SET nombre = nombre2
            WHERE IDEquipo = IDEquipo2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20049, 'No se pudo actualizar el nombre del equipo');
    END up_equipoNombre;

    PROCEDURE up_equipoNumeroIntegrantes(IDEquipo2 IN CHAR, numeroIntegrantes2 IN NUMBER) IS
        BEGIN
            UPDATE Equipos SET numeroIntegrantes = numeroIntegrantes2
            WHERE IDEquipo = IDEquipo2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20050, 'No se pudo actualizar el número de integrantes del equipo');
    END up_equipoNumeroIntegrantes;

    PROCEDURE de_equipo(IDEquipo2 IN CHAR) IS
        BEGIN
            DELETE FROM Equipos
            WHERE IDEquipo = IDEquipo2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20051, 'No se pudo eliminar el equipo');
    END de_equipo;

    FUNCTION co_equipo(IDEquipo2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Equipos
            WHERE IDEquipo = IDEquipo2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20052, 'No se pudo consultar el equipo');
    END co_equipo;

    FUNCTION co_equipoPorNombre(nombre2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Equipos
            WHERE nombre = nombre2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20053, 'No se pudo consultar el equipo por nombre');
    END co_equipoPorNombre;

    -- Partidos

    PROCEDURE de_partido(IDPartido2 IN CHAR) IS
        BEGIN
            DELETE FROM Partidos
            WHERE IDPartido = IDPartido2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20055, 'No se pudo eliminar el partido');
    END de_partido;

    FUNCTION co_partido(IDPartido2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Partidos
            WHERE IDPartido = IDPartido2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20056, 'No se pudo consultar el partido');
    END co_partido;

END PA_Administrador;
/

// Implementación del paquete Encargado Zona Deportiva

CREATE OR REPLACE PACKAGE BODY PA_EncargadoZonaDeportiva AS

    -- Zonas Deportivas

    FUNCTION co_zona(IDZona2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM ZonasDeportivas
            WHERE IDZona = IDZona2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20033, 'No se pudo consultar la zona deportiva');
        END co_zona;

        PROCEDURE ad_cancha(IDZona2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion)
            VALUES (IDZona2, capacidadJugadores2, estado2, dimensiones2, deporte2, descripcion2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20034, 'No se pudo agregar la cancha');
        END ad_cancha;

    PROCEDURE up_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR, estado2 IN VARCHAR) IS
        BEGIN
            UPDATE Canchas SET estado = estado2
            WHERE IDCancha = IDCancha2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20035, 'No se pudo actualizar la cancha');
        END up_cancha;

    PROCEDURE de_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM Canchas
            WHERE IDCancha = IDCancha2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20036, 'No se pudo eliminar la cancha');
        END de_cancha;

    FUNCTION co_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Canchas
            WHERE IDCancha = IDCancha2 AND IDZona = IDZona2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20037, 'No se pudo consultar la cancha');
        END co_cancha;

        PROCEDURE ad_tarifa(IDCancha2 IN CHAR, IDZona2 IN CHAR, dia2 IN VARCHAR, horaInicio2 IN VARCHAR, precio2 IN NUMBER) IS
        BEGIN
            INSERT INTO Tarifas (IDCancha, IDZona, dia, horaInicio, precio)
            VALUES (IDCancha2, IDZona2, dia2, horaInicio2, precio2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20038, 'No se pudo agregar la tarifa');
        END ad_tarifa;

    PROCEDURE up_tarifa(IDTarifa2 IN CHAR, precio2 IN NUMBER) IS
        BEGIN
            UPDATE Tarifas SET precio = precio2
            WHERE IDTarifa = IDTarifa2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20039, 'No se pudo actualizar la tarifa');
        END up_tarifa;

    PROCEDURE de_tarifa(IDTarifa2 IN CHAR) IS
        BEGIN
            DELETE FROM Tarifas
            WHERE IDTarifa = IDTarifa2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20040, 'No se pudo eliminar la tarifa');
        END de_tarifa;

    FUNCTION co_tarifa(IDTarifa2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Tarifas
            WHERE IDTarifa = IDTarifa2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20041, 'No se pudo consultar la tarifa');
        END co_tarifa;

        PROCEDURE ad_adicional(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidad2 IN NUMBER, precioUnitario2 IN NUMBER, disponibilidad2 IN NUMBER) IS
        BEGIN
            INSERT INTO Adicionales (IDZona, nombre, cantidad, precioUnitario, disponibilidad)
            VALUES (IDZona2, nombre2, cantidad2, precioUnitario2, disponibilidad2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20042, 'No se pudo agregar el adicional');
        END ad_adicional;

    PROCEDURE up_adicionalPrecio(IDAdicional2 IN CHAR, IDZona2 IN CHAR, precioUnitario2 IN NUMBER) IS
        BEGIN
            UPDATE Adicionales SET precioUnitario = precioUnitario2
            WHERE IDAdicional = IDAdicional2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20043, 'No se pudo actualizar el precio del adicional');
        END up_adicionalPrecio;

    PROCEDURE up_adicionalDisponibilidad(IDAdicional2 IN CHAR, IDZona2 IN CHAR, disponibilidad2 IN NUMBER) IS
        BEGIN
            UPDATE Adicionales SET disponibilidad = disponibilidad2
            WHERE IDAdicional = IDAdicional2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20044, 'No se pudo actualizar la disponibilidad del adicional');
        END up_adicionalDisponibilidad;

    PROCEDURE de_adicional(IDAdicional2 IN CHAR, IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM Adicionales
            WHERE IDAdicional = IDAdicional2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20045, 'No se pudo eliminar el adicional');
        END de_adicional;

    FUNCTION co_adicional(IDAdicional2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Adicionales
            WHERE IDAdicional = IDAdicional2 AND IDZona = IDZona2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20046, 'No se pudo consultar el adicional');
        END co_adicional;

    FUNCTION co_adicionalPorNombre(nombre2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Adicionales
            WHERE nombre = nombre2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20047, 'No se pudo consultar el adicional por nombre');
        END co_adicionalPorNombre;

    -- Reservaciones

    PROCEDURE ad_reservacionCancha(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDZona2 IN CHAR) IS
        BEGIN
            INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona)
            VALUES (fechaReservacion2, tiempoTotal2, tidJugador2, nidJugador2, IDCancha2, IDZona2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20002, 'No se pudo agregar la reservación');
    END ad_reservacionCancha;

    PROCEDURE ad_reservacionAdicional(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador)
            VALUES (fechaReservacion2, tiempoTotal2, tidJugador2, nidJugador2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20003, 'No se pudo agregar la reservación');
    END ad_reservacionAdicional;

    FUNCTION co_reservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Reservaciones
            WHERE IDReserva = IDReserva2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, 'No se pudo consultar la reservación');
    END co_reservacion;

    FUNCTION co_pago(IDPago2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Pagos
            WHERE IDPago = IDPago2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20011, 'No se pudo consultar el pago');
    END co_pago;

    -- Jugadores

    PROCEDURE ad_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, calificacion2 IN NUMBER, feedback2 IN VARCHAR, tidEncargado2 IN CHAR, nidEncargado2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado)
            VALUES (tidJugador2, nidJugador2, calificacion2, feedback2, tidEncargado2, nidEncargado2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20028, 'No se pudo agregar la calificación');
    END ad_calificacion;

    FUNCTION co_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Calificaciones
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20029, 'No se pudo consultar la calificación');
    END co_calificacion;

END PA_EncargadoZonaDeportiva;
/

// Implementación del paquete Usuario

CREATE OR REPLACE PACKAGE BODY PA_Usuario AS

    -- Reservaciones

    PROCEDURE ad_reservacionCancha(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDZona2 IN CHAR) IS
        BEGIN
            INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona)
            VALUES (fechaReservacion2, tiempoTotal2, tidJugador2, nidJugador2, IDCancha2, IDZona2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20002, 'No se pudo agregar la reservación');
    END ad_reservacionCancha;

    PROCEDURE ad_reservacionAdicional(fechaReservacion2 IN DATE, tiempoTotal2 IN NUMBER, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador)
            VALUES (fechaReservacion2, tiempoTotal2, tidJugador2, nidJugador2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20003, 'No se pudo agregar la reservación');
    END ad_reservacionAdicional;

    FUNCTION co_reservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Reservaciones
            WHERE IDReserva = IDReserva2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20005, 'No se pudo consultar la reservación');
    END co_reservacion;

    FUNCTION co_pago(IDPago2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Pagos
            WHERE IDPago = IDPago2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20011, 'No se pudo consultar el pago');
    END co_pago;

    -- Jugadores

    PROCEDURE ad_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, calificacion2 IN NUMBER, feedback2 IN VARCHAR, tidEncargado2 IN CHAR, nidEncargado2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado)
            VALUES (tidJugador2, nidJugador2, calificacion2, feedback2, tidEncargado2, nidEncargado2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20028, 'No se pudo agregar la calificación');
    END ad_calificacion;

    FUNCTION co_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Calificaciones
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20029, 'No se pudo consultar la calificación');
    END co_calificacion;

END PA_Usuario;
/

-- Roles

CREATE ROLE Administrador_SportMatchV4;
CREATE ROLE EncargadoZonaDeportiva_SportMatchV4;
CREATE ROLE Usuario_SportMatchV4;

-- Permisos

GRANT EXECUTE ON PA_Administrador TO Administrador_SportMatchV4;
GRANT EXECUTE ON PA_EncargadoZonaDeportiva TO EncargadoZonaDeportiva_SportMatchV4;
GRANT EXECUTE ON PA_Usuario TO Usuario_SportMatchV4;

-- Asignación de roles

GRANT Administrador_SportMatchV4 TO BD1000092352;
GRANT EncargadoZonaDeportiva_SportMatchV4 TO BD1000092352; -- Samuel
GRANT Usuario_SportMatchV4 TO BD1000096920;

-- Xseguridad

DROP PACKAGE PA_Administrador;
DROP PACKAGE PA_EncargadoZonaDeportiva;
DROP PACKAGE PA_Usuario;

DROP ROLE Administrador_SportMatchV4;
DROP ROLE EncargadoZonaDeportiva_SportMatchV4;
DROP ROLE Usuario_SportMatchV4;

-- SeguridadOK

// Casos de prueba para Administrador_SportMatchV4

-- Actualizar el estado de un jugador en un equipo
EXECUTE DBMS_SESSION.SET_ROLE('Administrador_SportMatchV4');
EXECUTE PA_Administrador.up_jugador('CC', '1000000010', 'pepitoperez@gmail.com');

SELECT * FROM Jugadores WHERE tid = 'CC' AND nid = '1000000010';

-- Insertar una zona deportiva
EXECUTE PA_Administrador.ad_zona('SportMatch House', 'Calle 1 # 100 - 1', 'Zona deportiva con canchas de fútbol y baloncesto', '50m x 20m');

SELECT * FROM ZonasDeportivas;

-- Eliminar un equipo
EXECUTE PA_Administrador.de_equipo('No.0000003');

SELECT * FROM Equipos;

-- Consultar un adicional
VARIABLE consultarAdicional REFCURSOR;
EXECUTE :consultarAdicional := PA_Administrador.co_adicional('AD0000001', 'Zona#0005');
PRINT :consultarAdicional;

// Casos de prueba para EncargadoZonaDeportiva_SportMatchV4

-- Actualizar una tarifa
EXECUTE DBMS_SESSION.SET_ROLE('EncargadoZonaDeportiva_SportMatchV4');
EXECUTE PA_EncargadoZonaDeportiva.up_cancha('No.0000001', 'Zona#0049', 'Activa');

SELECT * FROM Canchas;

-- Insertar una nueva tarifa
EXECUTE PA_EncargadoZonaDeportiva.ad_tarifa('No.0000001', 'Zona#0002', 'Jueves', '18:00', 80000);

SELECT * FROM Tarifas;

-- Eliminar una tarifa
EXECUTE PA_EncargadoZonaDeportiva.de_tarifa('No.0000002');

SELECT * FROM Tarifas;

-- Consultar una cancha
VARIABLE consultarCancha REFCURSOR;
EXECUTE :consultarCancha := PA_EncargadoZonaDeportiva.co_cancha('No.0000001', 'Zona#0002');
PRINT :consultarCancha;

// Casos de prueba para Usuario_SportMatchV4

-- Insertar una nueva reservación de un adicional
EXECUTE DBMS_SESSION.SET_ROLE('Usuario_SportMatchV4');
EXECUTE PA_Usuario.ad_reservacionAdicional(TO_DATE('06/08/2024 09:00','DD/MM/YYYY HH24:MI'), 4, 'CC', '1000000002');

SELECT * FROM Reservaciones;

-- Consultar una reservación
VARIABLE consultarReservacion REFCURSOR;
EXECUTE :consultarReservacion := PA_Usuario.co_reservacion('No.0000010');
PRINT :consultarReservacion;

-- Insertar una nueva calificación
EXECUTE PA_Usuario.ad_calificacion('CC', '1000000002', 5, 'Excelente servicio', 'CC', '1000000001');

SELECT * FROM Calificaciones;

-- SeguridadNoOK

// Caso de prueba para Administrador_SportMatchV4

-- Eliminar una tarifa
EXECUTE DBMS_SESSION.SET_ROLE('Administrador_SportMatchV4');
EXECUTE PA_EncargadoZonaDeportiva.de_tarifa('No.0000002');

// Caso de prueba para EncargadoZonaDeportiva_SportMatchV4

-- Actualizar el nombre de un equipo
EXECUTE DBMS_SESSION.SET_ROLE('EncargadoZonaDeportiva_SportMatchV4');
EXECUTE PA_Administrador.up_equipo('No.0000002', 'Los Campeones');

// Caso de prueba para Usuario_SportMatchV4

-- Eliminar un equipo
EXECUTE DBMS_SESSION.SET_ROLE('Usuario_SportMatchV4');
EXECUTE PA_Administrador.de_equipo('No.0000001');

--------------------------------------------------------TuplasOK--------------------------------------------------------

INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) VALUES (TO_DATE('06/08/2024 09:00','DD/MM/YYYY HH24:MI'), 4, 'CC', '1000987654');
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDZona, IDReserva, cantidadAdicional) VALUES ('AD0000001', 'Zona#0001', 'No.0000007', 3);

--------------------------------------------------------TuplasNoOK--------------------------------------------------------

INSERT INTO Reservaciones (fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) VALUES ('Procesando', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-03-10','YYYY-MM-DD'), 2, 'CC', '1000987654');

--------------------------------------------------------PoblarNoOK--------------------------------------------------------

--Tarifas
--Fallara ya que no se admiten horarios repetidos en el mismo dia para la misma cancha (UK compuesta)
INSERT INTO Tarifas (IDTarifa, IDCancha, IDZona, dia, horaInicio, horaFin, precio) VALUES ('No.0000007', 'No.0000001', 'Zona#0003', 'Jueves', '18:00', '22:00', 80000);

--ZonasDeportivas
--Nos va a saltar un error ya que establecimos como valor nulo el atributo correspondiente al identificador de la zona deportiva (IDZona)
INSERT INTO ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area) values (null, 'El Campin', 15, 'Carrera 30 # 57', 'Lote de canchas sinteticas de futbol 5 al aire libre ubicado en Bogota D.C.', '105m x 68m');

--Canchas
--Manda error ya que el estado "Destruida" en la cancha no es un estado válido
INSERT INTO Canchas (IDCancha, IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('No.0000003', 'Zona#0001', 2, 'Destruida', '25m x 25m', 'Tenis', 'Cancha de Tenis');

--Adicionales
--Nos va a saltar un error porque la disponibilidad no esta en el rango de valores permitidos
INSERT INTO Adicionales (nombre, precioUnitario, disponibilidad) VALUES ('RAQUETA', 99000, 2);

--Partidos
--Fallara porque el resultado no cumple con el formato establecido
INSERT INTO Partidos (IDPartido, resultado) values ('No.0000004', '15');

--Equipos
--No va a permitir la insercion porque el nombre del equipo debe ser unico
INSERT INTO Equipos (IDEquipo, nombre, numeroIntegrantes) values ('No.0000004', 'Real Madrid', 11);

--EquiposJueganPartidos
--Va a fallar ya que el IDPartido no existe en la tabla Partidos
INSERT INTO EquiposJueganPartidos (IDEquipo, IDPartido) values ('No.0000005', 'No.0000005');

--Pagos
--Nos va a saltar un error ya que el metodo de pago no esta en el rango de valores permitidos
INSERT INTO Pagos (IDPago, estado, metodo) values ('Fact_No.0000007', 'Aprobado', 'Paypal');

--Jugadores
--Fallara ya que se esta haciendo referencia a un IDEquipo que no existe en la tabla Equipos
INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) values ('CC', '1009123456', 'Armando Rafael', 'Mejia Orjuela', null, 'Masculino', 'No.0000006');

--TelefonosPorJugador
--Fallara porque se esta tratando de insertar un telefono que ya ha sido insertado por el mismo jugador
INSERT INTO TelefonosPorJugador (tidJugador, nidJugador, telefono) values ('CC', '1000987654', 3001234567);

--Encargados
--Va a dar error porque la foto no cumple con el formato establecido
INSERT INTO Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) values ('CC', '1111234567', TO_DATE('2022-05-13','YYYY-MM-DD'), 'MariaGonzalez.pdf', 'Doctorado', 2, 'Zona#0003');

--Calificaciones
--Nos va a saltar un error ya que la calificacion no esta en el rango de valores permitidos
INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) values ('TI', '1001234567', 6, 'Muy buen asesor.', 'CC', '1000023456');

--Reservaciones
--Fallara porque el IDReserva ya existe
INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('No.0000006', 'Completada', TO_DATE('2024-04-01','YYYY-MM-DD'), TO_DATE('2024-04-10','YYYY-MM-DD'), 2, 'CC', '1010123456', 'FUT001', 'FUT534', '123456789101');

--AdicionalesPorReservaciones
--Nos va a saltar un error porque ya existe una entrada para ese mismo adicional en la misma reservacion
INSERT INTO AdicionalesPorReservaciones (IDAdicional, IDReserva) values ('AD0000003', 'No.0000006');

--------------------------------------------------------Xpoblar--------------------------------------------------------

DELETE FROM Tarifas;
DELETE FROM EquiposJueganPartidos;
DELETE FROM TelefonosPorJugador;
DELETE FROM Calificaciones;
DELETE FROM AdicionalesPorReservaciones;
DELETE FROM Reservaciones;
DELETE FROM Pagos;
DELETE FROM Encargados;
DELETE FROM Jugadores;
DELETE FROM Equipos;
DELETE FROM Canchas;
DELETE FROM Adicionales;
DELETE FROM ZonasDeportivas;
DELETE FROM Partidos;