-- SeguridadOK

// Casos de prueba para Administrador_SportMatch

-- Actualizar el estado de un jugador en un equipo
EXECUTE DBMS_SESSION.SET_ROLE('Administrador_SportMatch');
EXECUTE PA_Administrador.up_jugador('TI', '1001234567', 'No.0000001');

-- Insertar una nueva cancha
EXECUTE PA_Administrador.ad_cancha('No.0000009', 10, 'Activa', '20m x 40m', 'Futbol', 'Cancha de fútbol', 'No.0000003');

-- Eliminar un equipo
EXECUTE PA_Administrador.de_equipo('No.0000003');

-- Consultar un adicional
VARIABLE consultarAdicional REFCURSOR;
EXECUTE :consultarAdicional := PA_Administrador.co_adicional('AD0000002');
PRINT :consultarAdicional;

// Casos de prueba para EncargadoZonaDeportiva_SportMatch

-- Actualizar una zona deportiva
EXECUTE DBMS_SESSION.SET_ROLE('EncargadoZonaDeportiva_SportMatch');
EXECUTE PA_EncargadoZonaDeportiva.up_zona('Zona#0001', 'SportMatch House', 5, 'Calle 1 # 1-1', 'Zona deportiva con canchas de fútbol y baloncesto', '50m x 20m');

-- Insertar una nueva tarifa
EXECUTE PA_EncargadoZonaDeportiva.ad_tarifa('No.0000004', 'Lunes', '6:00', '10:00', 50000);

-- Eliminar Zona Deportiva
EXECUTE PA_EncargadoZonaDeportiva.de_zona('Zona#0003');

-- Consultar una cancha
VARIABLE consultarCancha REFCURSOR;
EXECUTE :consultarCancha := PA_EncargadoZonaDeportiva.co_cancha('No.0000002', 'Zona#0002');
PRINT :consultarCancha;

// Casos de prueba para Usuario_SportMatch

-- Insertar una nueva reservación
EXECUTE DBMS_SESSION.SET_ROLE('Usuario_SportMatch');
EXECUTE PA_Usuario.ad_reservacion('No.0000015', 'Procesando', TO_DATE('2024-04-10','YYYY-MM-DD'), TO_DATE('2024-05-10','YYYY-MM-DD'), '2:00 h', 'CC', '1000987654', NULL, NULL, 'Fact_No.1');

-- Insertar un nuevo pago
EXECUTE PA_Usuario.ad_pago('Fact_No.4', 'Aprobado', 'Efectivo');

-- Insertar una nueva calificación
EXECUTE PA_Usuario.ad_calificacion('CC', '1000987654', 5, 'Excelente servicio', 'CC', '1000012345');