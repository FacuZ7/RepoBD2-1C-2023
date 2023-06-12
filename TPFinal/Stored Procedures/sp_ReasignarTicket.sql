use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ReasignarTicket]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_ReasignarTicket]
GO

CREATE PROCEDURE dbo.sp_ReasignarTicket(
	@id_ticket int
	,@empleado_id int
	)

AS
	BEGIN TRY
	IF EXISTS(SELECT * FROM ticket WHERE id_ticket = @id_ticket)
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
		RAISERROR('El ticket seleccionado no existe', 16, 1)
	END
	END TRY
	BEGIN CATCH
		SELECT 
			ERROR_NUMBER() AS Numero_Error,
			ERROR_MESSAGE() AS Mensaje_Error 
	END CATCH
	