use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_IngresarCliente]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_IngresarCliente]
GO

CREATE PROCEDURE dbo.sp_IngresarCliente (
	@nombre varchar(30) 
	,@apellido varchar(30) 
	,@tipo_documento_id int 
	,@nro_documento varchar(8) 
	,@email varchar(100)
	,@fecha_nac date
)

AS
	BEGIN TRY
		BEGIN TRAN
			if @nombre = '' OR @apellido = '' OR @tipo_documento_id = '' OR @nro_documento = '' 
			BEGIN
			RAISERROR('Alguno de los datos ingresados esta vacio.', 16, 1)
		 
			END
			insert into cliente_prospecto 
			(
			nombre
			,apellido
			,tipo_documento_id
			,nro_documento
			,email
			,fecha_nac
			,estado_cliente_id
			)
			VALUES(
			 @nombre
			 ,@apellido
			 ,@tipo_documento_id
			 ,@nro_documento
			 ,@email
			 ,@fecha_nac
			 ,3	
			)
		COMMIT
	END TRY
	BEGIN CATCH
		
		ROLLBACK TRAN;
		THROW
	
	END CATCH