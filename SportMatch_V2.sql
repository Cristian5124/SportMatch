--xTablas -- SE MODIFICÓ EL ORDEN DE ELIMINACIÓN

DROP TABLE TarifasPorCancha; --AGREGADO
DROP TABLE Tarifas;
DROP TABLE Calificaciones;
DROP TABLE Encargados;
DROP TABLE AdicionalesPorReservaciones;
DROP TABLE Reservaciones;
DROP TABLE Adicionales;
DROP TABLE TelefonosPorJugador;
DROP TABLE Jugadores;
DROP TABLE EquiposJueganPartidos;
DROP TABLE Equipos;
DROP TABLE Partidos;
DROP TABLE Pagos;
DROP TABLE Canchas;
DROP TABLE ZonasDeportivas;

--Tablas

CREATE TABLE Tarifas (
    IDTarifa CHAR(10) NOT NULL,
    dia VARCHAR(10) NOT NULL,
    horaInicio CHAR(5) NOT NULL,
    horaFin CHAR(5) NOT NULL,
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

CREATE TABLE TarifasPorCancha ( --AGREGADO
    IDCancha CHAR(10) NOT NULL,
    IDZona CHAR(9) NOT NULL,
    IDTarifa CHAR(10) NOT NULL
);

CREATE TABLE AdicionalesPorReservaciones (
    IDAdicional CHAR(9) NOT NULL,
    IDReserva CHAR(10)
);

CREATE TABLE Adicionales (
    IDAdicional CHAR(9) NOT NULL,
    nombre VARCHAR(30) NOT NULL, --AGREGADO
    cantidad NUMBER(2) NOT NULL,
    precio NUMBER(7) NOT NULL, 
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
    tiempoTotal VARCHAR(15) NOT NULL,
    tidJugador CHAR(2) NOT NULL,
    nidJugador VARCHAR(10) NOT NULL,
    IDCancha CHAR(10),
    IDZona CHAR(9),
    IDPartido CHAR(10),
    IDPago VARCHAR(20)
);

CREATE TABLE Pagos (
    IDPago VARCHAR(20) NOT NULL,
    estado VARCHAR(15) NOT NULL,
    metodo VARCHAR(20) NOT NULL
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
    IDZona CHAR(9) NOT NULL
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

--Llaves Primarias (PK)

ALTER TABLE Tarifas ADD CONSTRAINT PK_Tarifas PRIMARY KEY(IDTarifa);
ALTER TABLE Canchas ADD CONSTRAINT PK_Canchas PRIMARY KEY(IDCancha, IDZona);
ALTER TABLE TarifasPorCancha ADD CONSTRAINT PK_TarifasPorCancha PRIMARY KEY(IDCancha, IDZona, IDTarifa); --AGREGADO
ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT PK_AdicionalesPorReservaciones PRIMARY KEY(IDAdicional, IDReserva);
ALTER TABLE Adicionales ADD CONSTRAINT PK_Adicionales PRIMARY KEY(IDAdicional);
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

--Llaves Unicas (UK)

ALTER TABLE ZonasDeportivas ADD CONSTRAINT UK_ZonasDeportivas UNIQUE(direccion);
ALTER TABLE Encargados ADD CONSTRAINT UK_Encargados UNIQUE(foto);
ALTER TABLE Jugadores ADD CONSTRAINT UK_Jugadores UNIQUE(correo);
ALTER TABLE Equipos ADD CONSTRAINT UK_Equipos UNIQUE(nombre);
ALTER TABLE Adicionales ADD CONSTRAINT UK_Adicionales UNIQUE(nombre); --AGREGADO

--Llaves Foraneas (FK) + ACCIONES DE REFERENCIA

ALTER TABLE TarifasPorCancha ADD CONSTRAINT FK_TarifasPorCancha_Canchas FOREIGN KEY(IDCancha, IDZona) REFERENCES Canchas(IDCancha, IDZona) ON DELETE CASCADE; --AGREGADO
ALTER TABLE TarifasPorCancha ADD CONSTRAINT FK_TarifasPorCancha_Tarifas FOREIGN KEY(IDTarifa) REFERENCES Tarifas(IDTarifa) ON DELETE CASCADE; --AGREGADO
ALTER TABLE Canchas ADD CONSTRAINT FK_Canchas_ZonasDeportivas FOREIGN KEY(IDZona) REFERENCES ZonasDeportivas(IDZona) ON DELETE CASCADE;
ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT FK_AdicionalesPorReservaciones_Adicionales FOREIGN KEY(IDAdicional) REFERENCES Adicionales(IDAdicional) ON DELETE CASCADE;
ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT FK_AdicionalesPorReservaciones_Reservaciones FOREIGN KEY(IDReserva) REFERENCES Reservaciones(IDReserva) ON DELETE SET NULL;
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Canchas FOREIGN KEY(IDCancha, IDZona) REFERENCES Canchas(IDCancha, IDZona) ON DELETE SET NULL;
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Partidos FOREIGN KEY(IDPartido) REFERENCES Partidos(IDPartido) ON DELETE SET NULL;
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Pagos FOREIGN KEY(IDPago) REFERENCES Pagos(IDPago) ON DELETE CASCADE;
ALTER TABLE Encargados ADD CONSTRAINT FK_Encargados_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE Encargados ADD CONSTRAINT FK_Encargados_ZonasDeportivas FOREIGN KEY(IDZona) REFERENCES ZonasDeportivas(IDZona);
ALTER TABLE Calificaciones ADD CONSTRAINT FK_Calificaciones_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE Calificaciones ADD CONSTRAINT FK_Calificaciones_Encargados FOREIGN KEY(tidEncargado, nidEncargado) REFERENCES Encargados(tidJugador, nidJugador) ON DELETE CASCADE;
ALTER TABLE Jugadores ADD CONSTRAINT FK_Jugadores_Equipos FOREIGN KEY(IDEquipo) REFERENCES Equipos(IDEquipo) ON DELETE SET NULL;
ALTER TABLE TelefonosPorJugador ADD CONSTRAINT FK_TelefonosPorJugador_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE EquiposJueganPartidos ADD CONSTRAINT FK_EquiposJueganPartidos_Equipos FOREIGN KEY(IDEquipo) REFERENCES Equipos(IDEquipo) ON DELETE CASCADE;
ALTER TABLE EquiposJueganPartidos ADD CONSTRAINT FK_EquiposJueganPartidos_Partidos FOREIGN KEY(IDPartido) REFERENCES Partidos(IDPartido) ON DELETE CASCADE;

--Atributos

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_dia CHECK (dia IN ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo', 'Festivo'));

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_horaInicio CHECK (REGEXP_LIKE(horaInicio,'^([0-1]{1}[0-9]{1}|2[0-3]{1})(:)([0-5]{1})([0-9]{1})'));

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_horaFin CHECK (REGEXP_LIKE(horaFin,'^([0-1]{1}[0-9]{1}|2[0-3]{1})(:)([0-5]{1})([0-9]{1})'));

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_capacidadJugadores CHECK (capacidadJugadores > 0);

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_estado CHECK (estado in ('Activa', 'Mantenimiento', 'Inactiva'));

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_dimensiones CHECK (REGEXP_LIKE(dimensiones,'^([0-9]{1,4})(m)(\s)(\x)(\s)([0-9]{1,4})(m)'));

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_deporte CHECK (deporte in ('Futbol', 'Microfutbol', 'Baloncesto', 'Tenis', 'Volleyball', 'Padel'));

ALTER TABLE Adicionales ADD CONSTRAINT CK_Adicionales_cantidad CHECK (cantidad > 0);

ALTER TABLE Adicionales ADD CONSTRAINT CK_Adicionales_disponibilidad CHECK (disponibilidad in (0, 1));

ALTER TABLE Partidos ADD CONSTRAINT CK_Partidos_resultado CHECK (REGEXP_LIKE(resultado,'^([0-9]{1,3})(-)([0-9]{1,3})'));

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_estado CHECK (estado in ('Completada', 'Cancelada', 'Procesando'));

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_tiempoTotal CHECK (REGEXP_LIKE(tiempoTotal,'^(([1-9]{1}):(00|30)) h$')); --REVISAR

ALTER TABLE Pagos ADD CONSTRAINT CK_Pagos_estado CHECK (estado in ('Aprobado', 'Rechazado', 'Procesando'));

ALTER TABLE Pagos ADD CONSTRAINT CK_Pagos_metodo CHECK (metodo in ('Efectivo', 'Tarjeta de Credito', 'Tarjeta de Debito', 'Transferencia', 'PSE'));

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_cantidadCanchas CHECK (cantidadCanchas > 0);

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_direccion CHECK (direccion like ('%#%-%'));

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_area CHECK (REGEXP_LIKE(area,'^([0-9]{1,4})(m)(\s)(\x)(\s)([0-9]{1,4})(m)'));

ALTER TABLE Encargados ADD CONSTRAINT CK_Encargados_fechaContratacion CHECK (TRUNC(fechaContratacion) <= TRUNC(SYSDATE));

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

--Tuplas

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_fechaSolicitud_fechaReservacion CHECK (fechaSolicitud <= fechaReservacion);

--TuplasOK

INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) VALUES ('No.9999991', 'Procesando', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-04-11','YYYY-MM-DD'), '2:00 h', 'CC', '1010123456', NULL, NULL, NULL);

--TuplasNoOK

INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) VALUES ('No.9999992', 'Procesando', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-04-09','YYYY-MM-DD'), '2:00 h', 'CC', '1010123456', NULL, NULL, NULL);

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

--PoblarNoOK

--Tarifas
--Fallara ya que el dia no esta en el rango de valores permitidos
insert into Tarifas (IDTarifa, dia, horaInicio, horaFin, precio) values ('FUT000', 'Abril', '6:00', '8:00', 89000);

--ZonasDeportivas
--Nos va a saltar un error ya que establecimos como valor nulo el atributo correspondiente al identificador de la zona deportiva (IDZona)
insert into ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area) values (null, 'El Campin', 15, 'Carrera 30 # 57', 'Lote de canchas sinteticas de futbol 5 al aire libre ubicado en Bogota D.C.', '105m x 68m');

--Canchas
--Manda error ya que el IDTarifa no existe en la tabla Tarifas
insert into Canchas (IDCancha, capacidadJugadores, estado, dimensiones, IDZona, descripcion, deporte, IDTarifa) values ('No.0000001', 10, 'Activa', '25m * 7m', 'Zona#0001', 'Cancha sintetica de futbol 5 al aire libre', 'Futbol', 'No.0000099');

--Adicionales
--Nos va a saltar un error porque la disponibilidad no esta en el rango de valores permitidos
insert into Adicionales (IDAdicional, cantidad, precio, disponibilidad) values ('AD0001', 1, 99000, 2);

--Partidos
--Fallara porque el resultado no cumple con el formato establecido
insert into Partidos (IDPartido, resultado) values ('FUTBOL', '15');

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
insert into Encargados (tidJugador, nidJugador, fechaContratacion, foto, estudios, experiencia, IDZona) values ('TI', '1001234567', TO_DATE('2022-05-13','YYYY-MM-DD'), 'MariaGonzalez.pdf', 'Doctorado', 2, 'Zona#0003');

--Calificaciones
--Nos va a saltar un error ya que la calificacion no esta en el rango de valores permitidos
insert into Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado) values ('CC', '1010123456', 6, 'Muy buen asesor pero se le forman filas prolongadas.', 'CC', '1010123456');

--Reservaciones
--Fallara porque el IDReserva debe ser unico por lo que es la llave primaria pero ya se encuentra en la tabla
insert into Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) values ('FUT001', 'Hecha', TO_DATE('2024-04-01','YYYY-MM-DD'), TO_DATE('2024-04-10','YYYY-MM-DD'), '2:00 h', 'CC', '1010123456', 'FUT001', 'FUT534', '123456789101');

