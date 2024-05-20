-- Roles

CREATE ROLE Administrador_SportMatch;
CREATE ROLE EncargadoZonaDeportiva_SportMatch;
CREATE ROLE Usuario_SportMatch;

-- Permisos

GRANT EXECUTE ON PA_Administrador TO Administrador_SportMatch;
GRANT EXECUTE ON PA_EncargadoZonaDeportiva TO EncargadoZonaDeportiva_SportMatch;
GRANT EXECUTE ON PA_Usuario TO Usuario_SportMatch;

-- Asignación de roles

GRANT Administrador_SportMatch TO BD1000092352;
GRANT EncargadoZonaDeportiva_SportMatch TO BD1000093654;
GRANT Usuario_SportMatch TO BD1000096920;