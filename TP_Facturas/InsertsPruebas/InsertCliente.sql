--exec sp_InsertarCliente 'Pedro','Picapiedra','00000001','02/01/1900','PedroPicapiedra@gmail.com'
--exec sp_InsertarCliente 'Pablo','Amigo','00000002','02/05/1900','PabloAmigo@gmail.com',1132719953



select * from Cliente

select 
t.*
,c.nombre
from Telefono as t
inner join Cliente as C on c.id_cliente = t.cliente_id