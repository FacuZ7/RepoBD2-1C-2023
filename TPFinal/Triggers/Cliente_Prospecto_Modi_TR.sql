USE TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id= object_id(N'[dbo].[Cliente_Prospecto_Modi_TR]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Cliente_Prospecto_Modi_TR]
GO


CREATE TRIGGER Cliente_Prospecto_Modi_TR
ON cliente_prospecto
FOR UPDATE
AS
BEGIN 

  Declare 
	@id_cliente_prospecto_inserted int
	,@nombre_inserted varchar(50)
	,@apellido_inserted varchar(50)
	,@tipo_documento_id_inserted int
	,@nro_documento_inserted varchar(8)
	,@nombre varchar(50)
	,@apellido varchar(50)
	,@tipo_documento_id int
	,@nro_documento varchar(8)

	select 
		@id_cliente_prospecto_inserted = id_cliente_prospecto
		,@nombre_inserted = nombre
		,@apellido_inserted = apellido
		,@tipo_documento_id_inserted= tipo_documento_id
		,@nro_documento_inserted = nro_documento
	from 
		inserted

	select 
		@nombre = nombre
		,@apellido = apellido
		,@tipo_documento_id= tipo_documento_id
		,@nro_documento = nro_documento
	from 
		cliente_prospecto
	where
		id_cliente_prospecto = @id_cliente_prospecto_inserted


	if @nombre <> @nombre_inserted OR @apellido <> @apellido_inserted OR @tipo_documento_id <> @tipo_documento_id_inserted
	OR @nro_documento <> @nro_documento_inserted
	begin
		Declare
		@Estado int
		select @Estado = estado_cliente_id 
		from cliente_prospecto
		where id_cliente_prospecto = @id_cliente_prospecto_inserted

		if @Estado <> 3 
		begin
			RAISERROR ('Solo se pueden cambiar los campos requeridos si el estado es prospecto',16,1)
			
		end
	end 

END