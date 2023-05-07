use TP_Facturas

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_VerificarStock]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_VerificarStock]
GO

CREATE PROCEDURE dbo.sp_VerificarStock (
	@id_producto int
)

AS	
	select 
		stock 
	from 
		Producto 
	where 
		id_producto = @id_producto
go