--AdicionalesPorReservaciones
--Nos va a saltar un error ya que el IDAdicional no cumple con el formato establecido
insert into AdicionalesPorReservaciones (IDAdicional, IDReserva) values ('A0101F', 'FUT001');

--Xpoblar

DELETE FROM TarifasPorCancha;
DELETE FROM Tarifas;
DELETE FROM Canchas;
DELETE FROM Calificaciones;
DELETE FROM Encargados;
DELETE FROM ZonasDeportivas;
DELETE FROM AdicionalesPorReservaciones;
DELETE FROM Reservaciones;
DELETE FROM Adicionales;
DELETE FROM TelefonosPorJugador;
DELETE FROM Jugadores;
DELETE FROM EquiposJueganPartidos;
DELETE FROM Equipos;
DELETE FROM Partidos;
DELETE FROM Pagos;

--Disparadores

--Disparador para aumentar la cantidad de canchas en ZonasDeportivas cuando se crea una nueva Cancha
CREATE OR REPLACE TRIGGER TG_Canchas_AI_aumentar_cantidades
AFTER INSERT ON Canchas
FOR EACH ROW
BEGIN
    UPDATE ZonasDeportivas
    SET cantidadCanchas = cantidadCanchas + 1
    WHERE IDZona = :NEW.IDZona; -- COMO SABE CUAL ZONA DEPORTIVA DEBE MODIFICAR ESPECIFICAMENTE?
END;
/
--DisparadorOK

