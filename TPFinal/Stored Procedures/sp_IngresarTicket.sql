use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_IngresarTicket]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_IngresarTicket]
GO

CREATE PROCEDURE dbo.sp_IngresarTicket(
	@nombre varchar(30) 
	,@apellido varchar(30) 
	,@tipo_documento_id int 
	,@nro_documento varchar(8)
	,@empleado_id int
	,@tipologia_id int 
	,@servicio_id int
	)

AS

	DECLARE
	@count_cliente int, @cliente_id int, @sla_id int, @count_servicio int
	SELECT @count_cliente = COUNT(*) FROM cliente_prospecto 
	WHERE  @tipo_documento_id = tipo_documento_id and @nro_documento = nro_documento

	IF @count_cliente = 0
	BEGIN
		exec dbo.sp_IngresarCliente @nombre, @apellido, @tipo_documento_id, @nro_documento, null, null
	END

	SELECT @cliente_id = id_cliente_prospecto from cliente_prospecto
	WHERE  @tipo_documento_id = tipo_documento_id and @nro_documento = nro_documento
	
	SELECT @count_servicio = COUNT(*) from cliente_servicio
	WHERE @cliente_id = cliente_id and servicio_id = @servicio_id

	IF @servicio_id is null OR @count_servicio > 0
	BEGIN
		SELECT @sla_id  = id_sla from sla
		WHERE @tipologia_id = tipologia_id and @servicio_id = servicio_id



		INSERT INTO ticket 
		(empleado_id
		,cliente_prospecto_id
		,tipologia_id
		,servicio_id
		,estado_ticket_id
		,sla_id
		,fecha_creacion)
		VALUES(
		@empleado_id
		,@cliente_id
		,@tipologia_id
		,@servicio_id
		,1
		,@sla_id
		,GETDATE()
		)
	END
	ELSE
	BEGIN
		PRINT 'El cliente no posee el servicio ingresado.'
		ROLLBACK 
	END


	



	
		