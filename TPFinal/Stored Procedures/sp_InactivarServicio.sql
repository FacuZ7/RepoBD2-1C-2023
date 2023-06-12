use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_InactivarServicio]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_InactivarServicio]
GO

CREATE PROCEDURE dbo.sp_InactivarServicio (
	@nro_cliente_servicio int
	)

AS
	BEGIN TRY
		IF EXISTS(SELECT * FROM cliente_servicio
		WHERE nro_cliente_servicio = @nro_cliente_servicio and estado_servicio_id = 1)
		BEGIN
		DECLARE
		@cliente_id int, @count int
		SELECT @cliente_id = cliente_id from cliente_servicio
		WHERE @nro_cliente_servicio = nro_cliente_servicio
		
		UPDATE cliente_servicio
		SET estado_servicio_id = 2
		WHERE nro_cliente_servicio = @nro_cliente_servicio

		SELECT @count = COUNT(*) from cliente_servicio
		WHERE @cliente_id = cliente_id and estado_servicio_id = 1

		IF @count < 1
		BEGIN
			UPDATE cliente_prospecto
			SET estado_cliente_id = 2
			WHERE @cliente_id = id_cliente_prospecto
		END
		END
		ELSE
		BEGIN
		RAISERROR('El numero de servicio ingresado no existe o ya se encuentra inactivo.',16,1)
		END
	END TRY 
	BEGIN CATCH
		SELECT
			ERROR_NUMBER() AS NUMERO_ERROR,
			ERROR_MESSAGE() AS MENSAJE_ERROR
	END CATCH