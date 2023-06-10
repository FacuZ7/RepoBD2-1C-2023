if exists (select * from dbo.sysobjects where id= object_id(N'[dbo].[sp_DomicilioAlta]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DomicilioAlta]
GO

CREATE PROCEDURE dbo.sp_DomicilioAlta
	@calle varchar(50)
	,@numero varchar(10)
	,@piso varchar(10)
	,@departamento varchar(10)
AS
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
