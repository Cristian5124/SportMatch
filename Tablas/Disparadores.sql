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

--Disparador para actualizar la cantidad de jugadores de un equipo cuando se elimina un jugador
CREATE OR REPLACE TRIGGER trg_actualizar_cantidad_jugadores
AFTER DELETE ON Jugadores
FOR EACH ROW
BEGIN
    UPDATE Equipos
    SET numeroIntegrantes = numeroIntegrantes - 1
    WHERE IDEquipo = :OLD.IDEquipo;
END;

--Disparador para validar que la fecha de solicitud sea menor o igual a la fecha de reservación
CREATE OR REPLACE TRIGGER trg_validar_fechas_reservacion
BEFORE INSERT ON Reservaciones
FOR EACH ROW
BEGIN
    IF :NEW.fechaSolicitud > :NEW.fechaReservacion THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de solicitud debe ser menor o igual a la fecha de reservación.');
    END IF;
END;

--Disparador para aumentar la cantidad de canchas en ZonasDeportivas cuando se crea una nueva Cancha
CREATE OR REPLACE TRIGGER trg_aumentar_cantidad_canchas
AFTER INSERT ON Canchas
FOR EACH ROW
BEGIN
    UPDATE ZonasDeportivas
    SET cantidadCanchas = cantidadCanchas + 1
    WHERE IDZona = :NEW.IDZona;
END;

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