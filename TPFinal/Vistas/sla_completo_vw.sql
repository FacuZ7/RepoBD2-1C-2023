USE TP_FINAL_GRUPO5
GO

CREATE VIEW sla_completo_vw
as
select
	ti.descripcion_tipologia
	,ISNULL(se.descripcion_servicio,'Sin Servicio') as descripcion_servicio 
	,sl.tiempo_sla
from
	sla as sl
	inner join tipologia as ti on sl.tipologia_id = ti.id_tipologia
	left join servicio as se on sl.servicio_id = se.id_servicio
