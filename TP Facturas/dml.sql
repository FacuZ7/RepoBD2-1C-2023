use TP_Facturas

insert into Pais values('Argentina')
insert into Pais values('Brasil')
insert into Pais values('EEUU'),('Chile'),('Ecuador')

insert into Producto values('Polvora', 1, 100, 10),
('Carbon', 5, 200, 15),
('Metal', 2, 400, 3),
('Oro', 4, 1000, 20),
('Plata', 3, 300, 5)

insert into cliente values('Matias','Sosa',12345678,'07/09/2000', 'sosamatias171@gmail.com')
,('Nicolas','Garcia Vior',12345679,'07/09/2003', 'nicolasgarciavior@gmail.com')
,('Facundo','Zapata',12345677,'07/21/1998', 'facundozapata@gmail.com')
,('Esteban','Lopez Binda',12345676,'07/09/2001', 'estabanbinda@gmail.com')
,('Juan','Perez',12345666,'03/03/2023', 'Juanperez@gmail.com')


insert into telefono values(1154545454,1),(1154545400,2),(1154545765,2),(1154545789,3),(1154544561,4)

insert into venta values(1, '01/05/2023'),(2,'02/04/2023'),(3,'03/03/2023'),(4,'02/03/2023'),(5,'02/02/2023')

insert into detalle values(1,1,2),(1,2,2),(1,4,1),(1,5,1),(2,1,2),(2,2,2),(2,4,1),(3,1,1),(4,2,1),(5,4,2)