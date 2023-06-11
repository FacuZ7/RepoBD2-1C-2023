USE TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id= object_id(N'[dbo].[chk_Cambio_Estado_Ticket]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[chk_Cambio_Estado_Ticket]
GO

CREATE FUNCTION chk_Cambio_Estado_Ticket(
	@estado_anterior_id int,
	@estado_ticket_id int
)
RETURNS INT
as
begin 
	DECLARE
	@resultado int = 2
	
	IF @estado_anterior_id = 2
	BEGIN
		IF @estado_ticket_id = 3 OR @estado_ticket_id = 4 OR @estado_ticket_id = 5 
		BEGIN
			set @resultado = 1
		END
		ELSE
		BEGIN
			set @resultado = 0
		END
	END
	ELSE IF @estado_anterior_id = 1
	BEGIN
		IF @estado_ticket_id = 2
		BEGIN
			set @resultado = 1	
		END
		ELSE
		BEGIN
			set @resultado = 0		
		END
	END
	ELSE
	BEGIN
		IF @estado_ticket_id = 2
		BEGIN
			set @resultado = 1
		END
		ELSE
		BEGIN
			set @resultado = 0
		END
	END
	
	return @resultado
end