--CRUDOK

// PC_Reservaciones : Insertar una nueva reservación

EXECUTE PC_Reservaciones.ad_reservacion('No.0000007', 'Cancelada', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-05-10','YYYY-MM-DD'), '2:00 h', 'CC', '1000987654', 'No.0000001', 'No.0000001', 'Fact_No.1');

SELECT * FROM Reservaciones;

// PC_Jugadores : Actualizar el estado de un jugador en un equipo

EXECUTE PC_Jugadores.up_jugador('TI', '1001234567', 'No.0000002');

SELECT * FROM Jugadores;
SELECT * FROM Equipos;

// PC_Canchas : Eliminar una cancha de una zona deportiva

EXECUTE PC_Canchas.de_cancha('No.0000001', 'Zona#0001');

SELECT * FROM Canchas;

// PC_ZonasDeportivas : Consultar una zona deportiva

VARIABLE consultarZona REFCURSOR;
EXECUTE :consultarZona := PC_ZonasDeportivas.co_zona('Zona#0001');
PRINT :consultarZona;

SELECT * FROM ZonasDeportivas;

// PC_Adicionales : Actualizar la disponibilidad de un adicional

EXECUTE PC_Adicionales.up_disponibilidadAdicional('AD0000002', 1);

SELECT * FROM Adicionales;