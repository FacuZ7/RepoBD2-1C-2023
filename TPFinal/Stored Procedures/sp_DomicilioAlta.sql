use TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id= object_id(N'[dbo].[sp_DomicilioAlta]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DomicilioAlta]
GO

CREATE PROCEDURE dbo.sp_DomicilioAlta
	@calle varchar(50)
	,@numero varchar(10)
	,@piso varchar(10)
	,@departamento varchar(10)
AS
	BEGIN TRY
		
		INSERT INTO domicilio(
			calle
			,numero
			,piso
			,departamento
		)VALUES(
			@calle 
			,@numero 
			,@piso 
			,@departamento 
		)
				
	END TRY
	BEGIN CATCH
		SELECT 
			ERROR_NUMBER() AS NUMERO_ERROR,
			ERROR_MESSAGE() AS MENSAJE_ERROR
	END CATCH
