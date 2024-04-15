--xTablas

DROP TABLE Tarifas CASCADE CONSTRAINTS;
DROP TABLE Canchas CASCADE CONSTRAINTS;
DROP TABLE AdicionalesPorReservaciones CASCADE CONSTRAINTS;
DROP TABLE Adicionales CASCADE CONSTRAINTS;
DROP TABLE Partidos CASCADE CONSTRAINTS;
DROP TABLE Reservaciones CASCADE CONSTRAINTS;
DROP TABLE Pagos CASCADE CONSTRAINTS;
DROP TABLE ZonasDeportivas CASCADE CONSTRAINTS;
DROP TABLE Encargados CASCADE CONSTRAINTS;
DROP TABLE Calificaciones CASCADE CONSTRAINTS;
DROP TABLE Jugadores CASCADE CONSTRAINTS;
DROP TABLE TelefonosPorJugador CASCADE CONSTRAINTS;
DROP TABLE Equipos CASCADE CONSTRAINTS;
DROP TABLE EquiposJueganPartidos CASCADE CONSTRAINTS;

--Tablas

CREATE TABLE Tarifas (
    IDTarifa CHAR(6) NOT NULL,
    dia VARCHAR(10) NOT NULL,
    horaInicio VARCHAR(15) NOT NULL,
    horaFin VARCHAR(15) NOT NULL,
    precio NUMBER(9) NOT NULL
);

CREATE TABLE Canchas (
    IDCancha CHAR(6) NOT NULL,
    IDZona CHAR(6) NOT NULL,
    capacidadJugadores NUMBER(2) NOT NULL,
    estado VARCHAR(15) NOT NULL,
    dimensiones VARCHAR(40) NOT NULL,
    descripcion	VARCHAR(80) NOT NULL,
    deporte	VARCHAR(15) NOT NULL,
    idTarifa CHAR(6) NOT NULL
);

CREATE TABLE AdicionalesPorReservaciones (
    IDAdicional CHAR(6) NOT NULL,
    IDReserva CHAR(6)
);

CREATE TABLE Adicionales (
    IDAdicional CHAR(6) NOT NULL,
    cantidad NUMBER(2) NOT NULL,
    precio NUMBER(9) NOT NULL,
    disponibilidad NUMBER(1) NOT NULL
);

CREATE TABLE Partidos (
    IDPartido CHAR(6) NOT NULL,
    resultado VARCHAR(15) NOT NULL
);

CREATE TABLE Reservaciones (
    IDReserva CHAR(6) NOT NULL,
    estado VARCHAR(15) NOT NULL,
    fechaSolicitud DATE NOT NULL,
    fechaReservacion DATE NOT NULL,
    tiempoTotal VARCHAR(15) NOT NULL,
    tidJugador CHAR(2) NOT NULL,
    nidJugador VARCHAR(10) NOT NULL,
    IDCancha CHAR(6),
    IDZona CHAR(6),
    IDPartido CHAR(6),
    IDPago CHAR(12) NOT NULL
);

CREATE TABLE Pagos (
    IDPago CHAR(12) NOT NULL,
    estado VARCHAR(15) NOT NULL,
    metodo VARCHAR(25) NOT NULL
);

CREATE TABLE ZonasDeportivas (
    IDZona CHAR(6) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    cantidadCanchas NUMBER(2) NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    descripcion VARCHAR(80),
    area VARCHAR(15) NOT NULL
);

CREATE TABLE Encargados (
    tidJugador CHAR(2) NOT NULL,
    nidJugador VARCHAR(10) NOT NULL,
    fechaContratacion DATE NOT NULL, 
    foto VARCHAR(80) NOT NULL,
    estudios VARCHAR(30) NOT NULL,
    aniosExperiencia NUMBER(2) NOT NULL,
    IDZona CHAR(6) NOT NULL
);

CREATE TABLE Calificaciones (
    tidJugador CHAR(2) NOT NULL,
    nidJugador VARCHAR(10) NOT NULL,
    calificacion NUMBER(1) NOT NULL,
    feedback VARCHAR(80) NOT NULL,
    tidEncargado CHAR(2) NOT NULL,
    nidEncargado VARCHAR(10) NOT NULL
);

CREATE TABLE Jugadores (
    tid CHAR(2) NOT NULL,
    nid VARCHAR(10) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    correo VARCHAR(30),
    sexo VARCHAR(15) NOT NULL,
    IDEquipo CHAR(6)
);

