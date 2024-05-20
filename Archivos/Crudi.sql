--Componentes

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