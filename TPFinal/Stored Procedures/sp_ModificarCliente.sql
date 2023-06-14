use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ModificarCliente]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_ModificarCliente]
GO

CREATE PROCEDURE dbo.sp_ModificarCliente (
	@id_cliente_prospecto int
	,@nombre varchar(30) 
	,@apellido varchar(30) 
	,@tipo_documento_id int 
	,@nro_documento varchar(8) 
	,@email varchar(100)
	,@fecha_nac date
)

AS
	BEGIN TRY
		BEGIN TRAN
			
			if @nombre = '' OR @apellido = '' OR @tipo_documento_id = '' OR @nro_documento = '' OR @email = '' OR @fecha_nac = '' 
			BEGIN
			RAISERROR('Alguno de los datos ingresados esta vacio.', 16, 1)
			END
			IF EXISTS (SELECT * FROM cliente_prospecto where id_cliente_prospecto = @id_cliente_prospecto )
			BEGIN
				IF @nombre is null
				BEGIN
					select @nombre = nombre FROM cliente_prospecto where id_cliente_prospecto = @id_cliente_prospecto
				END
				IF @apellido is null
				BEGIN
					SELECT @apellido = apellido FROM cliente_prospecto where id_cliente_prospecto = @id_cliente_prospecto
				END
				IF @tipo_documento_id is null
				BEGIN
					SELECT @tipo_documento_id = tipo_documento_id FROM cliente_prospecto where id_cliente_prospecto = @id_cliente_prospecto
				END
				IF @nro_documento is null
				BEGIN
					SELECT @nro_documento = nro_documento FROM cliente_prospecto where id_cliente_prospecto = @id_cliente_prospecto
				END
				IF @email is null
				BEGIN
					SELECT @email = email FROM cliente_prospecto where id_cliente_prospecto = @id_cliente_prospecto
				IF @fecha_nac is null
				BEGIN
					SELECT @fecha_nac = fecha_nac FROM cliente_prospecto where id_cliente_prospecto = @id_cliente_prospecto
				END
			END
			
			UPDATE cliente_prospecto
			SET nombre=@nombre
			,apellido = @apellido
			,tipo_documento_id = @tipo_documento_id
			,nro_documento = @nro_documento
			,email = @email
			,fecha_nac = @fecha_nac
			WHERE id_cliente_prospecto = @id_cliente_prospecto

			
			END
		COMMIT
	END TRY
	BEGIN CATCH
		
		ROLLBACK TRAN;
		THROW
	
	END CATCH