INSERT INTO Canchas (IDCancha, IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('No.4444444', 'Zona#0001', 10, 'Activa', '25m x 7m', 'Futbol','Cancha sintetica de futbol 5 al aire libre');

SELECT * FROM ZonasDeportivas;

--Disparador para disminuir la cantidad de canchas en ZonasDeportivas cuando se elimina una Cancha
CREATE OR REPLACE TRIGGER TG_Canchas_AI_disminuir_cantidades
AFTER DELETE ON Canchas
FOR EACH ROW
BEGIN
    UPDATE ZonasDeportivas
    SET cantidadCanchas = cantidadCanchas - 1
    WHERE IDZona = :OLD.IDZona;
END;
/
--DisparadorOK

DELETE FROM Canchas
WHERE IDCancha = 'No.4444444';

SELECT * FROM ZonasDeportivas;

--Disparador para autoincrementar el valor de IDZona

CREATE OR REPLACE TRIGGER TG_ZonasDeportivas_IDZona
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

--DisparadorOK

INSERT INTO ZonasDeportivas (nombre, cantidadCanchas, direccion, descripcion, area) VALUES ('Polideportivo PEPESIERRA', 1, 'Carrera Deportiva #1213 - 1415', 'Polideportivo con amplias áreas verdes.', '80m x 120m');
SELECT * FROM ZonasDeportivas;

--Disparador para autoincrementar el valor de IDCancha

CREATE OR REPLACE TRIGGER TG_Canchas_IDCancha
BEFORE INSERT ON Canchas
FOR EACH ROW
DECLARE
    last_id NUMBER;
BEGIN
    -- Obtener el último IDCancha insertado
    SELECT TO_NUMBER(SUBSTR(MAX(IDCancha), 4)) INTO last_id FROM Canchas;

    -- Incrementar el último IDCancha

    --Si no se ha insertado ninguno, empieza en 0
    IF last_id IS NULL THEN
        last_id := 0;
    END IF;

    -- Generar el nuevo IDCancha con 7 dígitos
    :NEW.IDCancha := 'No.' || LPAD(last_id + 1, 7, '0');
END;
/

--DisparadorOK

INSERT INTO Canchas (IDZona, capacidadJugadores, estado, dimensiones, deporte, descripcion) VALUES ('Zona#0002', 14, 'Activa', '30m x 20m', 'Futbol', 'Cancha de Futbol 7');
SELECT * FROM Canchas;

--Disparador para autoincrementar el valor de IDTarifa

CREATE OR REPLACE TRIGGER TG_Tarifas_IDTarifa
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

--DisparadorOK

INSERT INTO Tarifas (dia, horaInicio, horaFin, precio) VALUES ('Festivo', '20:00', '24:00', 200000);
SELECT * FROM Tarifas;

--Disparador para autoincrementar el valor de IDAdicional

CREATE OR REPLACE TRIGGER TG_Adicionales_IDAdicional
BEFORE INSERT ON Adicionales
FOR EACH ROW
DECLARE
    last_id NUMBER;
BEGIN
    -- Obtener el último IDAdicional insertado
    SELECT TO_NUMBER(SUBSTR(MAX(IDAdicional), 3)) INTO last_id FROM Adicionales;

    -- Incrementar el último IDAdicional

    --Si no se ha insertado ninguno, empieza en 0
    IF last_id IS NULL THEN
        last_id := 0;
    END IF;

    -- Generar el nuevo IDAdicional con 7 dígitos
    :NEW.IDAdicional := 'AD' || LPAD(last_id + 1, 7, '0');
END;
/

--DisparadorOK

INSERT INTO Adicionales (nombre, cantidad, precio, disponibilidad) values ('MALETA', 2, 5000, 1);
SELECT * FROM Adicionales;

--XDisparadores

DROP TRIGGER TG_Canchas_AI_aumentar_cantidades;
DROP TRIGGER TG_Canchas_AI_disminuir_cantidades;
DROP TRIGGER TG_ZonasDeportivas_IDZona;
DROP TRIGGER TG_Canchas_IDCancha;
DROP TRIGGER TG_Tarifas_IDTarifa;
DROP TRIGGER TG_Adicionales_IDAdicional;

--Componentes

--CRUDE

// Paquete para la gestión de reservaciones

CREATE OR REPLACE PACKAGE PC_Reservaciones AS

    PROCEDURE up_reservacion(IDReserva2 IN CHAR, estado2 IN VARCHAR, fechaSolicitud2 IN DATE, fechaReservacion2 IN DATE, tiempoTotal2 IN VARCHAR, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDZona2 IN CHAR, IDPartido2 IN CHAR, IDPago2 IN VARCHAR);
    PROCEDURE ad_reservacion(IDReserva2 IN CHAR, estado2 IN VARCHAR, fechaSolicitud2 IN DATE, fechaReservacion2 IN DATE, tiempoTotal2 IN VARCHAR, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDPartido2 IN CHAR, IDPago2 IN VARCHAR);
    PROCEDURE de_reservacion(IDReserva2 IN CHAR);
    FUNCTION co_reservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE de_adicionalesPorReservacion(IDReserva2 IN CHAR);
    FUNCTION co_adicionalesPorReservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR;

END PC_Reservaciones;
/

// Paquete para la gestión de Jugadores

CREATE OR REPLACE PACKAGE PC_Jugadores AS
    
    PROCEDURE up_jugador(tid2 IN CHAR, nid2 IN VARCHAR, IDEquipo2 IN CHAR);
    PROCEDURE ad_jugador(tid2 IN CHAR, nid2 IN VARCHAR, nombre2 IN VARCHAR, apellido2 IN VARCHAR, correo2 IN VARCHAR, sexo2 IN VARCHAR, IDEquipo2 IN CHAR);
    PROCEDURE de_jugador(tid2 IN CHAR, nid2 IN VARCHAR);
    FUNCTION co_jugador(tid2 IN CHAR, nid2 IN VARCHAR) RETURN SYS_REFCURSOR;
    PROCEDURE de_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR);
    FUNCTION co_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR;

END PC_Jugadores;
/

// Paquete para la gestión de Canchas

CREATE OR REPLACE PACKAGE PC_Canchas AS

    PROCEDURE up_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR);
    PROCEDURE ad_cancha(IDCancha2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR);
    PROCEDURE de_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR);
    FUNCTION co_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_tarifaCancha(IDTarifa2 IN CHAR) RETURN SYS_REFCURSOR;

END PC_Canchas;
/

// Paquete para la gestión de Zonas Deportivas

CREATE OR REPLACE PACKAGE PC_ZonasDeportivas AS

    PROCEDURE up_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR);
    PROCEDURE ad_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR);
    PROCEDURE de_zona(IDZona2 IN CHAR);
    FUNCTION co_zona(IDZona2 IN CHAR) RETURN SYS_REFCURSOR;
    FUNCTION co_canchasPorZona(IDZona2 IN CHAR) RETURN SYS_REFCURSOR;

END PC_ZonasDeportivas;
/

// Paquete para la gestión de Adicionales

CREATE OR REPLACE PACKAGE PC_Adicionales AS

    PROCEDURE up_cantidadAdicional(IDAdicional2 IN CHAR, cantidad2 IN NUMBER);
    PROCEDURE up_precioAdicional(IDAdicional2 IN CHAR, precio2 IN NUMBER);
    PROCEDURE up_disponibilidadAdicional(IDAdicional2 IN CHAR, disponibilidad2 IN NUMBER);
    PROCEDURE ad_adicional(IDAdicional2 IN CHAR, cantidad2 IN NUMBER, precio2 IN NUMBER, disponibilidad2 IN NUMBER);
    PROCEDURE de_adicional(IDAdicional2 IN CHAR);
    FUNCTION co_adicional(IDAdicional2 IN CHAR) RETURN SYS_REFCURSOR;

END PC_Adicionales;
/

--CRUDI

// Paquete para la gestión de reservaciones

