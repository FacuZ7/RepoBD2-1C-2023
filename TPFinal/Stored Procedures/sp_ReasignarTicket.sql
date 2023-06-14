use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ReasignarTicket]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_ReasignarTicket]
GO

CREATE PROCEDURE dbo.sp_ReasignarTicket(
	@id_ticket int
	,@empleado_id int
	,@duenio_id int
	)

AS
	BEGIN TRY
	IF EXISTS(SELECT * FROM ticket WHERE id_ticket = @id_ticket AND @duenio_id = empleado_id)
	BEGIN
			IF EXISTS (SELECT * FROM empleado WHERE id_empleado = @empleado_id and estado_empleado_id = 1)
			BEGIN
				UPDATE ticket
				SET empleado_id = @empleado_id
				WHERE id_ticket = @id_ticket
			END
			ELSE
			BEGIN
				RAISERROR('El empleado seleccionado esta inactivo', 16, 1)
			END
	END
	ELSE
	BEGIN
		RAISERROR('No se pudo reasignar el ticket porque el ticket seleccionado no existe o no es el dueño del ticket', 16, 1)
	END
	END TRY
	BEGIN CATCH
		SELECT 
			ERROR_NUMBER() AS Numero_Error,
			ERROR_MESSAGE() AS Mensaje_Error 
	END CATCH
	