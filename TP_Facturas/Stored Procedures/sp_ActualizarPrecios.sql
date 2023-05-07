use TP_Facturas

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ActualizarPrecios]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_ActualizarPrecios]
GO

CREATE PROCEDURE dbo.sp_ActualizarPrecios (
	@porc_Aumento tinyint
)

AS
	update Producto set precio_unitario = precio_unitario * ((@porc_Aumento / 100) + 1)
GO
