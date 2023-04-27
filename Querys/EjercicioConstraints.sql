--------------------------- CREACIÓN DE TABLAS ---------------------------
/*
CREATE TABLE LIBROS (
	isbn int IDENTITY (1,1) CONSTRAINT PK_isbn PRIMARY KEY(isbn) 
	,Titulo varchar(200)
	,Precio money
	,Cantidad int NOT NULL
)

CREATE TABLE AUTORES (
	id_author int IDENTITY (1,1) CONSTRAINT PK_id_author PRIMARY KEY(id_author)
	,email varchar(200) UNIQUE
)

CREATE TABLE LIBROS_AUTORES (
    isbn INT CONSTRAINT FK_isbn_id_author FOREIGN KEY(isbn) REFERENCES LIBROS(isbn)
    ,id_author INT CONSTRAINT FK_id_author_isbn FOREIGN KEY (id_author) REFERENCES AUTORES(id_author)
)
*/
---------------------------------------------------------------------------------
----------------------------- RESTRICCIONES -------------------------------------------

--ALTER TABLE LIBROS 
--ADD CONSTRAINT Titulo_Unique UNIQUE (Titulo)

--ALTER TABLE LIBROS
--ADD CONSTRAINT Precio_NotNull CHECK(precio is not null)

--ALTER TABLE LIBROS
--DROP CONSTRAINT Precio_NotNull

--ALTER TABLE LIBROS
--ADD CONSTRAINT Precio_CheckMayores0 CHECK(Precio > 0)

--ALTER TABLE AUTORES
--ALTER COLUMN email varchar(200) 

--ALTER TABLE LIBROS_AUTORES
--DROP CONSTRAINT FK_isbn_id_author

--ALTER TABLE LIBROS
--DROP CONSTRAINT PK_isbn

--ALTER TABLE AUTORES
--ADD Edad int CONSTRAINT Edad_MayorQue0 CHECK(Edad > 0)
---------------------------------------------------------------------------------
