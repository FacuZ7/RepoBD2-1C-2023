if exists (select * from dbo.sysobjects where id= object_id(N'[dbo].[chk_Mayor_De_Edad]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[chk_Mayor_De_Edad]
GO

CREATE FUNCTION chk_Mayor_De_Edad(
	@fecha_Nac date
)
RETURNS INT
as
begin 
	DECLARE @FechaActual DATE;
	SET @FechaActual = GETDATE();

	DECLARE @Anos INT, @Meses INT, @Dias INT;

	SET @Anos = DATEDIFF(YEAR, @fecha_Nac, @FechaActual);
	SET @Meses = DATEDIFF(MONTH, DATEADD(YEAR, @Anos, @fecha_Nac), @FechaActual);
	SET @Dias = DATEDIFF(DAY, DATEADD(MONTH, @Meses, DATEADD(YEAR, @Anos, @fecha_Nac)), @FechaActual);

	if @Meses >= 0 begin --ya paso tu cumpleaños
		if @Meses = 0 begin -- es el mes de tu cumpleaños
			if @Dias >= 0 begin -- es el día de tu cumpleaños
				return 1
			end
		end
		else begin
			return 1 
		end
	end

	return 0
	
end
