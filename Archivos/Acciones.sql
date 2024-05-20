--Acciones

ALTER TABLE TarifasPorCancha ADD CONSTRAINT FK_TarifasPorCancha_Canchas FOREIGN KEY(IDCancha, IDZona) REFERENCES Canchas(IDCancha, IDZona) ON DELETE CASCADE; --AGREGADO
ALTER TABLE TarifasPorCancha ADD CONSTRAINT FK_TarifasPorCancha_Tarifas FOREIGN KEY(IDTarifa) REFERENCES Tarifas(IDTarifa) ON DELETE CASCADE; --AGREGADO
ALTER TABLE Canchas ADD CONSTRAINT FK_Canchas_ZonasDeportivas FOREIGN KEY(IDZona) REFERENCES ZonasDeportivas(IDZona) ON DELETE CASCADE;
ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT FK_AdicionalesPorReservaciones_Adicionales FOREIGN KEY(IDAdicional) REFERENCES Adicionales(IDAdicional) ON DELETE CASCADE;
ALTER TABLE AdicionalesPorReservaciones ADD CONSTRAINT FK_AdicionalesPorReservaciones_Reservaciones FOREIGN KEY(IDReserva) REFERENCES Reservaciones(IDReserva) ON DELETE SET NULL;
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Canchas FOREIGN KEY(IDCancha, IDZona) REFERENCES Canchas(IDCancha, IDZona) ON DELETE SET NULL;
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Partidos FOREIGN KEY(IDPartido) REFERENCES Partidos(IDPartido) ON DELETE SET NULL;
ALTER TABLE Reservaciones ADD CONSTRAINT FK_Reservaciones_Pagos FOREIGN KEY(IDPago) REFERENCES Pagos(IDPago) ON DELETE CASCADE;
ALTER TABLE Encargados ADD CONSTRAINT FK_Encargados_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE Encargados ADD CONSTRAINT FK_Encargados_ZonasDeportivas FOREIGN KEY(IDZona) REFERENCES ZonasDeportivas(IDZona);
ALTER TABLE Calificaciones ADD CONSTRAINT FK_Calificaciones_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE Calificaciones ADD CONSTRAINT FK_Calificaciones_Encargados FOREIGN KEY(tidEncargado, nidEncargado) REFERENCES Encargados(tidJugador, nidJugador) ON DELETE CASCADE;
ALTER TABLE Jugadores ADD CONSTRAINT FK_Jugadores_Equipos FOREIGN KEY(IDEquipo) REFERENCES Equipos(IDEquipo) ON DELETE SET NULL;
ALTER TABLE TelefonosPorJugador ADD CONSTRAINT FK_TelefonosPorJugador_Jugadores FOREIGN KEY(tidJugador, nidJugador) REFERENCES Jugadores(tid, nid) ON DELETE CASCADE;
ALTER TABLE EquiposJueganPartidos ADD CONSTRAINT FK_EquiposJueganPartidos_Equipos FOREIGN KEY(IDEquipo) REFERENCES Equipos(IDEquipo) ON DELETE CASCADE;
ALTER TABLE EquiposJueganPartidos ADD CONSTRAINT FK_EquiposJueganPartidos_Partidos FOREIGN KEY(IDPartido) REFERENCES Partidos(IDPartido) ON DELETE CASCADE;