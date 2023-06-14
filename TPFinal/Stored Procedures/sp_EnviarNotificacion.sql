use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_EnviarNotificacion]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_EnviarNotificacion]
GO

CREATE PROCEDURE dbo.sp_EnviarNotificacion(
	@id_ticket int
	,@estado_ticket_id int
	)

AS
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO notificacion_cambio_estado
			VALUES(
			@id_ticket
			,@estado_ticket_id
			,GETDATE()
			)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		THROW
	END CATCH
