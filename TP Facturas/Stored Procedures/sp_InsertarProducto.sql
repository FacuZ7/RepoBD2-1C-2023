use TP_Facturas

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_InsertarProducto]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_InsertarProducto]
GO

CREATE PROCEDURE dbo.sp_InsertarProducto (
	@nombre varchar(50)
	,@pais_importadorID int
	,@precio_unitario decimal (10,2)
	,@stock int
)

AS
	insert into producto values(
	@nombre 
	,@pais_importadorID 
	,@precio_unitario
	,@stock
	)

go