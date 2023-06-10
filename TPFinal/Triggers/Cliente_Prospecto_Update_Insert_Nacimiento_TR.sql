if exists (select * from dbo.sysobjects where id= object_id(N'[dbo].[Cliente_Prospecto_Update_Insert_Nacimiento_TR]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Cliente_Prospecto_Update_Insert_Nacimiento_TR]
GO

CREATE TRIGGER Cliente_Prospecto_Update_Insert_Nacimiento_TR
ON cliente_prospecto
FOR UPDATE, INSERT
AS
BEGIN 

  Declare 
	@id_cliente_prospecto int
	,@fecha_nac date

	select 
		@id_cliente_prospecto = id_cliente_prospecto
		,@fecha_nac = fecha_nac
	from 
		inserted

	DECLARE @FechaActual DATE;
	SET @FechaActual = GETDATE();

	DECLARE @Anos INT, @Meses INT, @Dias INT;

	SET @Anos = DATEDIFF(YEAR, @fecha_Nac, @FechaActual);
	SET @Meses = DATEDIFF(MONTH, DATEADD(YEAR, @Anos, @fecha_Nac), @FechaActual);
	SET @Dias = DATEDIFF(DAY, DATEADD(MONTH, @Meses, DATEADD(YEAR, @Anos, @fecha_Nac)), @FechaActual);


	if @Anos = 18
	begin
		if @Meses >= 0 
		begin --ya paso tu cumpleaños
			if @Meses = 0 
			begin -- es el mes de tu cumpleaños
				if @Dias < 0 
				begin -- es el día de tu cumpleaños
					print 'No es mayor a 18 años'
					rollback
				end
			end
		end
	end
	if @Anos < 18
	begin
		print 'No es mayor a 18 años'
		rollback
	end
END