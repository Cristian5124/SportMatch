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