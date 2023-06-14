USE TP_FINAL_GRUPO5
GO
DROP VIEW vw_tickets_abiertos
GO
CREATE VIEW vw_tickets_abiertos
AS
SELECT 
ti.id_ticket
	,em.nombre + ' ' + em.apellido as empleado_nombre_completo
	,et.descripcion_estado
	,cp.nombre + ' ' + cp.apellido as cliente_nombre_completo
	,tlg.descripcion_tipologia
	,se.descripcion_servicio
	,ti.fecha_creacion
	,sl.tiempo_sla 
	,DATEDIFF(day,ti.fecha_creacion,getdate()) as dias_transcurridos
	,CASE WHEN dbo.fn_cumple_sla(ti.id_ticket,GETDATE()) = 0 THEN 'NO' ELSE 'SI' END as cumple_sla
from
	ticket as ti
	inner join empleado as em on ti.empleado_id = em.id_empleado
	inner join cliente_prospecto as cp on ti.cliente_prospecto_id = cp.id_cliente_prospecto
	inner join tipologia as tlg on ti.tipologia_id = tlg.id_tipologia
	inner join servicio as se on ti.servicio_id = se.id_servicio
	inner join estado_ticket as et on ti.estado_ticket_id = et.id_estado_ticket
	inner join sla as sl on ti.sla_id = sl.id_sla
	inner join servicio as se2 on sl.servicio_id = se2.id_servicio
where
	ti.estado_ticket_id NOT IN (4,5)
GO
	SELECT * FROM vw_tickets_abiertos