CREATE OR REPLACE PACKAGE BODY PC_Reservaciones AS

    PROCEDURE up_reservacion(IDReserva2 IN CHAR, estado2 IN VARCHAR, fechaSolicitud2 IN DATE, fechaReservacion2 IN DATE, tiempoTotal2 IN VARCHAR, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDZona2 IN CHAR, IDPartido2 IN CHAR, IDPago2 IN VARCHAR) IS
        BEGIN
            UPDATE Reservaciones SET estado = estado2, fechaSolicitud = fechaSolicitud2, fechaReservacion = fechaReservacion2, tiempoTotal = tiempoTotal2, tidJugador = tidJugador2, nidJugador = nidJugador2, IDCancha = IDCancha2, IDZona = IDZona2, IDPartido = IDPartido2, IDPago = IDPago2
            WHERE IDReserva = IDReserva2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20001, 'No se pudo actualizar la reservación');
    END up_reservacion;

    PROCEDURE ad_reservacion(IDReserva2 IN CHAR, estado2 IN VARCHAR, fechaSolicitud2 IN DATE, fechaReservacion2 IN DATE, tiempoTotal2 IN VARCHAR, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDPartido2 IN CHAR, IDPago2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago)
            VALUES (IDReserva2, estado2, fechaSolicitud2, fechaReservacion2, tiempoTotal2, tidJugador2, nidJugador2, IDCancha2, IDPartido2, IDPago2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20002, 'No se pudo agregar la reservación');
    END ad_reservacion;

    PROCEDURE de_reservacion(IDReserva2 IN CHAR) IS
        BEGIN
            DELETE FROM Reservaciones
            WHERE IDReserva = IDReserva2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20003, 'No se pudo eliminar la reservación');
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
                RAISE_APPLICATION_ERROR(-20004, 'No se pudo consultar la reservación');
    END co_reservacion;

    PROCEDURE de_adicionalesPorReservacion(IDReserva2 IN CHAR) IS
        BEGIN
            DELETE FROM AdicionalesPorReservaciones
            WHERE IDReserva = IDReserva2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20005, 'No se pudo eliminar los adicionales de la reservación');
    END de_adicionalesPorReservacion;

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
                RAISE_APPLICATION_ERROR(-20006, 'No se pudo consultar los adicionales de la reservación');
    END co_adicionalesPorReservacion;

END PC_Reservaciones;
/

// Paquete para la gestión de Jugadores

CREATE OR REPLACE PACKAGE BODY PC_Jugadores AS

    PROCEDURE up_jugador(tid2 IN CHAR, nid2 IN VARCHAR, IDEquipo2 IN CHAR) IS
        BEGIN
            UPDATE Jugadores SET IDEquipo = IDEquipo2
            WHERE tid = tid2 AND nid = nid2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20007, 'No se pudo actualizar el jugador');
    END up_jugador;

    PROCEDURE ad_jugador(tid2 IN CHAR, nid2 IN VARCHAR, nombre2 IN VARCHAR, apellido2 IN VARCHAR, correo2 IN VARCHAR, sexo2 IN VARCHAR, IDEquipo2 IN CHAR) IS
        BEGIN
            INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo)
            VALUES (tid2, nid2, nombre2, apellido2, correo2, sexo2, IDEquipo2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20008, 'No se pudo agregar el jugador');
    END ad_jugador;

    PROCEDURE de_jugador(tid2 IN CHAR, nid2 IN VARCHAR) IS
        BEGIN
            DELETE FROM Jugadores
            WHERE tid = tid2 AND nid = nid2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20009, 'No se pudo eliminar el jugador');
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
                RAISE_APPLICATION_ERROR(-20010, 'No se pudo consultar el jugador');
    END co_jugador;

    PROCEDURE de_telefonosPorJugador(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) IS
        BEGIN
            DELETE FROM TelefonosPorJugador
            WHERE tidJugador = tidJugador2 AND nidJugador = nidJugador2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20011, 'No se pudo eliminar los teléfonos del jugador');
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
                RAISE_APPLICATION_ERROR(-20012, 'No se pudo consultar los teléfonos del jugador');
    END co_telefonosPorJugador;

END PC_Jugadores;
/

// Paquete para la gestión de Canchas

CREATE OR REPLACE PACKAGE BODY PC_Canchas AS

    PROCEDURE up_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR) IS
        BEGIN
            UPDATE Canchas SET IDZona = IDZona2, capacidadJugadores = capacidadJugadores2, estado = estado2, dimensiones = dimensiones2, deporte = deporte2, descripcion = descripcion2, IDTarifa = IDTarifa2
            WHERE IDCancha = IDCancha2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20013, 'No se pudo actualizar la cancha');
    END up_cancha;

    PROCEDURE ad_cancha(IDCancha2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR) IS
        BEGIN
            INSERT INTO Canchas (IDCancha, capacidadJugadores, estado, dimensiones, deporte, descripcion, IDTarifa)
            VALUES (IDCancha2, capacidadJugadores2, estado2, dimensiones2, deporte2, descripcion2, IDTarifa2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20014, 'No se pudo agregar la cancha');
    END ad_cancha;

    PROCEDURE de_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM Canchas
            WHERE IDCancha = IDCancha2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20015, 'No se pudo eliminar la cancha');
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
                RAISE_APPLICATION_ERROR(-20016, 'No se pudo consultar la cancha');
    END co_cancha;

    FUNCTION co_tarifaCancha(IDTarifa2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Tarifas
            WHERE IDTarifa = IDTarifa2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20017, 'No se pudo consultar la tarifa de la cancha');
    END co_tarifaCancha;

END PC_Canchas;
/

// Paquete para la gestión de Zonas Deportivas

CREATE OR REPLACE PACKAGE BODY PC_ZonasDeportivas AS

    PROCEDURE up_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR) IS
        BEGIN
            UPDATE ZonasDeportivas SET nombre = nombre2, cantidadCanchas = cantidadCanchas2, direccion = direccion2, descripcion = descripcion2, area = area2
            WHERE IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20018, 'No se pudo actualizar la zona deportiva');
    END up_zona;

    PROCEDURE ad_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR) IS
        BEGIN
            INSERT INTO ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area)
            VALUES (IDZona2, nombre2, cantidadCanchas2, direccion2, descripcion2, area2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20019, 'No se pudo agregar la zona deportiva');
    END ad_zona;

    PROCEDURE de_zona(IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM ZonasDeportivas
            WHERE IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20020, 'No se pudo eliminar la zona deportiva');
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
                RAISE_APPLICATION_ERROR(-20021, 'No se pudo consultar la zona deportiva');
    END co_zona;

    FUNCTION co_canchasPorZona(IDZona2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Canchas
            WHERE IDZona = IDZona2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20022, 'No se pudo consultar las canchas de la zona deportiva');
    END co_canchasPorZona;

END PC_ZonasDeportivas;
/

// Paquete para la gestión de Adicionales

