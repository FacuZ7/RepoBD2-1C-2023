use TP_Facturas

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListarVentasXCliente]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListarVentasXCliente]
GO

CREATE PROCEDURE dbo.sp_ListarVentasXCliente (
	@id_cliente int,
	@fecha1 date,
	@fecha2 date
)

AS
  select * from venta as v where v.fecha between @fecha1 and @fecha2
  and v.cliente_id = @id_cliente
  
go


