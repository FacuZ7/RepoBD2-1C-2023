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
		DECLARE
		@se_puede int, 
		@estado_anterior_id int, 
		@fecha_cierre datetime,
		@fecha_resolucion datetime,
		@cumple_sla int = null
	
	BEGIN TRY
	BEGIN TRAN
		
		IF EXISTS (SELECT * from ticket where @id_ticket = id_ticket)
		BEGIN
			SELECT @estado_anterior_id = estado_ticket_id, 
				@fecha_cierre = fecha_cierre, 
				@fecha_resolucion = fecha_resolucion 
			from ticket 
			where @id_ticket = id_ticket

			set @se_puede = dbo.chk_Cambio_Estado_Ticket(@estado_anterior_id, @estado_ticket_id)

			IF @se_puede = 1
			BEGIN
				IF EXISTS (SELECT * from ticket
				WHERE id_ticket = @id_ticket and @empleado_id = empleado_id)
				BEGIN
						IF @estado_ticket_id = 5 
						BEGIN 
							SELECT @fecha_cierre = GETDATE(), 
							@cumple_sla = dbo.fn_cumple_sla(@id_ticket,GETDATE())
						END
						ELSE IF @estado_ticket_id = 4
						BEGIN
							SELECT @fecha_resolucion = GETDATE(), 
							@cumple_sla = dbo.fn_cumple_sla(@id_ticket,GETDATE())
						END
						
						UPDATE ticket
						SET fecha_resolucion = @fecha_resolucion,
							cumple_sla= @cumple_sla,
							fecha_cierre = @fecha_cierre,
							estado_ticket_id = @estado_ticket_id
						WHERE id_ticket = @id_ticket

						exec dbo.sp_EnviarNotificacion @id_ticket, @estado_ticket_id
				
						/*UPDATE ticket
						SET estado_ticket_id = @estado_ticket_id
						WHERE @id_ticket = id_ticket
						exec dbo.sp_EnviarNotificacion @id_ticket, @estado_ticket_id
						IF @estado_ticket_id = 5
						BEGIN
							UPDATE ticket
							SET fecha_cierre = GETDATE(),
							cumple_sla= dbo.fn_cumple_sla(@id_ticket,GETDATE())
							WHERE id_ticket = @id_ticket
						END
						ELSE IF @estado_ticket_id = 4
						BEGIN
							UPDATE ticket
							SET fecha_resolucion = GETDATE(),
							cumple_sla= dbo.fn_cumple_sla(@id_ticket,GETDATE())
							WHERE id_ticket = @id_ticket
						END
						*/
	
				END
				ELSE
				BEGIN
					RAISERROR('El cambio solo puede realizarlo el dueño del ticket',16,1)
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
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		THROW
		ROLLBACK TRAN
	END CATCH
	