CREATE OR REPLACE PACKAGE BODY PC_Adicionales AS

    PROCEDURE up_cantidadAdicional(IDAdicional2 IN CHAR, cantidad2 IN NUMBER) IS
        BEGIN
            UPDATE Adicionales SET cantidad = cantidad2
            WHERE IDAdicional = IDAdicional2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20028, 'No se pudo actualizar la cantidad del adicional');
    END up_cantidadAdicional;
    
    PROCEDURE up_precioAdicional(IDAdicional2 IN CHAR, precio2 IN NUMBER) IS
        BEGIN
            UPDATE Adicionales SET precio = precio2
            WHERE IDAdicional = IDAdicional2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20023, 'No se pudo actualizar el precio del adicional');
    END up_precioAdicional;

    PROCEDURE up_disponibilidadAdicional(IDAdicional2 IN CHAR, disponibilidad2 IN NUMBER) IS
        BEGIN
            UPDATE Adicionales SET disponibilidad = disponibilidad2
            WHERE IDAdicional = IDAdicional2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20024, 'No se pudo actualizar la disponibilidad del adicional');
    END up_disponibilidadAdicional;

    PROCEDURE ad_adicional(IDAdicional2 IN CHAR, cantidad2 IN NUMBER, precio2 IN NUMBER, disponibilidad2 IN NUMBER) IS
        BEGIN
            INSERT INTO Adicionales (IDAdicional, cantidad, precio, disponibilidad)
            VALUES (IDAdicional2, cantidad2, precio2, disponibilidad2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20025, 'No se pudo agregar el adicional');
    END ad_adicional;

    PROCEDURE de_adicional(IDAdicional2 IN CHAR) IS
        BEGIN
            DELETE FROM Adicionales
            WHERE IDAdicional = IDAdicional2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20026, 'No se pudo eliminar el adicional');
    END de_adicional;

    FUNCTION co_adicional(IDAdicional2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Adicionales
            WHERE IDAdicional = IDAdicional2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20027, 'No se pudo consultar el adicional');
    END co_adicional;

END PC_Adicionales;
/

--XCRUD

DROP PACKAGE PC_Reservaciones;
DROP PACKAGE PC_Jugadores;
DROP PACKAGE PC_Canchas;
DROP PACKAGE PC_ZonasDeportivas;
DROP PACKAGE PC_Adicionales;

--CRUDOK

// PC_Reservaciones : Insertar una nueva reservación

EXECUTE PC_Reservaciones.ad_reservacion('No.0000007', 'Cancelada', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-05-10','YYYY-MM-DD'), '2:00 h', 'CC', '1000987654', 'No.0000001', 'No.0000001', 'Fact_No.1');

SELECT * FROM Reservaciones;

// PC_Jugadores : Actualizar el estado de un jugador en un equipo

EXECUTE PC_Jugadores.up_jugador('TI', '1001234567', 'No.0000002');

SELECT * FROM Jugadores;
SELECT * FROM Equipos;

// PC_Canchas : Eliminar una cancha de una zona deportiva

EXECUTE PC_Canchas.de_cancha('No.0000001', 'Zona#0001');

SELECT * FROM Canchas;

// PC_ZonasDeportivas : Consultar una zona deportiva

VARIABLE consultarZona REFCURSOR;
EXECUTE :consultarZona := PC_ZonasDeportivas.co_zona('Zona#0001');
PRINT :consultarZona;

SELECT * FROM ZonasDeportivas;

// PC_Adicionales : Actualizar la disponibilidad de un adicional

EXECUTE PC_Adicionales.up_disponibilidadAdicional('AD0000002', 1);

SELECT * FROM Adicionales;

--CRUDNoOK

// PC_Reservaciones : Insertar una reservación con un IDReserva que ya existe

EXECUTE PC_Reservaciones.ad_reservacion('No.0000007', 'Procesando', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-05-10','YYYY-MM-DD'), '2:00 h', 'CC', '1000987654', 'No.0000001', 'No.0000001', 'Fact_No.1');

SELECT * FROM Reservaciones;

// PC_Jugadores : Actualizar el estado de un jugador en un equipo que no existe

EXECUTE PC_Jugadores.up_jugador('TI', '1001234567', 'No.0000006');

SELECT * FROM Jugadores;

// PC_Canchas : Eliminar una cancha que no existe

EXECUTE PC_Canchas.de_cancha('No.0000008', 'Zona#0001');

SELECT * FROM Canchas;

// PC_ZonasDeportivas : Consultar una zona deportiva que no existe

VARIABLE consultarZona REFCURSOR;
EXECUTE :consultarZona := PC_ZonasDeportivas.co_zona('Zona#0010');
PRINT :consultarZona;

SELECT * FROM ZonasDeportivas;

// PC_Adicionales : Actualizar el precio de un adicional que no existe

EXECUTE PC_Adicionales.up_precioAdicional('AD7777777', 30000);

SELECT * FROM Adicionales;

--Seguridad

--ActoresE

// Paquete Administrador

CREATE OR REPLACE PACKAGE PA_Administrador AS

    -- Jugadores
    PROCEDURE up_jugador(tid2 IN CHAR, nid2 IN VARCHAR, IDEquipo2 IN CHAR);
    PROCEDURE ad_jugador(tid2 IN CHAR, nid2 IN VARCHAR, nombre2 IN VARCHAR, apellido2 IN VARCHAR, correo2 IN VARCHAR, sexo2 IN VARCHAR, IDEquipo2 IN CHAR);
    PROCEDURE de_jugador(tid2 IN CHAR, nid2 IN VARCHAR);
    FUNCTION co_jugador(tid2 IN CHAR, nid2 IN VARCHAR) RETURN SYS_REFCURSOR;

    -- Zonas Deportivas
    PROCEDURE up_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR);
    PROCEDURE ad_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR);
    PROCEDURE de_zona(IDZona2 IN CHAR);
    FUNCTION co_zona(IDZona2 IN CHAR) RETURN SYS_REFCURSOR;

    -- Canchas
    PROCEDURE up_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR);
    PROCEDURE ad_cancha(IDCancha2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR);
    PROCEDURE de_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR);
    FUNCTION co_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR;

    -- Equipos
    PROCEDURE up_equipo(IDEquipo2 IN CHAR, nombre2 IN VARCHAR);
    PROCEDURE ad_equipo(IDEquipo2 IN CHAR, nombre2 IN VARCHAR, numeroIntegrantes2 IN NUMBER);
    PROCEDURE de_equipo(IDEquipo2 IN CHAR);
    FUNCTION co_equipo(IDEquipo2 IN CHAR) RETURN SYS_REFCURSOR;

    -- Partidos
    PROCEDURE ad_partido(IDPartido2 IN CHAR, resultado2 IN VARCHAR);
    FUNCTION co_partido(IDPartido2 IN CHAR) RETURN SYS_REFCURSOR;
    
    -- Adicionales
    PROCEDURE up_cantidadAdicional(IDAdicional2 IN CHAR, cantidad2 IN NUMBER);
    PROCEDURE up_precioAdicional(IDAdicional2 IN CHAR, precio2 IN NUMBER);
    PROCEDURE up_disponibilidadAdicional(IDAdicional2 IN CHAR, disponibilidad2 IN NUMBER);
    PROCEDURE ad_adicional(IDAdicional2 IN CHAR, cantidad2 IN NUMBER, precio2 IN NUMBER, disponibilidad2 IN NUMBER);
    PROCEDURE de_adicional(IDAdicional2 IN CHAR);
    FUNCTION co_adicional(IDAdicional2 IN CHAR) RETURN SYS_REFCURSOR;

    -- Reservaciones
    PROCEDURE ad_reservacion(IDReserva2 IN CHAR, estado2 IN VARCHAR, fechaSolicitud2 IN DATE, fechaReservacion2 IN DATE, tiempoTotal2 IN VARCHAR, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDZona2 IN CHAR, IDPartido2 IN CHAR, IDPago2 IN VARCHAR);
    FUNCTION co_reservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR;

    -- Pagos
    PROCEDURE ad_pago(IDPago2 IN VARCHAR, estado2 IN VARCHAR, metodo2 IN VARCHAR);
    FUNCTION co_pago(IDPago2 IN VARCHAR) RETURN SYS_REFCURSOR;

