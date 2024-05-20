--Atributos

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_dia CHECK (dia IN ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo', 'Festivo'));

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_horaInicio CHECK (REGEXP_LIKE(horaInicio,'^([0-1]{1}[0-9]{1}|2[0-3]{1})(:)([0-5]{1})([0-9]{1})'));

ALTER TABLE Tarifas ADD CONSTRAINT CK_Tarifas_horaFin CHECK (REGEXP_LIKE(horaFin,'^([0-1]{1}[0-9]{1}|2[0-3]{1})(:)([0-5]{1})([0-9]{1})'));

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_capacidadJugadores CHECK (capacidadJugadores > 0);

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_estado CHECK (estado in ('Activa', 'Mantenimiento', 'Inactiva'));

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_dimensiones CHECK (REGEXP_LIKE(dimensiones,'^([0-9]{1,4})(m)(\s)(\x)(\s)([0-9]{1,4})(m)'));

ALTER TABLE Canchas ADD CONSTRAINT CK_Canchas_deporte CHECK (deporte in ('Futbol', 'Microfutbol', 'Baloncesto', 'Tenis', 'Volleyball', 'Padel'));

ALTER TABLE Adicionales ADD CONSTRAINT CK_Adicionales_cantidad CHECK (cantidad > 0);

ALTER TABLE Adicionales ADD CONSTRAINT CK_Adicionales_disponibilidad CHECK (disponibilidad in (0, 1));

ALTER TABLE Partidos ADD CONSTRAINT CK_Partidos_resultado CHECK (REGEXP_LIKE(resultado,'^([0-9]{1,3})(-)([0-9]{1,3})'));

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_estado CHECK (estado in ('Completada', 'Cancelada', 'Procesando'));

ALTER TABLE Reservaciones ADD CONSTRAINT CK_Reservaciones_tiempoTotal CHECK (REGEXP_LIKE(tiempoTotal,'^(([1-9]{1}):(00|30)) h$')); --REVISAR

ALTER TABLE Pagos ADD CONSTRAINT CK_Pagos_estado CHECK (estado in ('Aprobado', 'Rechazado', 'Procesando'));

ALTER TABLE Pagos ADD CONSTRAINT CK_Pagos_metodo CHECK (metodo in ('Efectivo', 'Tarjeta de Credito', 'Tarjeta de Debito', 'Transferencia', 'PSE'));

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_cantidadCanchas CHECK (cantidadCanchas > 0);

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_direccion CHECK (direccion like ('%#%-%'));

ALTER TABLE ZonasDeportivas ADD CONSTRAINT CK_ZonasDeportivas_area CHECK (REGEXP_LIKE(area,'^([0-9]{1,4})(m)(\s)(\x)(\s)([0-9]{1,4})(m)'));

ALTER TABLE Encargados ADD CONSTRAINT CK_Encargados_fechaContratacion CHECK (TRUNC(fechaContratacion) <= TRUNC(SYSDATE));

ALTER TABLE Encargados ADD CONSTRAINT CK_Encargados_foto CHECK (foto like ('https://%.%'));

ALTER TABLE Encargados ADD CONSTRAINT CK_Encargados_estudios CHECK (estudios in ('Sin Estudios', 'Primaria', 'Secundaria', 'Pregrado', 'Tecnico', 'Maestria', 'Doctorado'));

ALTER TABLE Encargados ADD CONSTRAINT CK_Encargados_experiencia CHECK (experiencia >= 0);

ALTER TABLE Calificaciones ADD CONSTRAINT CK_Calificaciones_calificacion CHECK (calificacion in (0, 1, 2, 3, 4, 5));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_tid CHECK (tid in ('CC', 'TI', 'CE', 'PA'));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_nid CHECK (REGEXP_LIKE(nid,'^([1-9]{1})([0-9]{9})'));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_correo CHECK (correo like ('%@%.%'));

ALTER TABLE Jugadores ADD CONSTRAINT CK_Jugadores_sexo CHECK (sexo in ('Masculino', 'Femenino'));

ALTER TABLE TelefonosPorJugador ADD CONSTRAINT CK_TelefonosPorJugador_telefono CHECK (telefono >= 1000000000);

ALTER TABLE Equipos ADD CONSTRAINT CK_Equipos_numeroIntegrantes CHECK (numeroIntegrantes >= 0);