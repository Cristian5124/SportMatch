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