END PA_Administrador;
/

// Paquete Encargado Zona Deportiva

CREATE OR REPLACE PACKAGE PA_EncargadoZonaDeportiva AS

    -- Zonas Deportivas
    PROCEDURE up_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR);
    PROCEDURE ad_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR);
    PROCEDURE de_zona(IDZona2 IN CHAR);
    FUNCTION co_zona(IDZona2 IN CHAR) RETURN SYS_REFCURSOR;

    -- Canchas
    PROCEDURE up_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR);
    PROCEDURE ad_cancha(IDCancha2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR);
    PROCEDURE de_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR);
    FUNCTION co_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) RETURN SYS_REFCURSOR;

    -- Tarifas
    PROCEDURE ad_tarifa(IDTarifa2 IN CHAR, dia2 IN VARCHAR, horaInicio2 IN VARCHAR, horaFin2 IN VARCHAR, precio2 IN NUMBER);
    FUNCTION co_tarifa(IDTarifa2 IN CHAR) RETURN SYS_REFCURSOR;

END PA_EncargadoZonaDeportiva;
/

// Paquete Usuario

CREATE OR REPLACE PACKAGE PA_Usuario AS

    -- Reservaciones
    PROCEDURE ad_reservacion(IDReserva2 IN CHAR, estado2 IN VARCHAR, fechaSolicitud2 IN DATE, fechaReservacion2 IN DATE, tiempoTotal2 IN VARCHAR, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDPartido2 IN CHAR, IDPago2 IN VARCHAR);
    FUNCTION co_reservacion(IDReserva2 IN CHAR) RETURN SYS_REFCURSOR;

    -- Pagos
    PROCEDURE ad_pago(IDPago2 IN VARCHAR, estado2 IN VARCHAR, metodo2 IN VARCHAR);
    FUNCTION co_pago(IDPago2 IN VARCHAR) RETURN SYS_REFCURSOR;

    -- Calificaciones
    PROCEDURE ad_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, calificacion2 IN NUMBER, feedback2 IN VARCHAR, tidEncargado2 IN CHAR, nidEncargado2 IN VARCHAR);
    FUNCTION co_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR) RETURN SYS_REFCURSOR;

END PA_Usuario;
/

--ActoresI

// Implementación del paquete Administrador

