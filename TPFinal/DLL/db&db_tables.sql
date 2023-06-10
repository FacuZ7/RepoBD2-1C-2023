CREATE DATABASE TP_FINAL_GRUPO5
GO
USE TP_FINAL_GRUPO5
GO
CREATE TABLE tipo_documento(
	id_tipo_documento int identity(1,1) primary key
	,descripcion_tipo_documento varchar(25)
)
GO
CREATE TABLE estado_cliente(
	id_estado_cliente int identity(1,1) primary key
	,descripcion_estado varchar(10) not null
)
GO
CREATE TABLE estado_servicio(
	id_estado_servicio int identity(1,1) primary key
	,descripcion_estado varchar(10) not null
)
GO
CREATE TABLE estado_empleado(
	id_estado_empleado int identity(1,1) primary key
	,descripcion_estado varchar(10) not null
)
GO
CREATE TABLE estado_ticket(
	id_estado_ticket int identity(1,1) primary key
	,descripcion_estado varchar(20) not null
)
GO
CREATE TABLE cliente_prospecto (
	id_cliente_prospecto int identity(1,1) primary key
	,nombre varchar(30) not null 
	,apellido varchar(30) not null
	,tipo_documento_id int not null CONSTRAINT FK_tipo_documento_cliente_prospecto foreign key (tipo_documento_id) references tipo_documento(id_tipo_documento)
	,nro_documento varchar(8) CONSTRAINT chk_ochoCaracteresObligatorio CHECK (LEN(nro_documento) = 8) --obligatoriamente 8
	,email varchar(100) CONSTRAINT chk_formatoEmail CHECK (email LIKE '%_@__%.__%')
	,fecha_nac date
	,estado_cliente_id int not null CONSTRAINT FK_estado_cliente_cliente_prospecto foreign key(estado_cliente_id) references estado_cliente(id_estado_cliente)
)
GO
CREATE TABLE servicio(
	id_servicio int identity(1,1) primary key
	,descripcion_servicio varchar(50) not null
)
GO
CREATE TABLE domicilio(
	id_domicilio int identity(1,1) primary key
	,calle varchar(30) not null
	,numero varchar(10) not null
	,piso varchar(5)
	,departamento varchar(10)
)
GO
CREATE TABLE cliente_servicio(
	nro_cliente_servicio int identity(1,1) primary key
	,cliente_id int not null CONSTRAINT FK_cliente_servicio_cliente_prospecto FOREIGN KEY (cliente_id) REFERENCES cliente_prospecto(id_cliente_prospecto)
	,servicio_id int not null CONSTRAINT FK_cliente_servicio_servicio FOREIGN KEY (servicio_id) REFERENCES servicio(id_servicio)
	,telefono varchar(12)
	,domicilio_id int CONSTRAINT FK_cliente_servicio_domicilio FOREIGN KEY (domicilio_id) REFERENCES domicilio(id_domicilio)
	,fecha_inicio date not null CONSTRAINT df_fechacreacion DEFAULT GETDATE()
	,estado_servicio_id int not null CONSTRAINT FK_cliente_servicio_estado_servicio FOREIGN KEY (estado_servicio_id) REFERENCES estado_servicio(id_estado_servicio)
)
GO
CREATE TABLE tipologia(
	id_tipologia int identity(1,1) primary key
	,descripcion_tipologia varchar(75) not null
)
GO
CREATE TABLE sla(
	id_sla int identity(1,1) primary key
	,tipologia_id int CONSTRAINT FK_sla_tipologia FOREIGN KEY (tipologia_id) REFERENCES tipologia(id_tipologia)
	,servicio_id int CONSTRAINT FK_sla_servicio FOREIGN KEY (servicio_id) REFERENCES servicio(id_servicio)
	,tiempo_sla int 
)
GO
CREATE TABLE empleado(
	id_empleado int identity(1,1) primary key
	,nombre varchar(25) not null
	,apellido varchar(50) not null
	,[login] varchar(100) not null
	,estado_empleado_id int CONSTRAINT FK_empleado_estado_empleado FOREIGN KEY (estado_empleado_id) REFERENCES estado_empleado(id_estado_empleado)
)
GO
CREATE TABLE actividad(
	id_actividad int identity(1,1) primary key
	,descripcion_actividad varchar(100) not null
)
GO
CREATE TABLE ticket(
	id_ticket int identity(1,1) primary key
	,empleado_id int CONSTRAINT FK_ticket_empleado FOREIGN KEY (empleado_id) REFERENCES empleado(id_empleado)
	,cliente_prospecto_id int CONSTRAINT FK_ticket_cliente_prospecto FOREIGN KEY (cliente_prospecto_id) REFERENCES cliente_prospecto(id_cliente_prospecto)
	,tipologia_id int CONSTRAINT FK_ticket_tipologia FOREIGN KEY (tipologia_id) REFERENCES tipologia(id_tipologia)
	,servicio_id  int CONSTRAINT FK_ticket_servicio FOREIGN KEY (servicio_id) REFERENCES servicio(id_servicio)
	,estado_ticket_id int CONSTRAINT FK_ticket_estado_ticket FOREIGN KEY (estado_ticket_id) REFERENCES estado_ticket(id_estado_ticket)
	,sla_id int CONSTRAINT FK_ticket_sla FOREIGN KEY (sla_id) REFERENCES sla(id_sla)
	,fecha_creacion datetime
	,fecha_resolucion datetime
	,fecha_cierre datetime
	,cumple_sla bit

)
GO
CREATE TABLE ticket_actividad(
	id_ticket_actividad int identity(1,1) primary key
	,actividad_id int CONSTRAINT FK_ticket_actividad_actividad FOREIGN KEY (actividad_id) REFERENCES actividad(id_actividad)
	,ticket_id int CONSTRAINT FK_ticket_actividad_ticket FOREIGN KEY (ticket_id) REFERENCES ticket(id_ticket)
)
GO
CREATE TABLE notificacion_cambio_estado(
	id_notificacion_cambio_estado int identity(1,1) primary key
	,ticket_id int CONSTRAINT FK_notificacion_cambio_estado_ticket FOREIGN KEY (ticket_id) REFERENCES ticket(id_ticket)
	,estado_ticket_id int CONSTRAINT FK_notificacion_cambio_estado_estado_ticket FOREIGN KEY (estado_ticket_id) REFERENCES estado_ticket(id_estado_ticket)
	,cliente_prospecto_id int CONSTRAINT FK_notificacion_cambio_estado_cliente_prospecto FOREIGN KEY (cliente_prospecto_id) REFERENCES cliente_prospecto(id_cliente_prospecto)
	,fecha datetime 
)
GO

