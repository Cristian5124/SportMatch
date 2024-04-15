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