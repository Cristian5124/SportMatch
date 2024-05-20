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