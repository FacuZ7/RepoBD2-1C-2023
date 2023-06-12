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
	BEGIN TRY
	if @telefono = '' OR @calle = '' OR @numero = '' OR @piso = '' OR @departamento = '' 
	BEGIN
	RAISERROR('Alguno de los datos ingresados esta vacio.',16,1)

	END
	ELSE 
	BEGIN

			Declare 
			@email varchar(100)
			,@fecha_nac date 

			SELECT @email = email, @fecha_nac = fecha_nac from cliente_prospecto
			WHERE @cliente_id = id_cliente_prospecto

			if @email is null AND @fecha_nac is null
			BEGIN
			RAISERROR('No se puede realizar la operacion. El prospecto no tiene ingresado su email o fecha de nacimiento.', 16,1)
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
						RAISERROR('Para el servicio ingresado, es de necesidad que ingrese un telefono',16,1)
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
				Declare 
				@estado_cliente int
				select @estado_cliente = estado_cliente_id from cliente_prospecto 
				where @cliente_id = id_cliente_prospecto

				if @estado_cliente <> 1 
					begin
					UPDATE cliente_prospecto
					set estado_cliente_id = 1
					where @cliente_id = id_cliente_prospecto
					end
			END
	END
	END TRY
	BEGIN CATCH
		SELECT
			ERROR_NUMBER() AS Numero_Error,
			ERROR_MESSAGE() AS Mensaje_Error 
	END CATCH
