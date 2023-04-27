CREATE TABLE CLIENTE(
	id_cliente int IDENTITY(1,1) CONSTRAINT PK_Id_Cliente PRIMARY KEY (id_cliente)
	,nombre varchar(30)
	,apellido varchar(50)
	,numero_linea varchar(20)
	,id_plan int CONSTRAINT FK_Cliente_Plan FOREIGN KEY (id_plan) REFERENCES [PLAN] 
)

CREATE TABLE [PLAN](
	id_plan int IDENTITY(1,1) CONSTRAINT PK_id_plan PRIMARY KEY (id_plan)
	,tarifa_conexion decimal(10,2)
	,precio_por_segundo decimal (10,2)
)

CREATE TABLE LLAMADOS(
	id_cliente int CONSTRAINT FK_Llamados_Cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE
	,fecha datetime
	,hora time
	,linea_llamada varchar(30)
	,segundos int
	,CONSTRAINT PK_Compuesta_Cliente_Fecha_Hora PRIMARY KEY(id_cliente,fecha,hora)
)

CREATE TABLE FACTURA(
	id_cliente int
	,anio int CONSTRAINT CHK_Anio CHECK (anio > 0 AND anio < 9999) 
	,mes tinyint
	,importe decimal(10,2)
	,CONSTRAINT PK_Compuesta_Cliente_Anio_Mes PRIMARY KEY(id_cliente,anio,mes)
)

