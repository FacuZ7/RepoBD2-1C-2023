use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_IngresarServicio]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_IngresarServicio]
GO

CREATE PROCEDURE dbo.sp_IngresarServicio (
	@cliente_id int
	,@servicio_id int 
	,@telefono varchar(12) 
	,@calle varchar(30) 
	,@numero varchar(10) 
	,@piso varchar(5)
	,@departamento varchar(10)
)

AS

	if @telefono = '' OR @calle = '' OR @numero = '' OR @piso = '' OR @departamento = '' 
	BEGIN
	PRINT 'Alguno de los datos ingresados esta vacio.'
	END
	ELSE 
	BEGIN

	EXEC dbo.sp_DomicilioAlta @calle, @numero, @piso, @departamento
	Declare 
	@id_domicilio int
	select @id_domicilio= id_domicilio from domicilio 
	where @calle = calle and @numero = numero and @piso = piso and @departamento = departamento

	if @servicio_id <> 2 
	begin
		if @telefono is null
		begin 
			print 'Para el servicio ingresado, es de necesidad que ingrese un telefono'
		end
		else
		begin
		insert into cliente_servicio VALUES(
	@cliente_id,
	@servicio_id,
	@telefono,
	@id_domicilio,
	GETDATE(),
	1
	)
		end
	end
	else
	begin
	insert into cliente_servicio VALUES(
	@cliente_id,
	@servicio_id,
	null,
	@id_domicilio,
	GETDATE(),
	1
	)
	end
	UPDATE cliente_prospecto
	set estado_cliente_id = 1
	where @cliente_id = id_cliente_prospecto

END

