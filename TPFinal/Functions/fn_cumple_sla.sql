USE TP_FINAL_GRUPO5

if exists (select * from dbo.sysobjects where id= object_id(N'[dbo].[fn_cumple_sla]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_cumple_sla]
GO

CREATE FUNCTION fn_cumple_sla(
	@id_ticket int,
	@fecha_finalizacion datetime
)
RETURNS INT
as
BEGIN
	DECLARE 
	 @estado_pendiente int
	,@fecha datetime
	,@diferencia int
	,@fecha_inicio_pendiente datetime = null
	,@offset_pendiente int = 0
	,@sla int
	,@respuesta int = 0
	
	--set @diferencia = 
	SELECT @sla = tiempo_sla from sla s INNER JOIN ticket t on t.sla_id = s.id_sla WHERE t.id_ticket = @id_ticket
	select @diferencia = DATEDIFF(HOUR,fecha_creacion,@fecha_finalizacion) from ticket where id_ticket = @id_ticket
	
	
	DECLARE CUR CURSOR FOR 
	SELECT estado_a_cambiar, fecha FROM notificacion_cambio_estado
	WHERE ticket_id = @id_ticket 

	OPEN CUR 
	FETCH CUR into @estado_pendiente, @fecha
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		IF @fecha_inicio_pendiente is not null
		begin
			SET @offset_pendiente = @offset_pendiente + DATEDIFF(HOUR, @fecha_inicio_pendiente, @fecha)
			set @fecha_inicio_pendiente = null
		end
		IF @estado_pendiente = 3
		begin
			set @fecha_inicio_pendiente = @fecha
		end
		FETCH NEXT FROM CUR into @estado_pendiente, @fecha
	END
	CLOSE CUR

	DEALLOCATE CUR
	

	
	IF (@diferencia - @offset_pendiente) <= @sla   set @respuesta = 1
	
	return @respuesta
	
END









