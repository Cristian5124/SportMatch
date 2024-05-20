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