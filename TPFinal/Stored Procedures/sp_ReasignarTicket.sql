use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ReasignarTicket]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_ReasignarTicket]
GO

CREATE PROCEDURE dbo.sp_ReasignarTicket(
	@id_ticket int
	,@empleado_id int
	)

AS
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
			PRINT 'El empleado seleccionado esta inactivo'
		END
	END
	ELSE
	BEGIN
		PRINT 'El ticket seleccionado no existe'
	END
	
	