CREATE OR REPLACE PACKAGE BODY PA_Administrador AS

    -- Jugadores
    PROCEDURE up_jugador(tid2 IN CHAR, nid2 IN VARCHAR, IDEquipo2 IN CHAR) IS
        BEGIN
            UPDATE Jugadores SET IDEquipo = IDEquipo2
            WHERE tid = tid2 AND nid = nid2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20029, 'No se pudo actualizar el jugador');
    END up_jugador;

    PROCEDURE ad_jugador(tid2 IN CHAR, nid2 IN VARCHAR, nombre2 IN VARCHAR, apellido2 IN VARCHAR, correo2 IN VARCHAR, sexo2 IN VARCHAR, IDEquipo2 IN CHAR) IS
        BEGIN
            INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo)
            VALUES (tid2, nid2, nombre2, apellido2, correo2, sexo2, IDEquipo2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20030, 'No se pudo agregar el jugador');
    END ad_jugador;

    PROCEDURE de_jugador(tid2 IN CHAR, nid2 IN VARCHAR) IS
        BEGIN
            DELETE FROM Jugadores
            WHERE tid = tid2 AND nid = nid2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20031, 'No se pudo eliminar el jugador');
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
                RAISE_APPLICATION_ERROR(-20032, 'No se pudo consultar el jugador');
    END co_jugador;

    -- Zonas Deportivas
    PROCEDURE up_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR) IS
        BEGIN
            UPDATE ZonasDeportivas SET nombre = nombre2, cantidadCanchas = cantidadCanchas2, direccion = direccion2, descripcion = descripcion2, area = area2
            WHERE IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20033, 'No se pudo actualizar la zona deportiva');
    END up_zona;

    PROCEDURE ad_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR) IS
        BEGIN
            INSERT INTO ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area)
            VALUES (IDZona2, nombre2, cantidadCanchas2, direccion2, descripcion2, area2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20034, 'No se pudo agregar la zona deportiva');
    END ad_zona;

    PROCEDURE de_zona(IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM ZonasDeportivas
            WHERE IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20035, 'No se pudo eliminar la zona deportiva');
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
                RAISE_APPLICATION_ERROR(-20036, 'No se pudo consultar la zona deportiva');
    END co_zona;

    -- Canchas
    PROCEDURE up_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR) IS
        BEGIN
            UPDATE Canchas SET IDZona = IDZona2, capacidadJugadores = capacidadJugadores2, estado = estado2, dimensiones = dimensiones2, deporte = deporte2, descripcion = descripcion2, IDTarifa = IDTarifa2
            WHERE IDCancha = IDCancha2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20037, 'No se pudo actualizar la cancha');
    END up_cancha;

    PROCEDURE ad_cancha(IDCancha2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR) IS
        BEGIN
            INSERT INTO Canchas (IDCancha, capacidadJugadores, estado, dimensiones, deporte, descripcion, IDTarifa)
            VALUES (IDCancha2, capacidadJugadores2, estado2, dimensiones2, deporte2, descripcion2, IDTarifa2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20038, 'No se pudo agregar la cancha');
    END ad_cancha;

    PROCEDURE de_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM Canchas
            WHERE IDCancha = IDCancha2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20039, 'No se pudo eliminar la cancha');
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
                RAISE_APPLICATION_ERROR(-20040, 'No se pudo consultar la cancha');
    END co_cancha;

    -- Equipos
    PROCEDURE up_equipo(IDEquipo2 IN CHAR, nombre2 IN VARCHAR) IS
        BEGIN
            UPDATE Equipos SET nombre = nombre2
            WHERE IDEquipo = IDEquipo2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20041, 'No se pudo actualizar el equipo');
    END up_equipo;

    PROCEDURE ad_equipo(IDEquipo2 IN CHAR, nombre2 IN VARCHAR, numeroIntegrantes2 IN NUMBER) IS
        BEGIN
            INSERT INTO Equipos (IDEquipo, nombre, numeroIntegrantes)
            VALUES (IDEquipo2, nombre2, numeroIntegrantes2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20042, 'No se pudo agregar el equipo');
    END ad_equipo;

    PROCEDURE de_equipo(IDEquipo2 IN CHAR) IS
        BEGIN
            DELETE FROM Equipos
            WHERE IDEquipo = IDEquipo2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20043, 'No se pudo eliminar el equipo');
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
                RAISE_APPLICATION_ERROR(-20044, 'No se pudo consultar el equipo');
    END co_equipo;

    -- Partidos
    PROCEDURE ad_partido(IDPartido2 IN CHAR, resultado2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Partidos (IDPartido, resultado)
            VALUES (IDPartido2, resultado2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20045, 'No se pudo agregar el partido');
    END ad_partido;

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
                RAISE_APPLICATION_ERROR(-20046, 'No se pudo consultar el partido');
    END co_partido;

    -- Adicionales
    PROCEDURE up_cantidadAdicional(IDAdicional2 IN CHAR, cantidad2 IN NUMBER) IS
        BEGIN
            UPDATE Adicionales SET cantidad = cantidad2
            WHERE IDAdicional = IDAdicional2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20047, 'No se pudo actualizar la cantidad del adicional');
    END up_cantidadAdicional;

    PROCEDURE up_precioAdicional(IDAdicional2 IN CHAR, precio2 IN NUMBER) IS
        BEGIN
            UPDATE Adicionales SET precio = precio2
            WHERE IDAdicional = IDAdicional2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20048, 'No se pudo actualizar el precio del adicional');
    END up_precioAdicional;

    PROCEDURE up_disponibilidadAdicional(IDAdicional2 IN CHAR, disponibilidad2 IN NUMBER) IS
        BEGIN
            UPDATE Adicionales SET disponibilidad = disponibilidad2
            WHERE IDAdicional = IDAdicional2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20049, 'No se pudo actualizar la disponibilidad del adicional');
    END up_disponibilidadAdicional;

    PROCEDURE ad_adicional(IDAdicional2 IN CHAR, cantidad2 IN NUMBER, precio2 IN NUMBER, disponibilidad2 IN NUMBER) IS
        BEGIN
            INSERT INTO Adicionales (IDAdicional, cantidad, precio, disponibilidad)
            VALUES (IDAdicional2, cantidad2, precio2, disponibilidad2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20050, 'No se pudo agregar el adicional');
    END ad_adicional;
    
    PROCEDURE de_adicional(IDAdicional2 IN CHAR) IS
        BEGIN
            DELETE FROM Adicionales
            WHERE IDAdicional = IDAdicional2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20051, 'No se pudo eliminar el adicional');
    END de_adicional;

    FUNCTION co_adicional(IDAdicional2 IN CHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Adicionales
            WHERE IDAdicional = IDAdicional2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20052, 'No se pudo consultar el adicional');
    END co_adicional;

    -- Reservaciones
    PROCEDURE ad_reservacion(IDReserva2 IN CHAR, estado2 IN VARCHAR, fechaSolicitud2 IN DATE, fechaReservacion2 IN DATE, tiempoTotal2 IN VARCHAR, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDZona2 IN CHAR, IDPartido2 IN CHAR, IDPago2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDZona, IDPartido, IDPago)
            VALUES (IDReserva2, estado2, fechaSolicitud2, fechaReservacion2, tiempoTotal2, tidJugador2, nidJugador2, IDCancha2, IDZona2, IDPartido2, IDPago2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20053, 'No se pudo agregar la reservación');
    END ad_reservacion;

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
                RAISE_APPLICATION_ERROR(-20054, 'No se pudo consultar la reservación');
    END co_reservacion;

    -- Pagos
    PROCEDURE ad_pago(IDPago2 IN VARCHAR, estado2 IN VARCHAR, metodo2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Pagos (IDPago, estado, metodo)
            VALUES (IDPago2, estado2, metodo2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20055, 'No se pudo agregar el pago');
    END ad_pago;

    FUNCTION co_pago(IDPago2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Pagos
            WHERE IDPago = IDPago2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20056, 'No se pudo consultar el pago');
    END co_pago;

END PA_Administrador;
/

// Implementación del paquete Encargado Zona Deportiva

CREATE OR REPLACE PACKAGE BODY PA_EncargadoZonaDeportiva AS

    -- Zonas Deportivas
    PROCEDURE up_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR) IS
        BEGIN
            UPDATE ZonasDeportivas SET nombre = nombre2, cantidadCanchas = cantidadCanchas2, direccion = direccion2, descripcion = descripcion2, area = area2
            WHERE IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20057, 'No se pudo actualizar la zona deportiva');
    END up_zona;

    PROCEDURE ad_zona(IDZona2 IN CHAR, nombre2 IN VARCHAR, cantidadCanchas2 IN NUMBER, direccion2 IN VARCHAR, descripcion2 IN VARCHAR, area2 IN VARCHAR) IS
        BEGIN
            INSERT INTO ZonasDeportivas (IDZona, nombre, cantidadCanchas, direccion, descripcion, area)
            VALUES (IDZona2, nombre2, cantidadCanchas2, direccion2, descripcion2, area2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20058, 'No se pudo agregar la zona deportiva');
    END ad_zona;

    PROCEDURE de_zona(IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM ZonasDeportivas
            WHERE IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20059, 'No se pudo eliminar la zona deportiva');
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
                RAISE_APPLICATION_ERROR(-20060, 'No se pudo consultar la zona deportiva');
    END co_zona;

    -- Canchas
    PROCEDURE up_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR) IS
        BEGIN
            UPDATE Canchas SET IDZona = IDZona2, capacidadJugadores = capacidadJugadores2, estado = estado2, dimensiones = dimensiones2, deporte = deporte2, descripcion = descripcion2, IDTarifa = IDTarifa2
            WHERE IDCancha = IDCancha2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20061, 'No se pudo actualizar la cancha');
    END up_cancha;

    PROCEDURE ad_cancha(IDCancha2 IN CHAR, capacidadJugadores2 IN NUMBER, estado2 IN VARCHAR, dimensiones2 IN VARCHAR, deporte2 IN VARCHAR, descripcion2 IN VARCHAR, IDTarifa2 IN CHAR) IS
        BEGIN
            INSERT INTO Canchas (IDCancha, capacidadJugadores, estado, dimensiones, deporte, descripcion, IDTarifa)
            VALUES (IDCancha2, capacidadJugadores2, estado2, dimensiones2, deporte2, descripcion2, IDTarifa2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20062, 'No se pudo agregar la cancha');
    END ad_cancha;

    PROCEDURE de_cancha(IDCancha2 IN CHAR, IDZona2 IN CHAR) IS
        BEGIN
            DELETE FROM Canchas
            WHERE IDCancha = IDCancha2 AND IDZona = IDZona2;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20063, 'No se pudo eliminar la cancha');
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
                RAISE_APPLICATION_ERROR(-20064, 'No se pudo consultar la cancha');
    END co_cancha;

    -- Tarifas
    PROCEDURE ad_tarifa(IDTarifa2 IN CHAR, dia2 IN VARCHAR, horaInicio2 IN VARCHAR, horaFin2 IN VARCHAR, precio2 IN NUMBER) IS
        BEGIN
            INSERT INTO Tarifas (IDTarifa, dia, horaInicio, horaFin, precio)
            VALUES (IDTarifa2, dia2, horaInicio2, horaFin2, precio2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20065, 'No se pudo agregar la tarifa');
    END ad_tarifa;

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
                RAISE_APPLICATION_ERROR(-20066, 'No se pudo consultar la tarifa');
    END co_tarifa;

