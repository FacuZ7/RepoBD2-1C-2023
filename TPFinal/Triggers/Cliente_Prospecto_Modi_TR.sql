if exists (select * from dbo.sysobjects where id= object_id(N'[dbo].[]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Cliente_Prospecto_Modi_TR]
GO
