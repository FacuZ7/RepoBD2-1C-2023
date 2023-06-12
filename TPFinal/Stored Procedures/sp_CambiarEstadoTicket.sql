use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CambiarEstadoTicket]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_CambiarEstadoTicket]
GO

CREATE PROCEDURE dbo.sp_CambiarEstadoTicket(
	@id_ticket int
	,@estado_ticket_id int
	,@empleado_id int
	)

AS
	BEGIN TRY
		DECLARE
		@se_puede int, @estado_anterior_id int
		IF EXISTS (SELECT * from ticket where @id_ticket = id_ticket)
		BEGIN
			SELECT @estado_anterior_id = estado_ticket_id from ticket where @id_ticket = id_ticket
			 set @se_puede = dbo.chk_Cambio_Estado_Ticket(@estado_anterior_id, @estado_ticket_id)
			 IF @se_puede = 1
			 BEGIN
				IF EXISTS (SELECT * from ticket
				WHERE id_ticket = @id_ticket and @empleado_id = empleado_id)
				BEGIN
					UPDATE ticket
					SET estado_ticket_id = @estado_ticket_id
					WHERE @id_ticket = id_ticket
					exec dbo.sp_EnviarNotificacion @id_ticket, @estado_ticket_id
					IF @estado_ticket_id = 5
					BEGIN
						UPDATE ticket
						SET fecha_cierre = GETDATE()
						WHERE id_ticket = @id_ticket
					END
					ELSE IF @estado_ticket_id = 4
					BEGIN
						UPDATE ticket
						SET fecha_resolucion = GETDATE()
						WHERE id_ticket = @id_ticket
					END
				END
				ELSE
				BEGIN
					RAISERROR('El cambio solo puede realizarlo el due�o del ticket',16,1)
				END
			 END
			 ELSE
			 BEGIN
				RAISERROR('No es posible cambiar a estado ingresado.',16,1)
			 END
		END
		ELSE
		BEGIN
			RAISERROR('El ticket ingresado no existe',16,1)
		END
	END TRY
	BEGIN CATCH
			SELECT
			ERROR_NUMBER() AS Numero_Error,
			ERROR_MESSAGE() AS Mensaje_Error 
	END CATCH
	