USE TP_FINAL_GRUPO5

INSERT INTO estado_empleado VALUES(
	'Activo'
),(
	'Inactivo'
)

INSERT INTO estado_cliente VALUES(
	'Activo'
),(
	'Inactivo'
),(
	'Prospecto'
)

INSERT INTO tipo_documento VALUES(
	'DNI'
),(
	'Pasaporte'
),(
	'CUIT'
)

INSERT INTO estado_servicio VALUES(
	'Activo'
),(
	'Inactivo'
)

INSERT INTO servicio VALUES(
	'Telefono Fijo'
),(
	'Internet'
),(
	'VOIP'
)

INSERT INTO tipologia VALUES(
	'Reimpresión de factura'
),(
	'Servicio degradado'
),(
	'Baja de servicio'
),(
	'Facturación de cargos erroneos'
),(
	'Cambio de velocidad'
),(
	'Mudanza de servicio'
)

INSERT INTO actividad VALUES(
	'Reinicio router'
),(
	'Cambio de cableado interno'
),(
	'Envio de factura'
),(
	'Cambio bajada cableado desde azotea'
)

INSERT INTO estado_ticket VALUES(
	'Abierto'
),(
	'En progreso'
),(
	'Pendiente cliente'
),(
	'Resuelto'
),(
	'Cerrado'
)

INSERT INTO domicilio (calle, numero, piso, departamento) VALUES
('Cabildo', '123', '2', 'B'),
('Juan B Justo', '456', '1', 'A'),
('Brandsen', '805', NULL, NULL);

INSERT INTO cliente_prospecto VALUES
	('Juan Roman','Maradona',1,'85974521',null,null,3) --prospecto
	,('Carlos','Baute',1,'87593105','cbaute@gmail.com','1987/05/02',1) --activo
	,('Adriana','Cantilo',2,'35042689','adriana@yaju.com','1960/09/30',2) --inactivo
	,('Mauro','Neuer',1,'71538960','neuer@live.com.ar','1981/01/15',1) --activo
	,('Hernan','Vilouta',2,'35345661','hernan@hotmail.com','2001/09/11',1) --activo


INSERT INTO cliente_servicio (cliente_id, servicio_id, telefono, domicilio_id, fecha_inicio, estado_servicio_id) VALUES
(4, 1, '123456789', 1, '2023/01/01', 1),
(2, 2, null , 2, '2020/07/16', 1),
(3, 3, '555555555', 3, GETDATE(), 2);


INSERT INTO sla VALUES
(1,1,12),
(5,2,72),
(2,3,24)

INSERT INTO empleado VALUES
('Cristian','Bragarnik','CBRAGARNIK',1),
('Julieta','Poggio','JPOGGIO',1),
('Juan','Reverdito','JREVERDITO',2)

INSERT INTO ticket VALUES
(1,2,5,2,1,2,GETDATE(),null,null,null)

INSERT INTO ticket VALUES
(2,4,1,1,2,1,GETDATE(),null,null,null)

INSERT INTO ticket_actividad VALUES
(1,1),
(3,2)

--********************************************* ZONA DE EJECUCION **********************************************************





--*****************************************************************************************************************



