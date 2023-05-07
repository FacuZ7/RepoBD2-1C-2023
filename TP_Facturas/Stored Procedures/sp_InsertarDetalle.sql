use TP_Facturas

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_InsertarDetalle]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_InsertarDetalle]
GO

CREATE PROCEDURE dbo.sp_InsertarDetalle (
	@venta_id int 
	,@producto_id int
	,@cantidad int
)

AS

Declare @CantStock int = (select stock from producto where id_producto = @producto_id)

	if (@CantStock >= 5) AND @CantStock >= @cantidad begin
		insert into Detalle(
			venta_id
			,producto_id
			,cantidad
		)values(
			@venta_id
			,@producto_id
			,@cantidad
		) 

		update Producto set stock = stock - @cantidad where id_producto = @producto_id
	end
	else begin
		print 'No hay stock suficiente'
	end


GO