END PA_EncargadoZonaDeportiva;
/

// Implementación del paquete Usuario

CREATE OR REPLACE PACKAGE BODY PA_Usuario AS

    -- Reservaciones
    PROCEDURE ad_reservacion(IDReserva2 IN CHAR, estado2 IN VARCHAR, fechaSolicitud2 IN DATE, fechaReservacion2 IN DATE, tiempoTotal2 IN VARCHAR, tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, IDCancha2 IN CHAR, IDPartido2 IN CHAR, IDPago2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago)
            VALUES (IDReserva2, estado2, fechaSolicitud2, fechaReservacion2, tiempoTotal2, tidJugador2, nidJugador2, IDCancha2, IDPartido2, IDPago2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20067, 'No se pudo agregar la reservación');
    END ad_reservacion;

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
                RAISE_APPLICATION_ERROR(-20068, 'No se pudo consultar la reservación');
    END co_reservacion;

    -- Pagos
    PROCEDURE ad_pago(IDPago2 IN VARCHAR, estado2 IN VARCHAR, metodo2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Pagos (IDPago, estado, metodo)
            VALUES (IDPago2, estado2, metodo2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20069, 'No se pudo agregar el pago');
    END ad_pago;

    FUNCTION co_pago(IDPago2 IN VARCHAR) RETURN SYS_REFCURSOR IS
        c SYS_REFCURSOR;
        BEGIN
            OPEN c FOR
            SELECT *
            FROM Pagos
            WHERE IDPago = IDPago2;
            RETURN c;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20070, 'No se pudo consultar el pago');
    END co_pago;

    -- Calificaciones
    PROCEDURE ad_calificacion(tidJugador2 IN CHAR, nidJugador2 IN VARCHAR, calificacion2 IN NUMBER, feedback2 IN VARCHAR, tidEncargado2 IN CHAR, nidEncargado2 IN VARCHAR) IS
        BEGIN
            INSERT INTO Calificaciones (tidJugador, nidJugador, calificacion, feedback, tidEncargado, nidEncargado)
            VALUES (tidJugador2, nidJugador2, calificacion2, feedback2, tidEncargado2, nidEncargado2);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20071, 'No se pudo agregar la calificación');
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
                RAISE_APPLICATION_ERROR(-20072, 'No se pudo consultar la calificación');
    END co_calificacion;

END PA_Usuario;
/

-- Roles

CREATE ROLE Administrador_SportMatch;
CREATE ROLE EncargadoZonaDeportiva_SportMatch;
CREATE ROLE Usuario_SportMatch;

-- Permisos

GRANT EXECUTE ON PA_Administrador TO Administrador_SportMatch;
GRANT EXECUTE ON PA_EncargadoZonaDeportiva TO EncargadoZonaDeportiva_SportMatch;
GRANT EXECUTE ON PA_Usuario TO Usuario_SportMatch;

-- Asignación de roles

GRANT Administrador_SportMatch TO BD1000092352;
GRANT EncargadoZonaDeportiva_SportMatch TO BD1000093654;
GRANT Usuario_SportMatch TO BD1000096920;

-- Xseguridad

DROP PACKAGE PA_Administrador;
DROP PACKAGE PA_EncargadoZonaDeportiva;
DROP PACKAGE PA_Usuario;

DROP ROLE Administrador_SportMatch;
DROP ROLE EncargadoZonaDeportiva_SportMatch;
DROP ROLE Usuario_SportMatch;

-- SeguridadOK

// Casos de prueba para Administrador_SportMatch

-- Actualizar el estado de un jugador en un equipo
EXECUTE DBMS_SESSION.SET_ROLE('Administrador_SportMatch');
EXECUTE PA_Administrador.up_jugador('TI', '1001234567', 'No.0000001');

-- Insertar una nueva cancha
EXECUTE PA_Administrador.ad_cancha('No.0000009', 10, 'Activa', '20m x 40m', 'Futbol', 'Cancha de fútbol', 'No.0000003');

-- Eliminar un equipo
EXECUTE PA_Administrador.de_equipo('No.0000003');

-- Consultar un adicional
VARIABLE consultarAdicional REFCURSOR;
EXECUTE :consultarAdicional := PA_Administrador.co_adicional('AD0000002');
PRINT :consultarAdicional;

// Casos de prueba para EncargadoZonaDeportiva_SportMatch

-- Actualizar una zona deportiva
EXECUTE DBMS_SESSION.SET_ROLE('EncargadoZonaDeportiva_SportMatch');
EXECUTE PA_EncargadoZonaDeportiva.up_zona('Zona#0001', 'SportMatch House', 5, 'Calle 1 # 1-1', 'Zona deportiva con canchas de fútbol y baloncesto', '50m x 20m');

-- Insertar una nueva tarifa
EXECUTE PA_EncargadoZonaDeportiva.ad_tarifa('No.0000004', 'Lunes', '6:00', '10:00', 50000);

-- Eliminar Zona Deportiva
EXECUTE PA_EncargadoZonaDeportiva.de_zona('Zona#0003');

-- Consultar una cancha
VARIABLE consultarCancha REFCURSOR;
EXECUTE :consultarCancha := PA_EncargadoZonaDeportiva.co_cancha('No.0000002', 'Zona#0002');
PRINT :consultarCancha;

// Casos de prueba para Usuario_SportMatch

-- Insertar una nueva reservación
EXECUTE DBMS_SESSION.SET_ROLE('Usuario_SportMatch');
EXECUTE PA_Usuario.ad_reservacion('No.0000015', 'Procesando', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-05-10','YYYY-MM-DD'), '2:00 h', 'CC', '1000987654', NULL, NULL, 'Fact_No.1');

-- Insertar un nuevo pago
EXECUTE PA_Usuario.ad_pago('Fact_No.4', 'Aprobado', 'Efectivo');

-- Insertar una nueva calificación
EXECUTE PA_Usuario.ad_calificacion('CC', '1000987654', 5, 'Excelente servicio', 'CC', '1000012345');

-- SeguridadNoOK

// Caso de prueba para Administrador_SportMatch

-- Eliminar una tarifa
EXECUTE DBMS_SESSION.SET_ROLE('Administrador_SportMatch');
EXECUTE PA_EncargadoZonaDeportiva.de_tarifa('No.0000002');

// Caso de prueba para EncargadoZonaDeportiva_SportMatch

-- Actualizar el nombre de un equipo
EXECUTE DBMS_SESSION.SET_ROLE('EncargadoZonaDeportiva_SportMatch');
EXECUTE PA_Administrador.up_equipo('No.0000002', 'Los Campeones');

// Caso de prueba para Usuario_SportMatch

-- Eliminar un equipo
EXECUTE DBMS_SESSION.SET_ROLE('Usuario_SportMatch');
EXECUTE PA_Administrador.de_equipo('No.0000001');