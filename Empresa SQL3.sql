CREATE TABLE Articulo(
	[idArticulo] [int] NOT NULL IDENTITY,
	[NombreArticulo] [varchar](50) NULL,
	[Marca] [varchar](50) NULL,
	CONSTRAINT [PK_Articulo] PRIMARY KEY (idArticulo)
)