CREATE VIEW clientes_con_contacto_vw
as
select 
	cp.nombre + ' ' + cp.apellido as nombre_completo
	,cp.fecha_nac as fecha_nacimiento
	,cp.email
	,s.descripcion_servicio
	,ISNULL(cs.telefono,'Sin Numero') as numero_telefono
	,dom.calle + ' ' + dom.numero as domicilio
	,cs.fecha_inicio
	,es.descripcion_estado
from
	cliente_servicio as cs
	inner join cliente_prospecto as cp on cs.cliente_id = cp.id_cliente_prospecto
	inner join servicio as s on cs.servicio_id = s.id_servicio
	left join domicilio as dom on cs.domicilio_id = dom.id_domicilio
	inner join estado_servicio as es on cs.estado_servicio_id = es.id_estado_servicio

-- drop view clientes_con_contacto_vw

	




	



