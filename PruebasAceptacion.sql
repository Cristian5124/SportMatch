----------------------------------------------------------------------PRUEBAS DE ACEPTACION----------------------------------------------------------------------

--------- SAMUEL FELIPE DIAZ
--------- 1) Proceso de Reservación y pago de una cancha
/*
Llega un usuario nuevo a la plataforma y desea reservar una cancha de futbol 5 en la zona deportiva que queda cerca a su casa.
*/

--El administrador inicia sesion y procede a agregar al usuario nuevo en la base de datos

--EXECUTE DBMS_SESSION.SET_ROLE('Administrador_SportMatchV4');
EXECUTE PC_Jugadores.ad_jugador('CC', '1000092352', 'Felipe', 'Rodriguez', 'felipe1403@gmail.com', 'Masculino', 'No.0000050');

-- Revisa el resultado de la insercion

VARIABLE consultarJugador REFCURSOR;
EXECUTE :consultarJugador := PA_Administrador.co_jugador('CC', '1000092352');
PRINT :consultarJugador;

-- El usuario escoge la cancha y zona especifica en donde desea reservar, la fecha de reservacion y la cantidad de horas que va a jugar

-- VISTA DE DISPONIBILIDAD DE CANCHAS

SELECT * FROM VISTA_DISPONIBILIDAD_CANCHAS;

-- El usuario procede a colocar sus datos de reservacion:

EXECUTE PC_Reservaciones.ad_reservacionCancha(TO_DATE('14/08/2024 10:00','DD/MM/YYYY HH24:MI'), 2, 'CC', '1000092352', 'No.0000001', 'Zona#0001')

--Sus datos se almacenan en la base de datos y automaticamente se crea un registro pendiente de pago con los datos:
    -- Su identificador de pago es generado concatenando el identificador de la reserva (Fact_No.IDReserva)
    -- Su estado de pago va a estar "Procesando"
    -- El metodo de pago por defecto es efectivo, pero puede ser modificado
    -- Puesto que la reserva aun no se ha pagado, no hay una fecha de pago

-- El administrador desea consultar como esta la reservacion

DECLARE
    CO_Cursor SYS_REFCURSOR;
BEGIN
    CO_Cursor := PC_Reservaciones.co_reservacion('No.0000054');
    DBMS_SQL.RETURN_RESULT(CO_Cursor);
END;
/

-- VISTA DEL ESTADO DEL PAGO para verificar los cambios

SELECT * FROM VISTA_ESTADO_PAGO WHERE IDPago = 'Fact_No.0000054';

DECLARE
    CO_Cursor SYS_REFCURSOR;
BEGIN
    CO_Cursor := PC_Reservaciones.co_pago('Fact_No.0000054');
    DBMS_SQL.RETURN_RESULT(CO_Cursor);
END;
/

--Una vez hecho esto se desea mostrar el total que se debe pagar y el administrador muestra un resumen de la factura

-- VISTA DEL TOTAL PARA LA RESERVA ESPECIFICA

SELECT * FROM VISTA_TOTAL_RESERVA_ESPECIFICA WHERE IDReserva = 'No.0000054';

-- Han pasado algunos dias y el usuario he efectuado el pago de la reservacion pero con un metodo de pago diferente, en este caso con PSE
-- Su pago fue Aprobado, por lo cual el administrador procede a modificar la informacion:

EXECUTE PA_ADMINISTRADOR.up_pago('Fact_No.0000054', 'Aprobado', 'PSE');

--Automaticamente se va a actualizar la fecha de pago a la fecha actual en la que se origino el pago

-- VISTA DEL ESTADO DEL PAGO

SELECT * FROM VISTA_ESTADO_PAGO WHERE IDPago = 'Fact_No.0000054';

-- Al modificar la información del pago, automaticamente se actualiza el estado de la reservación a 'Completada' indicando que todo ha salido bien

-- VISTA DEL ESTADO DE LA RESERVACION

DECLARE
    CO_Cursor SYS_REFCURSOR;
BEGIN
    CO_Cursor := PC_Reservaciones.co_reservacion('No.0000054');
    DBMS_SQL.RETURN_RESULT(CO_Cursor);
END;
/