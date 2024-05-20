--Llaves Primarias (PK)

ALTER TABLE Tarifas ADD CONSTRAINT PK_Tarifas PRIMARY KEY(IDTarifa);
ALTER TABLE Canchas ADD CONSTRAINT PK_Canchas PRIMARY KEY(IDCancha, IDZona);
ALTER TABLE TarifasPorCancha ADD CONSTRAINT PK_TarifasPorCancha PRIMARY KEY(IDCancha, IDZona, IDTarifa); --AGREGADO
ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT PK_AdicionalesPorReservaciones PRIMARY KEY(IDAdicional, IDReserva);
ALTER TABLE Adicionales ADD CONSTRAINT PK_Adicionales PRIMARY KEY(IDAdicional);
ALTER TABLE Partidos ADD CONSTRAINT PK_Partidos PRIMARY KEY(IDPartido);
ALTER TABLE Reservaciones ADD CONSTRAINT PK_Reservaciones PRIMARY KEY(IDReserva);
ALTER TABLE Pagos ADD CONSTRAINT PK_pagos PRIMARY KEY(IDPago);
ALTER TABLE ZonasDeportivas ADD CONSTRAINT PK_ZonasDeportivas PRIMARY KEY(IDZona);
ALTER TABLE Encargados ADD CONSTRAINT PK_Encargados PRIMARY KEY(tidJugador, nidJugador);
ALTER TABLE Calificaciones ADD CONSTRAINT PK_Calificaciones PRIMARY KEY(tidJugador, nidJugador, tidEncargado, nidEncargado);
ALTER TABLE Jugadores ADD CONSTRAINT PK_Jugadores PRIMARY KEY(tid, nid);
ALTER TABLE TelefonosPorJugador ADD CONSTRAINT PK_TelefonosPorJugador PRIMARY KEY(tidJugador, nidJugador, telefono);
ALTER TABLE Equipos ADD CONSTRAINT PK_Equipos PRIMARY KEY(IDEquipo);
ALTER TABLE EquiposJueganPartidos ADD CONSTRAINT PK_EquiposJueganPartidos PRIMARY KEY(IDEquipo, IDPartido);