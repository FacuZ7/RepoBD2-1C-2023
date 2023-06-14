USE TP_FINAL_GRUPO5
GO

CREATE VIEW tickets_pendientes_con_dias_transcurridos_vw
AS
select
	ti.id_ticket
	,em.nombre + ' ' + em.apellido as empleado_nombre_completo
	,et.descripcion_estado
	,cp.nombre + ' ' + cp.apellido as cliente_nombre_completo
	,tlg.descripcion_tipologia
	,se.descripcion_servicio
	,ti.fecha_creacion
	,DATEDIFF(day,ti.fecha_creacion,getdate()) as dias_transcurridos
	,CASE WHEN dbo.fn_cumple_sla(ti.id_ticket,GETDATE()) = 0 THEN 'NO' ELSE 'SI' END as cumple_sla
from
	ticket as ti
	left join empleado as em on ti.empleado_id = em.id_empleado
	left join cliente_prospecto as cp on ti.cliente_prospecto_id = cp.id_cliente_prospecto
	left join tipologia as tlg on ti.tipologia_id = tlg.id_tipologia
	left join servicio as se on ti.servicio_id = se.id_servicio
	left join estado_ticket as et on ti.estado_ticket_id = et.id_estado_ticket
	left join sla as sl on ti.sla_id = sl.id_sla
where
	ti.estado_ticket_id NOT IN (4,5) --resuelto o cerrado

	
-- drop view tickets_pendientes_con_dias_transcurridos_vw 
-- descomentar y tirar la vista para hacer cambios
	

