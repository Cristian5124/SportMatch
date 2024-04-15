--Llaves Foraneas (FK)

ALTER TABLE Canchas ADD CONSTRAINT FK_Canchas_Tarifas FOREIGN KEY(idTarifa) REFERENCES Tarifas(IDTarifa);
ALTER TABLE Canchas ADD CONSTRAINT FK_Canchas_ZonasDeportivas FOREIGN KEY(IDZona) REFERENCES ZonasDeportivas(IDZona);
ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT FK_AdicionalesPorReservaciones_Adicionales FOREIGN KEY(IDAdicional) REFERENCES Adicionales(IDAdicional);
ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT FK_AdicionalesPorReservaciones_Reservaciones FOREIGN KEY(IDReserva) REFERENCES Reservaciones(IDReserva);
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid);
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Canchas FOREIGN KEY(IDCancha, IDZona) REFERENCES Canchas(IDCancha, IDZona);
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Partidos FOREIGN KEY(IDPartido) REFERENCES Partidos(IDPartido);
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Pagos FOREIGN KEY(IDPago) REFERENCES Pagos(IDPago);
ALTER TABLE Encargados ADD CONSTRAINT FK_Encargados_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid);
ALTER TABLE Calificaciones ADD CONSTRAINT FK_Calificaciones_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid);
ALTER TABLE Calificaciones ADD CONSTRAINT FK_Calificaciones_Encargados FOREIGN KEY(tidEncargado, nidEncargado) REFERENCES Encargados(tidJugador, nidJugador);
ALTER TABLE Jugadores ADD CONSTRAINT FK_Jugadores_Equipos FOREIGN KEY(IDEquipo) REFERENCES Equipos(IDEquipo);
ALTER TABLE TelefonosPorJugador ADD CONSTRAINT FK_TelefonosPorJugador_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid);
ALTER TABLE EquiposJueganPartidos ADD CONSTRAINT FK_EquiposJueganPartidos_Equipos FOREIGN KEY(IDEquipo) REFERENCES Equipos(IDEquipo);
ALTER TABLE EquiposJueganPartidos ADD CONSTRAINT FK_EquiposJueganPartidos_Partidos FOREIGN KEY(IDPartido) REFERENCES Partidos(IDPartido);