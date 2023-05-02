create database TP_Facturas
use TP_Facturas

CREATE TABLE Cliente (
	id_cliente int identity(1,1) CONSTRAINT PK_Cliente PRIMARY KEY
	,nombre varchar(60) not null
	,apellido varchar(60) not null
	,dni numeric(8) not null
	,fecha_nacimiento date CONSTRAINT CHK_FechaNac CHECK (fecha_nacimiento > '01/01/1900' AND fecha_nacimiento < (dateadd(DD,+1,getdate()))) not null
	,mail varchar(50)
)

CREATE TABLE Telefono (
	id_telefono int PRIMARY KEY
	,cliente_id int CONSTRAINT FK_Telefono_ClienteID FOREIGN KEY REFERENCES Cliente(id_cliente)
)

CREATE TABLE Pais(
	id_pais int IDENTITY(1,1) PRIMARY KEY
	,nombre varchar(50) not null
)

CREATE TABLE Producto(
	id_producto int IDENTITY(1,1) PRIMARY KEY
	,nombre varchar(50) not null
	,pais_importador_id int FOREIGN KEY REFERENCES Pais(id_pais) 
	,precio_unitario decimal(10,2) not null
	,stock int not null
)

CREATE TABLE Venta(
	id_venta int IDENTITY(1,1) PRIMARY KEY
	,cliente_id int FOREIGN KEY REFERENCES Cliente(id_cliente) not null
	,fecha date not null 
)

CREATE TABLE Detalle(
	id_detalle int IDENTITY(1,1) PRIMARY KEY
	,venta_id int FOREIGN KEY REFERENCES Venta(id_venta) not null
	,producto_id int  FOREIGN KEY REFERENCES Producto(id_producto) not null
	,cantidad int not null CHECK (cantidad > 0)
)

