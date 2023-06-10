if exists (select * from dbo.sysobjects where id= object_id(N'[dbo].[Cliente_Prospecto_Modi_TR]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Cliente_Prospecto_Modi_TR]
GO

CREATE TRIGGER Cliente_Prospecto_Modi_TR
ON cliente_prospecto
FOR UPDATE
AS
BEGIN 

  Declare 
	@id_cliente_prospecto int
	,@nombre varchar(50)
	,@apellido varchar(50)
	,@tipo_documento_id int
	,@nro_documento varchar(8)

	select 
		@id_cliente_prospecto = id_cliente_prospecto
		,@nombre = nombre
		,@apellido = apellido
		,@tipo_documento_id= tipo_documento_id
		,@nro_documento = nro_documento
	from 
		inserted

	if @nombre is not null OR @apellido is not null OR @tipo_documento_id is not null OR @nro_documento is not null begin
		Declare
		@Estado int
		select @Estado = estado_cliente_id 
		from cliente_prospecto
		where id_cliente_prospecto = @id_cliente_prospecto

		if @Estado <> 3 begin
			print 'no se puede cambiar'
			rollback
		end
	end 

END