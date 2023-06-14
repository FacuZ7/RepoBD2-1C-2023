USE TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id= object_id(N'[dbo].[Cliente_Prospecto_Update_Insert_Identidad_TR]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Cliente_Prospecto_Update_Insert_Identidad_TR]
GO

CREATE TRIGGER Cliente_Prospecto_Update_Insert_Identidad_TR
ON cliente_prospecto
FOR INSERT, UPDATE
AS
BEGIN
	
	
    IF EXISTS (
        SELECT 1
        FROM cliente_prospecto cp
        INNER JOIN inserted i ON cp.id_cliente_prospecto <> i.id_cliente_prospecto
        WHERE cp.tipo_documento_id = i.tipo_documento_id AND cp.nro_documento = i.nro_documento
    )
    BEGIN
       RAISERROR ('Ya existe un cliente prospecto con el mismo tipo de documento o número de documento', 16, 1)
       RETURN
    END
	
	
	
END