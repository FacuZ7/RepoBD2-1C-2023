use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_InactivarServicio]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_InactivarServicio]
GO

CREATE PROCEDURE dbo.sp_InactivarServicio (
	@nro_cliente_servicio int
	)

AS
	
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
	
			