CREATE TABLE TelefonosPorJugador (
    tidJugador CHAR(2) NOT NULL,
    nidJugador VARCHAR(10) NOT NULL,
    telefono NUMBER(10) NOT NULL
);

CREATE TABLE Equipos (
    IDEquipo CHAR(6) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    numeroIntegrantes NUMBER(2) NOT NULL
);

CREATE TABLE EquiposJueganPartidos (
    IDEquipo CHAR(6) NOT NULL,
    IDPartido CHAR(6) NOT NULL
);

--Llaves Primarias (PK)

ALTER TABLE Tarifas ADD CONSTRAINT PK_Tarifas PRIMARY KEY(IDTarifa);
ALTER TABLE Canchas ADD CONSTRAINT PK_Canchas PRIMARY KEY(IDCancha, IDZona);
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

--Llaves Foraneas (FK)

ALTER TABLE Canchas ADD CONSTRAINT FK_Canchas_Tarifas FOREIGN KEY(idTarifa) REFERENCES Tarifas(IDTarifa);
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

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_IDTarifa CHECK (REGEXP_LIKE(IDTarifa,'^([A-Z]{3})([0-9]{3})'));

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_dia CHECK (dia IN ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo', 'Festivo'));

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_horaInicio CHECK (REGEXP_LIKE(horaInicio,'^([0-9]{1,2})(:)([0-5]{1})([0-9]{1})'));

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_HoraFin CHECK (REGEXP_LIKE(horaFin,'^([0-9]{1,2})(:)([0-5]{1})([0-9]{1})'));

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_precio CHECK (precio > 0);

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_IDCancha CHECK (REGEXP_LIKE(IDCancha,'^([A-Z]{3})([0-9]{3})'));

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_capacidadJugadores CHECK (capacidadJugadores > 0);

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_estado CHECK (estado in ('Activa', 'Mantenimiento', 'Inactiva'));

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_dimensiones CHECK (REGEXP_LIKE(dimensiones,'^([0-9]{1,4})(m)(\s)(\*)(\s)([0-9]{1,4})(m)'));

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_deporte CHECK (deporte in ('Futbol', 'Microfutbol', 'Baloncesto', 'Tennis', 'Volleyball', 'Baseball', 'Softball', 'Padel', 'Badminton', 'Atletismo'));

ALTER TABLE Adicionales ADD CONSTRAINT CK_Adicionales_IDAdicional CHECK (REGEXP_LIKE(IDAdicional,'^(AD)([0-9]{4})'));

ALTER TABLE Adicionales ADD CONSTRAINT CK_Adicionales_cantidad CHECK (cantidad > 0);

ALTER TABLE Adicionales ADD CONSTRAINT CK_Adicionales_precio CHECK (precio > 0);

ALTER TABLE Adicionales ADD CONSTRAINT CK_Adicionales_disponibilidad CHECK (disponibilidad in (0, 1));

ALTER TABLE Partidos ADD CONSTRAINT CK_Partidos_IDPartido CHECK (REGEXP_LIKE(IDPartido,'^([A-Z]{3})([0-9]{3})'));

ALTER TABLE Partidos ADD CONSTRAINT CK_Partidos_resultado CHECK (REGEXP_LIKE(resultado,'^([0-9]{1,3})(-)([0-9]{1,3})'));

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_IDReserva CHECK (REGEXP_LIKE(IDReserva,'^([A-Z]{3})([0-9]{3})'));

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_estado CHECK (estado in ('Hecha', 'Cumplida', 'Cancelada', 'Procesando'));

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_tiempoTotal CHECK (REGEXP_LIKE(tiempoTotal,'^([0-9]{1,2})(:)([0-5]{1})([0-9]{1})(\s)(h)'));

ALTER TABLE Pagos ADD CONSTRAINT CK_Pagos_IDPago CHECK (REGEXP_LIKE(IDPago,'^([0-9]{12})'));

ALTER TABLE Pagos ADD CONSTRAINT CK_Pagos_estado CHECK (estado in ('Aprobado', 'Rechazado', 'Procesando'));

ALTER TABLE Pagos ADD CONSTRAINT CK_Pagos_metodo CHECK (metodo in ('Efectivo', 'Tarjeta de Credito', 'Tarjeta de Debito', 'Transferencia', 'PSE'));

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_IDZona CHECK (REGEXP_LIKE(IDZona,'^([A-Z]{3})([0-9]{3})'));

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_cantidadCanchas CHECK (cantidadCanchas >= 0);

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_direccion CHECK (direccion like ('%#%-%'));

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_area CHECK (REGEXP_LIKE(area,'^([0-9]{1,4})(m)(\s)(\*)(\s)([0-9]{1,4})(m)'));

--ALTER TABLE Encargados ADD CONSTRAINT CK_Encargados_fechaContratacion CHECK (fechaContratacion <= SYSDATE);

ALTER TABLE Encargados ADD CONSTRAINT CK_Encargados_foto CHECK (foto like ('https://%.%'));

ALTER TABLE Encargados ADD CONSTRAINT CK_Encargados_aniosExperiencia CHECK (aniosExperiencia >= 0);

ALTER TABLE Calificaciones ADD CONSTRAINT CK_Calificaciones_calificacion CHECK (calificacion in (0, 1, 2, 3, 4, 5));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_tid CHECK (tid in ('CC', 'TI', 'CE', 'PA'));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_nid CHECK (REGEXP_LIKE(nid,'^([1-9]{1})([0-9]{9})'));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_correo CHECK (correo like ('%@%.%'));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_sexo CHECK (sexo in ('Masculino', 'Femenino'));

ALTER TABLE TelefonosPorJugador ADD CONSTRAINT CK_TelefonosPorJugador_telefono CHECK (telefono >= 1000000000);

ALTER TABLE Equipos ADD CONSTRAINT CK_Equipos_IDEquipo CHECK (REGEXP_LIKE(IDEquipo,'^([A-Z]{3})([0-9]{3})'));

ALTER TABLE Equipos ADD CONSTRAINT CK_Equipos_numeroIntegrantes CHECK (numeroIntegrantes >= 0);

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

--Xpoblar

DELETE FROM EquiposJueganPartidos
DELETE FROM AdicionalesPorReservaciones
DELETE FROM Adicionales
DELETE FROM Calificaciones
DELETE FROM Encargados
DELETE FROM Reservaciones
DELETE FROM Canchas
DELETE FROM Tarifas
DELETE FROM ZonasDeportivas
DELETE FROM TelefonosPorJugador
DELETE FROM Jugadores
DELETE FROM Equipos
DELETE FROM Pagos
DELETE FROM Partidos

--Consultas SQL

//1. Consulta para obtener todos los jugadores de un equipo específico:

SELECT Jugadores.nombre, Jugadores.apellido, Equipos.nombre AS equipo
FROM Jugadores
JOIN Equipos ON Jugadores.IDEquipo = Equipos.IDEquipo
WHERE Equipos.nombre = 'Real Madrid';

//2. Consulta para obtener todas las jugadoras que sean de género femenino:

SELECT nombre, apellido, correo, sexo
FROM Jugadores
WHERE sexo = 'Femenino';

--Tuplas

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_fechaSolicitud_fechaReservacion CHECK (fechaSolicitud <= fechaReservacion);

--TuplasOK

INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) VALUES ('FUT090', 'Procesando', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-04-11','YYYY-MM-DD'), '2:00 h', 'CC', '1010123456', 'FUT001', 'FUT534', '123456789101');

--TuplasNoOK

INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) VALUES ('FUT091', 'Cancelada', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-04-09','YYYY-MM-DD'), '2:00 h', 'CC', '1010123456', 'FUT001', 'FUT534', '123456789101');

--Acciones

/*

ALTER TABLE Canchas ADD CONSTRAINT FK_Canchas_Tarifas FOREIGN KEY(idTarifa) REFERENCES Tarifas(IDTarifa);
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

*/

--Disparadores

--Disparador para actualizar la cantidad de jugadores de un equipo cuando se inserta un nuevo jugador
CREATE OR REPLACE TRIGGER trg_actualizar_cantidad_jugadores
AFTER INSERT ON Jugadores
FOR EACH ROW
BEGIN
    UPDATE Equipos
    SET numeroIntegrantes = numeroIntegrantes + 1
    WHERE IDEquipo = :NEW.IDEquipo;
END;

--DisparadorOK

INSERT INTO Jugadores (tid, nid, nombre, apellido, correo, sexo, IDEquipo) VALUES ('CC', '1987654320', 'Melissa', 'Rios Carvajal', 'melissa.rios@gmail.com', 'Femenino', 'FUT501');

SELECT * FROM Equipos

--Disparador para actualizar la cantidad de jugadores de un equipo cuando se elimina un jugador
CREATE OR REPLACE TRIGGER trg_actualizar_cantidad_jugadores
AFTER DELETE ON Jugadores
FOR EACH ROW
BEGIN
    UPDATE Equipos
    SET numeroIntegrantes = numeroIntegrantes - 1
    WHERE IDEquipo = :OLD.IDEquipo;
END;

--DisparadorOK

DELETE FROM Jugadores
WHERE tid = 'CC' AND nid = '1987654320';

SELECT * FROM Equipos

--Disparador para validar que la fecha de solicitud sea menor o igual a la fecha de reservación
CREATE OR REPLACE TRIGGER trg_validar_fechas_reservacion
BEFORE INSERT ON Reservaciones
FOR EACH ROW
BEGIN
    IF :NEW.fechaSolicitud > :NEW.fechaReservacion THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de solicitud debe ser menor o igual a la fecha de reservación.');
    END IF;
END;

--DisparadorOK

INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) VALUES ('FUT999', 'Cumplida', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-04-09','YYYY-MM-DD'), '2:00 h', 'CC', '1010123456', 'FUT001', 'FUT534', '123456789101');

--Disparador para aumentar la cantidad de canchas en ZonasDeportivas cuando se crea una nueva Cancha
CREATE OR REPLACE TRIGGER trg_aumentar_cantidad_canchas
AFTER INSERT ON Canchas
FOR EACH ROW
BEGIN
    UPDATE ZonasDeportivas
    SET cantidadCanchas = cantidadCanchas + 1
    WHERE IDZona = :NEW.IDZona;
END;

--DisparadorOK

INSERT INTO Canchas (IDCancha, capacidadJugadores, estado, dimensiones, IDZona, descripcion, deporte, idTarifa) VALUES ('FUT133', 10, 'Activa', '25m * 7m', 'BOG001', 'Cancha sintetica de futbol 5 al aire libre', 'Futbol', 'FUT001');

SELECT * FROM ZonasDeportivas

--Disparador para disminuir la cantidad de canchas en ZonasDeportivas cuando se elimina una Cancha
CREATE OR REPLACE TRIGGER trg_disminuir_cantidad_canchas
AFTER DELETE ON Canchas
FOR EACH ROW
BEGIN
    UPDATE ZonasDeportivas
    SET cantidadCanchas = cantidadCanchas - 1
    WHERE IDZona = :OLD.IDZona;
END;

--DisparadorOK

DELETE FROM Canchas
WHERE IDCancha = 'FUT133';

SELECT * FROM ZonasDeportivas

--Disparador para autoincrementar el valor de IDReserva
CREATE OR REPLACE TRIGGER trg_autoincrementar_idreserva
BEFORE INSERT ON Reservaciones
FOR EACH ROW
DECLARE
    nuevoID Reservaciones.IDReserva%TYPE;
BEGIN
    --Generar el nuevo IDReserva
    nuevoID := :NEW.IDReserva;
    LOOP
        --Verificar si el nuevo IDReserva ya existe en la tabla
        SELECT COUNT(*)
        INTO nuevoID
        FROM Reservaciones
        WHERE IDReserva = nuevoID;
        
        --Si el nuevo IDReserva no existe, salir del bucle
        EXIT WHEN nuevoID = 0;
        
        --Obtener las primeras 3 letras del IDReserva actual
        nuevoID := SUBSTR(nuevoID, 1, 3);
        
        --Obtener el número de 3 cifras del IDReserva actual
        nuevoID := CONCAT(nuevoID, ((TO_NUMBER(SUBSTR(nuevoID, 4, 6)) + 1)));
    END LOOP;
    
    --Asignar el nuevo IDReserva al registro a insertar
    :NEW.IDReserva := nuevoID;
END;

--DisparadorOK

// INSERT INTO Reservaciones (IDReserva, estado, fechaSolicitud, fechaReservacion, tiempoTotal, tidJugador, nidJugador, IDCancha, IDPartido, IDPago) VALUES ('FUT001', 'Procesando', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-04-11','YYYY-MM-DD'), '5:00 h', 'CC', '1010123456', 'FUT001', 'FUT534', '123456789101');