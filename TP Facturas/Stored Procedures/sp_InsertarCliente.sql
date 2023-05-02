use TP_Facturas

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_InsertarCliente]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_InsertarCliente]
GO

CREATE PROCEDURE dbo.sp_InsertarCliente(
	@nombre varchar(60)
	,@apellido varchar(60)
	,@dni numeric(8)
	,@fecha_nac date
	,@mail varchar(50)
	,@telefono int = 0
)

AS
	declare @cliente_id int 

	insert into Cliente values(
		@nombre 
		,@apellido 
		,@dni 
		,@fecha_nac 
		,@mail 
	)

	set @cliente_id = scope_identity()

	if @telefono <> 0 begin
		insert into Telefono values(
			@telefono
			,@cliente_id
		)
	end

	

GO

