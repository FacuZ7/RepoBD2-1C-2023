use TP_Facturas

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_InsertarVenta]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_InsertarVenta]
GO

CREATE PROCEDURE dbo.sp_InsertarVenta (
	@id_cliente int
	,@fecha date
)
AS
	insert into venta( 
		cliente_id
		,fecha
	)values(
		@id_cliente
		,@fecha
	)	
GO