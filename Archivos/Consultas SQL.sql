--Consultas SQL

//1. Consulta para obtener todos los jugadores de un equipo específico:

SELECT Jugadores.nombre, Jugadores.apellido, Equipos.nombre AS equipo
FROM Jugadores
JOIN Equipos ON Jugadores.IDEquipo = Equipos.IDEquipo
WHERE Equipos.nombre = 'Real Madrid';

//2. Consulta para obtener todas las jugadoras que sean de género femenino:

SELECT nombre, apellido, correo, sexo
FROM Jugadores
WHERE sexo = 'Femenino';