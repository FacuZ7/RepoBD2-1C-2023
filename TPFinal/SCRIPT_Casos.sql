USE TP_FINAL_GRUPO5


SELECT * FROM TICKET
SELECT * FROM cliente_prospecto where id_cliente_prospecto = 4
SELECT * FROM cliente_servicio inner join cliente_prospecto on id_cliente_prospecto = cliente_id where cliente_id = 6
SELECT * FROM notificacion_cambio_estado
SELECT * FROM empleado

GO
exec dbo.sp_IngresarCliente 'Hernan', 'Sosa', 1,'23146460','hsosa@gmail.com','1970/02/24'--Alta de un nuevo Cliente
GO
exec dbo.sp_IngresarCliente NULL, 'Sosa', 1,'23146460','hsosa@gmail.com','1970/02/24'--Intentar dar de alta un cliente (prospecto) sin
																						--datos mínimos requeridos o erróneos
GO
exec dbo.sp_IngresarCliente 'Camila', 'Sosa', 1,'23146460','hsosa@gmail.com','1970/02/24'--Intentar dar de alta un cliente (prospecto) sin
																						--datos mínimos requeridos o erróneos
GO
exec dbo.sp_IngresarCliente '', 'Sosa', 1,'23146460','hsosa@gmail.com','1970/02/24' -- Intentar dar de alta un cliente (prospecto) sin
																					--datos mínimos requeridos o erróneos
GO
exec dbo.sp_IngresarServicio 6,2,null,'Tinogasta','3344',null,null -- Crear un nuevo servicio a un Prospecto
GO
exec dbo.sp_IngresarServicio 3,1,'1124715542','Sanabria','3443','1','2' -- Crear un nuevo servicio a un Cliente Inactivo
GO
exec dbo.sp_IngresarServicio 1,2,null,'Pedro Moran','3565',null,null -- CREAR SERVICIO A PROSPECTO SIN EMAIL NI FECHA DE NACIMIENTO
GO
exec dbo.sp_InactivarServicio 2 --Inactivar un Servicio a un cliente con un solo servicio activo
GO
exec dbo.sp_InactivarServicio 1  --Inactivar un Servicio a un cliente con más de un servicio activo
GO
exec dbo.sp_IngresarTicket 'Mauro', 'Neuer', 1, '71538960', 1, 1, 2 -- Generar un nuevo ticket
GO
exec dbo.sp_CambiarEstadoTicket 3,2,1 -- Cambiar el estado de un Ticket a un estado diferente de resuelto
GO
exec dbo.sp_CambiarEstadoTicket 3,4,1 -- Cambiar el estado de un Ticket a Resuelto
GO
exec dbo.sp_CambiarEstadoTicket 3,1,1 -- Intentar realizar un cambio a un estado no permitido
GO
exec dbo.sp_ReasignarTicket 3,2,1 -- Reasignar un Ticket abierto a un usuario activo
GO
exec dbo.sp_ReasignarTicket 3,3,2 -- Intentar reasignar un Ticket a un usuario Inactivo
GO
exec dbo.sp_CambiarEstadoTicket 3,5,2 -- Cambiar el estado de un Ticket a Cerrado
GO
exec dbo.sp_CambiarEstadoTicket 1,2,2 -- Intentar hacer cualquier cambio del ticket con un usuario diferente al dueño
GO
