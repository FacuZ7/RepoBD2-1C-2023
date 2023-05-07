use TP_Facturas

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ObtenerProductosPorPais]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_ObtenerProductosPorPais]
GO

CREATE PROCEDURE dbo.sp_ObtenerProductosPorPais (
	@id_Pais int
)

AS
	select * from producto where pais_importador_id = @id_Pais
GO