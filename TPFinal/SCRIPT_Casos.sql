USE TP_FINAL_GRUPO5

GO
exec dbo.sp_IngresarCliente 'Hernan', 'Sosa', 1,'23146460','hsosa@gmail.com','1970/02/24'--Alta de un nuevo Cliente

GO
exec dbo.sp_IngresarCliente NULL, 'Sosa', 1,'23146460','hsosa@gmail.com','1970/02/24'--Intentar dar de alta un cliente (prospecto) sin datos mínimos requeridos o erróneos

GO
exec dbo.sp_IngresarCliente 'Camila', 'Vior', 1,'23146460','cvior@gmail.com','1970/02/24'--Intentar dar de alta un cliente (prospecto) sin datos mínimos requeridos o erróneos

GO
exec dbo.sp_IngresarCliente '', 'Sosa', 1,'23146460','hsosa@gmail.com','1970/02/24' -- Intentar dar de alta un cliente (prospecto) sin datos mínimos requeridos o erróneos

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
exec dbo.sp_ModificarCliente 3,'Adriano', null, null, null, null, null  -- Intentar modificar el nombre o apellido para un cliente activo

GO
exec dbo.sp_ModificarCliente 1,'Diego', null, null, null, null, null -- Modificar el nombre, apellido o fecha de nacimiento para un prospecto

GO
exec dbo.sp_ModificarCliente 3,null , null, null, null, null, '2000/09/07'  -- Intentar modificar la fecha de nacimiento de un cliente Activo

GO
exec dbo.sp_IngresarCliente 'Maria', 'Zapata', 2,'24146460','mzapatagmail.com','1970/02/24' -- Intentar crear un cliente con un email inválido