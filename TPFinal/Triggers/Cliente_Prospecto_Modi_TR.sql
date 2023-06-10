if exists (select * from dbo.sysobjects where id= object_id(N'[dbo].[]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Cliente_Prospecto_Modi_TR]
GO

CREATE TRIGGER Cliente_Prospecto_Modi_TR
ON cliente_prospecto
FOR UPDATE
AS
BEGIN 
 
  Declare @id_cliente_prospecto int  
  if (SELECT estado_cliente_ID from cliente_prospecto  WHERE @id_cliente_prospecto = id_cliente_prospecto
  INSERT INTO Employee_Audit_Test  
  VALUES ('New employee with Id = ' + CAST(@Id AS VARCHAR(10)) + ' is added at ' + CAST(Getdate() AS VARCHAR(22)))  
END