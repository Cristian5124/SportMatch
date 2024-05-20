--CRUDNoOK

// PC_Reservaciones : Insertar una reservación con un IDReserva que ya existe

EXECUTE PC_Reservaciones.ad_reservacion('No.0000007', 'Procesando', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-05-10','YYYY-MM-DD'), '2:00 h', 'CC', '1000987654', 'No.0000001', 'No.0000001', 'Fact_No.1');

SELECT * FROM Reservaciones;

// PC_Jugadores : Actualizar el estado de un jugador en un equipo que no existe

EXECUTE PC_Jugadores.up_jugador('TI', '1001234567', 'No.0000006');

SELECT * FROM Jugadores;

// PC_Canchas : Eliminar una cancha que no existe

EXECUTE PC_Canchas.de_cancha('No.0000008', 'Zona#0001');

SELECT * FROM Canchas;

// PC_ZonasDeportivas : Consultar una zona deportiva que no existe

VARIABLE consultarZona REFCURSOR;
EXECUTE :consultarZona := PC_ZonasDeportivas.co_zona('Zona#0010');
PRINT :consultarZona;

SELECT * FROM ZonasDeportivas;

// PC_Adicionales : Actualizar el precio de un adicional que no existe

EXECUTE PC_Adicionales.up_precioAdicional('AD7777777', 30000);

SELECT * FROM Adicionales;