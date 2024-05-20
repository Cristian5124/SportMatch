-- SeguridadNoOK

// Caso de prueba para Administrador_SportMatch

-- Eliminar una tarifa
EXECUTE DBMS_SESSION.SET_ROLE('Administrador_SportMatch');
EXECUTE PA_EncargadoZonaDeportiva.de_tarifa('No.0000002');

// Caso de prueba para EncargadoZonaDeportiva_SportMatch

-- Actualizar el nombre de un equipo
EXECUTE DBMS_SESSION.SET_ROLE('EncargadoZonaDeportiva_SportMatch');
EXECUTE PA_Administrador.up_equipo('No.0000002', 'Los Campeones');

// Caso de prueba para Usuario_SportMatch

-- Eliminar un equipo
EXECUTE DBMS_SESSION.SET_ROLE('Usuario_SportMatch');
EXECUTE PA_Administrador.de_equipo('No.0000001');