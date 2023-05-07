use TP_Facturas

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_BorrarTelefono]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop procedure [dbo].[sp_BorrarTelefono]
GO

CREATE PROCEDURE dbo.sp_BorrarTelefono (
	@id_telefono int
)

AS
	Declare 
		@id_cliente int = (select cliente_id from Telefono where id_telefono =  @id_telefono)
	Declare
		@cantidadTelefonos int = (select count(id_telefono) from Telefono where cliente_id = @id_cliente)

	if @cantidadTelefonos > 1 begin
		delete from Telefono where id_telefono = @id_telefono
	end
	else begin
		print 'No se puede eliminar el telefono'
	end
GO