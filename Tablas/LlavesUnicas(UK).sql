--Llaves Unicas (UK)

ALTER TABLE ZonasDeportivas ADD CONSTRAINT UK_ZonasDeportivas UNIQUE(direccion);
ALTER TABLE Encargados ADD CONSTRAINT UK_Encargados UNIQUE(foto);
ALTER TABLE Jugadores ADD CONSTRAINT UK_Jugadores UNIQUE(correo);
ALTER TABLE Equipos ADD CONSTRAINT UK_Equipos UNIQUE(nombre);