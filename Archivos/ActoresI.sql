--Seguridad

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