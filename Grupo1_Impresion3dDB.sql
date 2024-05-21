/*
		09/mayo/2024
		Impresion 3D
		Gerson Jonathan Berrio Martinez
		Roberto Edenilson Mangandi Escobar
		Carlos Antonio Martinez Cortez
*/

--Creacion de la base de Datos

CREATE DATABASE IMPRESION3D;  
GO

USE IMPRESION3D;
GO
-- Tabla para almacenar los géneros
CREATE TABLE Genero (
    IdGenero INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Sexo NVARCHAR(100)
);

-- Tabla para almacenar los cargos o roles de empleados
CREATE TABLE Cargo (
    IdCargo INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    NombreCargo NVARCHAR(100),
    Descripcion NVARCHAR(100)
);

-- Tabla para almacenar información de los proveedores
CREATE TABLE Proveedor (
    IdProveedor INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Nombre NVARCHAR(100),
    Correo NVARCHAR(100),
    Direccion NVARCHAR(100),
    Telefono NVARCHAR(100)
);

-- Tabla para almacenar las categorías de productos
CREATE TABLE Categoria (
    IdCategoria INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Nombre NVARCHAR(100)
);

-- Tabla para almacenar información de los productos
CREATE TABLE Producto (
    IdProducto INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Nombre NVARCHAR(100),
    Codigo NVARCHAR(100),
    Precio MONEY,
    Costo MONEY,
    Descripcion NVARCHAR(100),
    PrecioCompra MONEY,
    PrecioVenta MONEY,
    IdProveedor INT,
    IdCategoria INT,
    FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor),
    FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
);

-- Tabla para almacenar información de clientes
CREATE TABLE Cliente (
    IdCliente INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Nombre NVARCHAR(100),
    Apellido NVARCHAR(100),
    Correo NVARCHAR(100),
    Telefono NVARCHAR(100),
    IdGenero INT,
    FOREIGN KEY (IdGenero) REFERENCES Genero(IdGenero)
);

-- Tabla para almacenar información de empleados
CREATE TABLE Empleado (
    IdEmpleado INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Nombre NVARCHAR(100),
    Apellido NVARCHAR(100),
    Correo NVARCHAR(100),
    Telefono NVARCHAR(100),
    DUI NVARCHAR(100),
    IdCargo INT,
    IdGenero INT,
    FOREIGN KEY (IdGenero) REFERENCES Genero(IdGenero),
    FOREIGN KEY (IdCargo) REFERENCES Cargo(IdCargo)
);

-- Tabla para almacenar los estados de los registros
CREATE TABLE Estado (
    IdEstado INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    TipoEstado NVARCHAR(100)
);

-- Tabla para almacenar los roles de usuarios
CREATE TABLE Rol (
    IdRol INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    NombreRol NVARCHAR(100),
    Descripcion NVARCHAR(100)
);

-- Tabla para almacenar información de usuarios
CREATE TABLE Usuario (
    IdUsuario INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Nombre NVARCHAR(100),
    IdEmpleado INT,
    Password NVARCHAR(100),
    IdRol INT,
    IdEstado INT,
    FOREIGN KEY (IdEstado) REFERENCES Estado(IdEstado),
    FOREIGN KEY (IdRol) REFERENCES Rol(IdRol),
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado(IdEmpleado)
);

-- Tabla para almacenar tipos de pago
CREATE TABLE TiposDePago (
    IdPago INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Tipo NVARCHAR(50)
);

-- Tabla para almacenar información de pedidos de clientes
CREATE TABLE Pedido (
    IdPedidoCliente INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    IdCliente INT,
    FechaPedido DATETIME,
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
);

-- Tabla para almacenar detalles de los pedidos de clientes
CREATE TABLE DetallePedido (
    IdDetallePedidoCliente INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    IdPedidoCliente INT,
    IdProducto INT,
    Cantidad INT,
    PrecioUnitario MONEY,
    FOREIGN KEY (IdPedidoCliente) REFERENCES Pedido(IdPedidoCliente),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- Tabla para almacenar historial de pedidos
CREATE TABLE HistorialPedido (
    IdHistorialPedido INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    IdCliente INT,
    FechaPedido DATETIME,
    EstadoPedido NVARCHAR(100),
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
);

-- Tabla para almacenar información de ventas
CREATE TABLE Venta (
    IdVenta INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    IdEmpleado INT,
    IdCliente INT,
    IdProducto INT,
    IdPago INT, -- Referencia a la tabla TiposDePago
    Fecha DATE,
    Total MONEY,
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto),
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado(IdEmpleado),
    FOREIGN KEY (IdPago) REFERENCES TiposDePago(IdPago)
);

-- Tabla para almacenar información de inventario
CREATE TABLE Inventario (
    IdInventario INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    IdProducto INT,
    Cantidad NVARCHAR(100),
    IdCategoria INT,
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto),
    FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
);

-- Tabla para almacenar información de compras
CREATE TABLE Compra (
    IdCompra INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Fecha DATE,
    Total DECIMAL,
    IdProveedor INT,
    FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
);

-- Tabla para almacenar detalles de compras
CREATE TABLE DetalleCompra (
    IdDetCompra INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    SubTotal DECIMAL,
    IdProducto INT,
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- Tabla para almacenar arqueo de caja
CREATE TABLE Arqueo (
    ArqueoId INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Fecha DATE,
    IdUsuario INT,
    FondoInicial DECIMAL(18, 2),
    FondoCierre DECIMAL(18, 2),
    Billete_100 INT,
    Billete_50 INT,
    Billete_20 INT,
    Billete_10 INT,
    Billete_5 INT,
    Billete_1 INT,
    Moneda_1 INT,
    Moneda_25cent INT,
    Moneda_10cent INT,
    Moneda_5cent INT,
    Moneda_1cent INT,
    TotalFondo DECIMAL(18, 2),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);


-------------------------------------------------------------------------------------------------------------
-- Procedimiento almacenado para insertar un nuevo género en la tabla Genero
CREATE PROCEDURE InsertarGenero
    @Sexo NVARCHAR(100)
AS
BEGIN
    -- Inserta un nuevo registro en la tabla Genero con el valor proporcionado para el género
    INSERT INTO Genero (Sexo)
    VALUES (@Sexo);
END;


-- Llamadas al procedimiento InsertarGenero para insertar géneros específicos
EXEC InsertarGenero @Sexo = 'Femenino';
EXEC InsertarGenero @Sexo = 'Masculino';
EXEC InsertarGenero @Sexo = 'Indefinido';
EXEC InsertarGenero @Sexo = 'No Binario';
EXEC InsertarGenero @Sexo = 'Fluido';
EXEC InsertarGenero @Sexo = 'ModClasista';


-- Procedimiento almacenado para seleccionar todos los registros de la tabla Genero
CREATE PROCEDURE SelectAllGenero
AS
BEGIN
    -- Selecciona todos los registros de la tabla Genero
    SELECT * FROM Genero;
END;

-- Ejecuta el procedimiento almacenado SelectAllGenero para obtener todos los registros de la tabla Genero
EXEC SelectAllGenero;




-------------------------------------------------------------------------------------------------------------




-- Procedimiento almacenado para insertar un nuevo cargo en la tabla Cargo
CREATE PROCEDURE InsertarCargo
    @NombreCargo NVARCHAR(100),
    @Descripcion NVARCHAR(100)
AS
BEGIN
    -- Inserta un nuevo registro en la tabla Cargo con los valores proporcionados
    INSERT INTO Cargo (NombreCargo, Descripcion)
    VALUES (@NombreCargo, @Descripcion);
END;


-- Procedimiento almacenado para actualizar un cargo en la tabla Cargo
CREATE PROCEDURE ActualizarCargo
    @IdCargo INT,
    @NuevoNombreCargo NVARCHAR(100),
    @NuevaDescripcion NVARCHAR(100)
AS
BEGIN
    -- Actualiza el nombre y la descripción de un cargo en la tabla Cargo
    UPDATE Cargo
    SET NombreCargo = @NuevoNombreCargo,
        Descripcion = @NuevaDescripcion
    WHERE IdCargo = @IdCargo;
END;


-- Procedimiento almacenado para eliminar un cargo de la tabla Cargo
CREATE PROCEDURE EliminarCargo
    @IdCargo INT
AS
BEGIN
    -- Elimina un registro de la tabla Cargo según el ID proporcionado
    DELETE FROM Cargo
    WHERE IdCargo = @IdCargo;
END;


-- Llamada al procedimiento InsertarCargo para agregar un cargo específico
EXEC InsertarCargo
    @NombreCargo = 'Gerente',
    @Descripcion = 'Encargado de la supervisión y toma de decisiones en la empresa.';

-- Llamadas adicionales al procedimiento InsertarCargo para agregar más cargos
EXEC InsertarCargo @NombreCargo = 'Asistente Administrativo', @Descripcion = 'Apoyo en tareas administrativas';
EXEC InsertarCargo @NombreCargo = 'Ingeniero de Software', @Descripcion = 'Desarrollador de software';
EXEC InsertarCargo @NombreCargo = 'Técnico de Mantenimiento', @Descripcion = 'Encargado del mantenimiento de equipos';
EXEC InsertarCargo @NombreCargo = 'Analista de Datos', @Descripcion = 'Encargado del análisis de datos';
EXEC InsertarCargo @NombreCargo = 'Diseñador Gráfico', @Descripcion = 'Crea diseños gráficos para productos';
EXEC InsertarCargo @NombreCargo = 'Especialista en Marketing', @Descripcion = 'Desarrolla estrategias de marketing';
EXEC InsertarCargo @NombreCargo = 'Recepcionista', @Descripcion = 'Atiende llamadas y recibe visitantes';
EXEC InsertarCargo @NombreCargo = 'Contador', @Descripcion = 'Encargado de la contabilidad de la empresa';
EXEC InsertarCargo @NombreCargo = 'Analista de Calidad', @Descripcion = 'Realiza controles de calidad de productos';

-- Llamada al procedimiento ActualizarCargo para cambiar un cargo existente
EXEC ActualizarCargo @IdCargo = 3, 
                     @NuevoNombreCargo = 'Nuevo nombre de cargo', 
                     @NuevaDescripcion = 'Nueva descripción de cargo';

-- Llamada al procedimiento EliminarCargo para eliminar un cargo específico
EXEC EliminarCargo @IdCargo = 4;


-------------------------------------------------------------------------------------------------
-- Procedimiento almacenado para insertar un nuevo proveedor en la tabla Proveedor
CREATE PROCEDURE InsertProveedor
    @Nombre NVARCHAR(100),
    @Correo NVARCHAR(100),
    @Direccion NVARCHAR(100),
    @Telefono NVARCHAR(100)
AS
BEGIN
    -- Inserta un nuevo registro en la tabla Proveedor con los valores proporcionados
    INSERT INTO Proveedor (Nombre, Correo, Direccion, Telefono)
    VALUES (@Nombre, @Correo, @Direccion, @Telefono);
END;

-- Llamadas al procedimiento InsertProveedor para agregar proveedores específicos
EXEC InsertProveedor
    @Nombre = '3D Universe',
    @Correo = 'info@3duniverse.org',
    @Direccion = '123 Main Street',
    @Telefono = '555-123-4567';

EXEC InsertProveedor
    @Nombre = 'Printed Solid',
    @Correo = 'sales@printedsolid.com',
    @Direccion = '456 Elm Street',
    @Telefono = '555-234-5678';

EXEC InsertProveedor
    @Nombre = 'MatterHackers',
    @Correo = 'support@matterhackers.com',
    @Direccion = '789 Oak Avenue',
    @Telefono = '555-345-6789';

EXEC InsertProveedor
    @Nombre = 'Ultimaker',
    @Correo = 'contact@ultimaker.com',
    @Direccion = '101 Pine Road',
    @Telefono = '555-456-7890';

EXEC InsertProveedor
    @Nombre = 'LulzBot',
    @Correo = 'info@lulzbot.com',
    @Direccion = '210 Cedar Lane',
    @Telefono = '555-567-8901';

EXEC InsertProveedor
    @Nombre = 'Prusa Research',
    @Correo = 'support@prusa3d.com',
    @Direccion = '333 Maple Street',
    @Telefono = '555-678-9012';

EXEC InsertProveedor
    @Nombre = 'Formlabs',
    @Correo = 'sales@formlabs.com',
    @Direccion = '444 Oakwood Drive',
    @Telefono = '555-789-0123';

EXEC InsertProveedor
    @Nombre = 'Sindoh',
    @Correo = 'info@sindoh.com',
    @Direccion = '555 Pine Avenue',
    @Telefono = '555-890-1234';

EXEC InsertProveedor
    @Nombre = 'Raise3D',
    @Correo = 'support@raise3d.com',
    @Direccion = '777 Elmwood Street',
    @Telefono = '555-901-2345';

EXEC InsertProveedor
    @Nombre = 'FlashForge',
    @Correo = 'info@flashforge.com',
    @Direccion = '888 Cedar Avenue',
    @Telefono = '555-012-3456';

-- Procedimiento almacenado para actualizar un proveedor en la tabla Proveedor
CREATE PROCEDURE ActualizarProveedor
    @IdProveedor INT,
    @NuevoNombre NVARCHAR(100),
    @NuevoCorreo NVARCHAR(100),
    @NuevaDireccion NVARCHAR(100),
    @NuevoTelefono NVARCHAR(100)
AS
BEGIN
    -- Actualiza los datos de un proveedor en la tabla Proveedor según el ID proporcionado
    UPDATE Proveedor
    SET Nombre = @NuevoNombre,
        Correo = @NuevoCorreo,
        Direccion = @NuevaDireccion,
        Telefono = @NuevoTelefono
    WHERE IdProveedor = @IdProveedor;
END;

-- Llamada al procedimiento ActualizarProveedor para cambiar un proveedor existente
EXEC ActualizarProveedor @IdProveedor = 3, 
                         @NuevoNombre = 'Nuevo nombre', 
                         @NuevoCorreo = 'nuevo@correo.com', 
                         @NuevaDireccion = 'Nueva dirección', 
                         @NuevoTelefono = '123456789';

-- Procedimiento almacenado para seleccionar todos los registros de la tabla Proveedor
CREATE PROCEDURE SelectAllProveedor
AS
BEGIN
    -- Selecciona todos los registros de la tabla Proveedor
    SELECT * FROM Proveedor;
END;

-- Llamada al procedimiento SelectAllProveedor para obtener todos los proveedores
EXEC SelectAllProveedor;
select * from Proveedor

-- Procedimiento almacenado para eliminar un proveedor de la tabla Proveedor
CREATE PROCEDURE EliminarProveedor
    @IdProveedor INT
AS
BEGIN
    -- Elimina un proveedor de la tabla Proveedor según el ID proporcionado
    DELETE FROM Proveedor
    WHERE IdProveedor = @IdProveedor;
END;

-- Llamada al procedimiento EliminarProveedor para eliminar un proveedor específico
EXEC EliminarProveedor @IdProveedor = 4;




-------------------------------------------------------------------------------------------------------------

-- Procedimiento almacenado para insertar una nueva categoría en la tabla Categoria
CREATE PROCEDURE InsertarCategoria
    @Nombre NVARCHAR(100)
AS
BEGIN
    -- Inserta un nuevo registro en la tabla Categoria con el nombre proporcionado
    INSERT INTO Categoria(Nombre)
    VALUES (@Nombre);
END;

-- Procedimiento almacenado para actualizar una categoría en la tabla Categoria
CREATE PROCEDURE ActualizarCategoria
    @IdCategoria INT,
    @Nombre NVARCHAR(100)
AS
BEGIN
    -- Actualiza el nombre de una categoría en la tabla Categoria según el ID proporcionado
    UPDATE Categoria
    SET Nombre = @Nombre
    WHERE IdCategoria = @IdCategoria;
END;

-- Llamada al procedimiento SelectAllCategoria para mostrar todas las categorías
EXEC SelectAllCategoria;

-- Procedimiento almacenado para eliminar una categoría de la tabla Categoria
CREATE PROCEDURE EliminarCategoria
    @IdCategoria INT
AS
BEGIN
    -- Elimina una categoría de la tabla Categoria según el ID proporcionado
    DELETE FROM Categoria
    WHERE IdCategoria = @IdCategoria;
END;

-- Llamada al procedimiento SelectAllCategoria para mostrar todas las categorías
EXEC SelectAllCategoria;

-- Llamada al procedimiento ActualizarCategoria para cambiar el nombre de una categoría existente
EXEC ActualizarCategoria @IdCategoria = 5, @Nombre = 'Juegos Modelados';

-- Llamada al procedimiento EliminarCategoria para eliminar una categoría específica
EXEC EliminarCategoria @IdCategoria = 4;

-- Llamadas al procedimiento InsertarCategoria para agregar nuevas categorías
EXEC InsertarCategoria @Nombre = 'Prototipos y Modelos';
EXEC InsertarCategoria @Nombre = 'Accesorios y Adornos';
EXEC InsertarCategoria @Nombre = 'Repuestos y Piezas';
EXEC InsertarCategoria @Nombre = 'Arte y Diseño';
EXEC InsertarCategoria @Nombre = 'Juegos y Juguetes';
EXEC InsertarCategoria @Nombre = 'Tecnología y Electrónica';
EXEC InsertarCategoria @Nombre = 'Herramientas y Útiles';
EXEC InsertarCategoria @Nombre = 'Arquitectura y Construcción';
EXEC InsertarCategoria @Nombre = 'Moda y Accesorios Personales';
EXEC InsertarCategoria @Nombre = 'Regalos y Detalles';

-- Llamada al procedimiento SelectAllCategoria para mostrar todas las categorías después de la inserción
EXEC SelectAllCategoria;


-------------------------------------------------------------------------------------------------------------
-- Creación de una vista que muestra información completa de productos, incluyendo nombre del proveedor y categoría
CREATE VIEW VistaProductoCompleto AS
SELECT 
    P.IdProducto,
    P.Nombre AS NombreProducto,
    P.Codigo,
    P.Precio,
    P.Costo,
    P.Descripcion,
    P.PrecioCompra,
    P.PrecioVenta,
    PR.Nombre AS NombreProveedor,
    C.Nombre AS NombreCategoria
FROM 
    Producto P
INNER JOIN 
    Proveedor PR ON P.IdProveedor = PR.IdProveedor
INNER JOIN 
    Categoria C ON P.IdCategoria = C.IdCategoria;

-- Seleccionar todos los datos de la vista VistaProductoCompleto
SELECT * FROM VistaProductoCompleto;

-- Creación de una vista que muestra información filtrada de productos, según un código deseado y un precio máximo
CREATE VIEW VistaProductoFiltrado AS
SELECT 
    P.IdProducto,
    P.Nombre AS NombreProducto,
    P.Codigo,
    P.Precio,
    P.Costo,
    P.Descripcion,
    P.PrecioCompra,
    P.PrecioVenta,
    PR.Nombre AS NombreProveedor,
    C.Nombre AS NombreCategoria
FROM 
    Producto P
INNER JOIN 
    Proveedor PR ON P.IdProveedor = PR.IdProveedor
INNER JOIN 
    Categoria C ON P.IdCategoria = C.IdCategoria
WHERE
    P.Codigo = 'código_deseado' -- Aquí colocas el código deseado para filtrar
    AND P.Precio <= Precio; -- Aquí colocas el precio máximo permitido

-- Seleccionar todos los datos de la vista VistaProductoFiltrado
SELECT * FROM VistaProductoFiltrado;

-- Seleccionar el ID del cliente, la fecha, el producto y el total de los pedidos para el cliente con ID 10101
SELECT IdCliente, fecha, Producto, cantidad * precio AS total FROM pedidos WHERE idcliente = 10101;

-- Seleccionar todos los datos de la tabla Producto
SELECT * FROM Producto;

-- Insertar un nuevo producto en la tabla Producto
INSERT INTO Producto (Nombre, Precio, IdCategoria) VALUES ('Nuevo Producto', 30, 1);

-- Actualizar el precio del producto con ID 1 en la tabla Producto
UPDATE Producto SET Precio = 40 WHERE IdProducto = 1;

-- Eliminar el producto con ID 2 de la tabla Producto
DELETE FROM Producto WHERE IdProducto = 2;

-- Seleccionar los primeros 5 productos ordenados por precio de manera descendente
SELECT TOP 5 * FROM Producto ORDER BY Precio DESC;

-- Seleccionar productos cuyo nombre empiece con 'A'
SELECT * FROM Producto WHERE Nombre LIKE 'A%';

-- Seleccionar productos cuyo ID de categoría sea 1 o 2
SELECT * FROM Producto WHERE IdCategoria IN (1, 2);

-- Seleccionar productos cuyo precio esté entre 10 y 20
SELECT * FROM Producto WHERE Precio BETWEEN 10 AND 20;

-- Seleccionar el nombre del producto y su precio con un alias
SELECT Nombre AS Producto, Precio AS Precio_Unitario FROM Producto;

-- Crear una vista que muestre el nombre y el precio de los productos
CREATE VIEW VistaProductos AS
SELECT Nombre, Precio FROM Producto;

-- Seleccionar productos añadidos en la última semana
SELECT * FROM Producto WHERE FechaRegistro >= DATEADD(WEEK, -1, GETDATE());

-- Seleccionar productos cuyo proveedor sea desconocido (IDProveedor nulo)
SELECT * FROM Producto WHERE IdProveedor IS NULL;

-- Contar la cantidad de productos sin proveedor conocido
SELECT COUNT(*) AS Productos_Sin_Proveedor FROM Producto WHERE IdProveedor IS NULL;

-- Seleccionar productos cuya descripción contenga la palabra 'texto'
SELECT * FROM Producto WHERE Descripcion LIKE '%Filamento%';

-- Seleccionar productos cuyo precio esté entre 20 y 50
SELECT * FROM Producto WHERE Precio BETWEEN 20 AND 50;

-- Esta consulta selecciona el nombre y precio de los productos, junto con el nombre de la categoría a la que pertenecen
SELECT Producto.Nombre, Producto.Precio, Categoria.Nombre AS Categoria
FROM Producto
INNER JOIN Categoria ON Producto.IdCategoria = Categoria.IdCategoria;

--Esta consulta selecciona todos los campos de la tabla de productos y de inventario donde el nombre del producto comienza con 'F' y la cantidad en inventario es mayor que 50.
SELECT * FROM Producto p
JOIN Inventario i ON p.IdProducto = i.IdProducto
WHERE p.Nombre LIKE 'F%' AND i.Cantidad > 50;



--Esta consulta cuenta el número total de productos en cada categoría. Agrupa los productos por ID de categoría y cuenta cuántos productos hay en cada una.
SELECT IdCategoria, COUNT(*) AS Total_Productos
FROM Producto
GROUP BY IdCategoria;

-- Esta consulta selecciona el nombre y teléfono de los empleados, junto con el nombre del cargo que ocupan. Utiliza una tabla de Empleado y otra de Cargo, relacionadas por el ID de cargo en la tabla de empleados.
SELECT Empleado.Nombre, Empleado.Telefono, Cargo.NombreCargo AS Cargo
FROM Empleado 
INNER JOIN Cargo ON Empleado.IdCargo=Cargo.IdCargo

--Esta consulta selecciona el nombre del empleado, el nombre del cargo que ocupa y su género. Utiliza las tablas de Empleado, Cargo y Género, relacionadas por los IDs de cargo y género en la tabla de empleados.
SELECT e.Nombre AS 'Nombre Empleado', c.NombreCargo AS 'Cargo', g.Sexo AS 'Género'
FROM Empleado e, Cargo c, Genero g
WHERE e.IdCargo = c.IdCargo AND e.IdGenero = g.IdGenero
AND e.Nombre IS NOT NULL AND c.NombreCargo IS NOT NULL AND g.Sexo IS NOT NULL;

SELECT e.Nombre AS 'Nombre Empleado', c.NombreCargo AS 'Cargo'
FROM Empleado e
INNER JOIN Cargo c ON e.IdCargo = c.IdCargo
WHERE (e.Nombre LIKE 'L%' AND c.NombreCargo NOT LIKE 'A%') OR (c.NombreCargo LIKE 'L%' AND e.Nombre NOT LIKE 'A%')
ORDER BY e.Nombre DESC, c.NombreCargo DESC;


-- Procedimiento almacenado para insertar un producto en la tabla Producto e Inventario automáticamente
CREATE PROCEDURE InsertarProductoEInventario
    @Nombre NVARCHAR(100),
    @Precio MONEY,
    @Costo MONEY,
    @Descripcion NVARCHAR(100),
    @PrecioCompra MONEY,
    @PrecioVenta MONEY,
    @IdProveedor INT,
    @IdCategoria INT,
    @Cantidad INT  -- Nueva cantidad en el inventario
AS
BEGIN
   DECLARE @Codigo NVARCHAR(100);
    DECLARE @IdProducto INT;

    -- Obtener el último número de producto para las tres primeras letras del nombre
    DECLARE @NumeroProducto INT;
    SET @NumeroProducto = ISNULL((SELECT MAX(SUBSTRING(Codigo, 4, 6)) FROM Producto WHERE LEFT(Nombre, 3) = LEFT(@Nombre, 3)), 0) + 1;

    -- Generar el código del producto
    SET @Codigo = LEFT(@Nombre, 3) + RIGHT('000000' + CAST(@NumeroProducto AS NVARCHAR(10)), 6);

    -- Insertar el nuevo producto
    INSERT INTO Producto (Nombre, Codigo, Precio, Costo, Descripcion, PrecioCompra, PrecioVenta, IdProveedor, IdCategoria)
    VALUES (@Nombre, @Codigo, @Precio, @Costo, @Descripcion, @PrecioCompra, @PrecioVenta, @IdProveedor, @IdCategoria);

    -- Obtener el ID del producto recién insertado
    SET @IdProducto = SCOPE_IDENTITY();

    -- Insertar el nuevo registro en el inventario
    INSERT INTO Inventario (IdProducto, Cantidad, IdCategoria)
    VALUES (@IdProducto, @Cantidad, @IdCategoria);
END;

-- Procedimiento almacenado para actualizar un producto en la tabla Producto e Inventario
CREATE PROCEDURE ActualizarProductoEInventario
    @IdProducto INT,
    @Nombre NVARCHAR(100),
    @Precio MONEY,
    @Costo MONEY,
    @Descripcion NVARCHAR(100),
    @PrecioCompra MONEY,
    @PrecioVenta MONEY,
    @IdProveedor INT,
    @IdCategoria INT,
    @Cantidad INT  -- Nueva cantidad en el inventario
AS
BEGIN
   -- Actualizar el producto
    UPDATE Producto
    SET Nombre = @Nombre,
        Precio = @Precio,
        Costo = @Costo,
        Descripcion = @Descripcion,
        PrecioCompra = @PrecioCompra,
        PrecioVenta = @PrecioVenta,
        IdProveedor = @IdProveedor,
        IdCategoria = @IdCategoria
    WHERE IdProducto = @IdProducto;

    -- Actualizar la cantidad en el inventario
    UPDATE Inventario
    SET Cantidad = @Cantidad,
        IdCategoria = @IdCategoria
    WHERE IdProducto = @IdProducto;
END;

-- Ejecutar el procedimiento almacenado para actualizar un producto y su inventario
EXEC ActualizarProductoEInventario @IdProducto = 5, @Nombre = 'Filamento 2.9', @Precio = 99.99, @Costo = 50.00, @Descripcion = 'Nueva descripción del producto', @PrecioCompra = 45.00, @PrecioVenta = 120.00, @IdProveedor = 7, @IdCategoria = 2, @Cantidad = 75;

-- Procedimiento almacenado para eliminar un producto y su inventario
CREATE PROCEDURE EliminarProductoEInventario
    @IdProducto INT
AS
BEGIN
   DECLARE @Codigo NVARCHAR(100);
    DECLARE @IdProducto INT;

    -- Obtener el último número de producto para las tres primeras letras del nombre
    DECLARE @NumeroProducto INT;
    SET @NumeroProducto = ISNULL((SELECT MAX(SUBSTRING(Codigo, 4, 6)) FROM Producto WHERE LEFT(Nombre, 3) = LEFT(@Nombre, 3)), 0) + 1;

    -- Generar el código del producto
    SET @Codigo = LEFT(@Nombre, 3) + RIGHT('000000' + CAST(@NumeroProducto AS NVARCHAR(10)), 6);

    -- Insertar el nuevo producto
    INSERT INTO Producto (Nombre, Codigo, Precio, Costo, Descripcion, PrecioCompra, PrecioVenta, IdProveedor, IdCategoria)
    VALUES (@Nombre, @Codigo, @Precio, @Costo, @Descripcion, @PrecioCompra, @PrecioVenta, @IdProveedor, @IdCategoria);

    -- Obtener el ID del producto recién insertado
    SET @IdProducto = SCOPE_IDENTITY();

    -- Insertar el nuevo registro en el inventario
    INSERT INTO Inventario (IdProducto, Cantidad, IdCategoria)
    VALUES (@IdProducto, @Cantidad, @IdCategoria);
END;

-- Ejecutar el procedimiento almacenado para eliminar un producto y su inventario
EXEC EliminarProductoEInventario @IdProducto = 5; -- Cambia 5 por el ID del producto que deseas eliminar



-------------------------------------------------------------------------------------------------------------

-- Procedimiento para insertar un empleado en la base de datos
CREATE PROCEDURE InsertarEmpleado
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @Correo NVARCHAR(100),
    @Telefono NVARCHAR(100),
    @DUI NVARCHAR(100),
    @IdCargo INT,
    @IdGenero INT
AS
BEGIN
    INSERT INTO Empleado (Nombre, Apellido, Correo, Telefono, DUI, IdCargo, IdGenero)
    VALUES (@Nombre, @Apellido, @Correo, @Telefono, @DUI, @IdCargo, @IdGenero);
END;

-- Insertar empleados en la base de datos
EXEC InsertarEmpleado @Nombre = 'María', @Apellido = 'López', @Correo = 'maria@example.com', @Telefono = '1234567890', @DUI = '12345678-9', @IdCargo = 1, @IdGenero = 1;
EXEC InsertarEmpleado @Nombre = 'Carlos', @Apellido = 'González', @Correo = 'carlos@example.com', @Telefono = '0987654321', @DUI = '98765432-1', @IdCargo = 2, @IdGenero = 2;
EXEC InsertarEmpleado @Nombre = 'Ana', @Apellido = 'Martínez', @Correo = 'ana@example.com', @Telefono = '1357924680', @DUI = '13579246-8', @IdCargo = 3, @IdGenero = 1;
EXEC InsertarEmpleado @Nombre = 'Pedro', @Apellido = 'Rodríguez', @Correo = 'pedro@example.com', @Telefono = '2468013579', @DUI = '24680135-7', @IdCargo = 4, @IdGenero = 2;
EXEC InsertarEmpleado @Nombre = 'Laura', @Apellido = 'Hernández', @Correo = 'laura@example.com', @Telefono = '9876543210', @DUI = '98765432-1', @IdCargo = 5, @IdGenero = 1;
EXEC InsertarEmpleado @Nombre = 'Juan', @Apellido = 'Pérez', @Correo = 'juan@example.com', @Telefono = '0123456789', @DUI = '01234567-8', @IdCargo = 6, @IdGenero = 2;
EXEC InsertarEmpleado @Nombre = 'Sofía', @Apellido = 'Díaz', @Correo = 'sofia@example.com', @Telefono = '9876543210', @DUI = '98765432-1', @IdCargo = 7, @IdGenero = 1;
EXEC InsertarEmpleado @Nombre = 'Luis', @Apellido = 'Gómez', @Correo = 'luis@example.com', @Telefono = '1357924680', @DUI = '13579246-8', @IdCargo = 8, @IdGenero = 2;
EXEC InsertarEmpleado @Nombre = 'Elena', @Apellido = 'Vásquez', @Correo = 'elena@example.com', @Telefono = '1234567890', @DUI = '12345678-9', @IdCargo = 9, @IdGenero = 1;
EXEC InsertarEmpleado @Nombre = 'Diego', @Apellido = 'Fernández', @Correo = 'diego@example.com', @Telefono = '2468013579', @DUI = '24680135-7', @IdCargo = 10, @IdGenero = 2;

-- Procedimiento para actualizar los datos de un empleado en la base de datos
CREATE PROCEDURE ActualizarEmpleado
    @IdEmpleado INT,
    @NuevoNombre NVARCHAR(100),
    @NuevoApellido NVARCHAR(100),
    @NuevoCorreo NVARCHAR(100),
    @NuevoTelefono NVARCHAR(100),
    @NuevoDUI NVARCHAR(100),
    @NuevoIdCargo INT,
    @NuevoIdGenero INT
AS
BEGIN
    UPDATE Empleado
    SET Nombre = @NuevoNombre,
        Apellido = @NuevoApellido,
        Correo = @NuevoCorreo,
        Telefono = @NuevoTelefono,
        DUI = @NuevoDUI,
        IdCargo = @NuevoIdCargo,
        IdGenero = @NuevoIdGenero
    WHERE IdEmpleado = @IdEmpleado;
END;

-- Actualizar los datos de un empleado en la base de datos
EXEC ActualizarEmpleado
    @IdEmpleado = 1,
    @NuevoNombre = 'NuevoNombreEmpleado',
    @NuevoApellido = 'NuevoApellidoEmpleado',
    @NuevoCorreo = 'nuevo_correo@dominio.com',
    @NuevoTelefono = '9876543210',
    @NuevoDUI = '98765432-1',
    @NuevoIdCargo = 2,
    @NuevoIdGenero = 2;

-- Procedimiento para eliminar un empleado de la base de datos
CREATE PROCEDURE EliminarEmpleado
    @IdEmpleado INT
AS
BEGIN
    DELETE FROM Empleado
    WHERE IdEmpleado = @IdEmpleado;
END;

-- Eliminar un empleado de la base de datos
EXEC EliminarEmpleado @IdEmpleado = 1;

-- Procedimiento para seleccionar todos los empleados con su información completa
CREATE PROCEDURE SelectAllEmpleados
AS
BEGIN
    SELECT 
        e.Nombre AS Nombre,
        e.Apellido AS Apellido,
        e.Correo AS Correo,
        e.Telefono AS Telefono,
        e.DUI AS DUI,
        c.NombreCargo AS Cargo,
        g.Sexo AS Genero
    FROM 
        Empleado e
    INNER JOIN 
        Cargo c ON e.IdCargo = c.IdCargo
    INNER JOIN 
        Genero g ON e.IdGenero = g.IdGenero;
END;

-- Ejecutar el procedimiento para seleccionar todos los empleados con su información completa
EXEC SelectAllEmpleados;

-------------------------------------------------------------------------------------------------------------

-- Procedimiento para insertar un nuevo estado en la tabla Estado
CREATE PROCEDURE InsertarEstado
    @TipoEstado NVARCHAR(100)
AS
BEGIN
    INSERT INTO Estado (TipoEstado)
    VALUES (@TipoEstado);
END;

-- Ejecutar el procedimiento para insertar un estado activo
EXEC InsertarEstado @TipoEstado = 'Activo';

-- Ejecutar el procedimiento para insertar un estado inactivo
EXEC InsertarEstado @TipoEstado = 'Inactivo';

-------------------------------------------------------------------------------------------------------------
-- Procedimiento para insertar un nuevo rol en la tabla Rol
CREATE PROCEDURE InsertarRol
    @NombreRol NVARCHAR(100),
    @Descripcion NVARCHAR(100)
AS
BEGIN
    INSERT INTO Rol (NombreRol, Descripcion)
    VALUES (@NombreRol, @Descripcion);
END;

-- Procedimiento para actualizar un rol existente en la tabla Rol
CREATE PROCEDURE ActualizarRol
    @IdRol INT,
    @NuevoNombreRol NVARCHAR(100),
    @NuevaDescripcion NVARCHAR(100)
AS
BEGIN
    UPDATE Rol
    SET NombreRol = @NuevoNombreRol,
        Descripcion = @NuevaDescripcion
    WHERE IdRol = @IdRol;
END;

-- Procedimiento para eliminar un rol existente de la tabla Rol
CREATE PROCEDURE EliminarRol
    @IdRol INT
AS
BEGIN
    DELETE FROM Rol
    WHERE IdRol = @IdRol;
END;


-------------------------------------------------------------------------------------------------------------
-- Procedimiento para insertar un nuevo tipo de pago en la tabla TipoPago
CREATE PROCEDURE InsertarTipoPago
    @Tarjeta NVARCHAR(50),
    @Efectivo NVARCHAR(50)
AS
BEGIN
    INSERT INTO TipoPago (Tarjeta, Efectivo)
    VALUES (@Tarjeta, @Efectivo);
END;

-- Procedimiento para actualizar un tipo de pago existente en la tabla TipoPago
CREATE PROCEDURE ActualizarTipoPago
    @IdPago INT,
    @Tarjeta NVARCHAR(50),
    @Efectivo NVARCHAR(50)
AS
BEGIN
    UPDATE TipoPago
    SET Tarjeta = @Tarjeta,
        Efectivo = @Efectivo
    WHERE IdPago = @IdPago;
END;

-- Procedimiento para eliminar un tipo de pago existente de la tabla TipoPago
CREATE PROCEDURE EliminarTipoPago
    @IdPago INT
AS
BEGIN
    DELETE FROM TipoPago
    WHERE IdPago = @IdPago;
END;


-------------------------------------------------------------------------------------------------------------
-- Creación de la vista Filtrado
CREATE VIEW Filtrado AS
SELECT 
    P.IdProducto,
    P.Nombre AS NombreProducto,
    P.Codigo,
    P.Precio,
    P.Costo,
    P.Descripcion,
    P.PrecioCompra,
    P.PrecioVenta,
    PR.Nombre AS NombreProveedor,
    C.Nombre AS NombreCategoria,
    P.Precio * P.Costo AS TotalCosto -- Multiplicación de Precio y Costo con un alias
FROM 
    Producto P
INNER JOIN 
    Proveedor PR ON P.IdProveedor = PR.IdProveedor
INNER JOIN 
    Categoria C ON P.IdCategoria = C.IdCategoria
WHERE
    P.Precio BETWEEN 10 AND 50 -- Filtrar por un rango de precios entre $10 y $50
    AND P.Nombre NOT LIKE 'A%'; -- Filtrar por nombres que no empiecen con 'A'


	-- Seleccionar todo de la vista Filtrado
SELECT * FROM Filtrado;


-------------------------------------------------------------------------------------------------------------
-- Ejecutar procedimiento almacenado para seleccionar todos los empleados
EXEC SelectAllEmpleados;

-- Buscar empleados cuyo nombre sea 'Carlos'
SELECT * FROM Empleado WHERE Nombre = 'Carlos';

-------------------------------------------------------------------------------------------------------------
-- Reporte de productos con su proveedor y categoría
SELECT 
    P.IdProducto,
    P.Nombre AS Producto,
    P.Precio,
    P.Costo,
    PR.Nombre AS Proveedor,
    C.Nombre AS Categoria
FROM 
    Producto P
INNER JOIN 
    Proveedor PR ON P.IdProveedor = PR.IdProveedor
INNER JOIN 
    Categoria C ON P.IdCategoria = C.IdCategoria;






-- Reporte de ventas por cliente
SELECT 
    C.Nombre AS NombreCliente,
    SUM(Detalle.Cantidad * Detalle.PrecioUnitario) AS TotalVentas
FROM 
    Pedido P
INNER JOIN 
    DetallePedido Detalle ON P.IdPedido = Detalle.IdPedido
INNER JOIN 
    Cliente C ON P.IdCliente = C.IdCliente
GROUP BY 
    C.Nombre;





-- Reporte de empleados con su cargo y género
SELECT 
    E.Nombre AS NombreEmpleado,
    C.NombreCargo AS Cargo,
    G.Sexo AS Genero
FROM 
    Empleado E
INNER JOIN 
    Cargo C ON E.IdCargo = C.IdCargo
INNER JOIN 
    Genero G ON E.IdGenero = G.IdGenero;

-- Reporte de productos más vendidos
SELECT 
    P.Nombre AS NombreProducto,
    SUM(Detalle.Cantidad) AS TotalVendido
FROM 
    DetallePedido Detalle
INNER JOIN 
    Producto P ON Detalle.IdProducto = P.IdProducto
GROUP BY 
    P.Nombre
ORDER BY 
    SUM(Detalle.Cantidad) DESC;

-- Reporte de clientes con sus pedidos y estado del pedido
SELECT 
    C.Nombre AS NombreCliente,
    P.IdPedido,
    EP.NombreEstado AS EstadoPedido
FROM 
    Pedido P
INNER JOIN 
    Cliente C ON P.IdCliente = C.IdCliente
INNER JOIN 
    EstadoPedido EP ON P.IdEstadoPedido = EP.IdEstadoPedido;


	-- Reporte de productos con su proveedor, categoría y cantidad en inventario
SELECT 
    P.IdProducto,
    P.Nombre AS Producto,
    P.Precio,
    P.Costo,
    PR.Nombre AS Proveedor,
    C.Nombre AS Categoria,
    I.Cantidad AS Stock
FROM 
    Producto P
INNER JOIN 
    Proveedor PR ON P.IdProveedor = PR.IdProveedor
INNER JOIN 
    Categoria C ON P.IdCategoria = C.IdCategoria
INNER JOIN 
    Inventario I ON P.IdProducto = I.IdProducto;

-- Reporte de pedidos con detalles de los productos y su precio total
SELECT 
    P.IdPedido,
    P.FechaPedido,
    C.Nombre AS NombreCliente,
    PD.Nombre AS NombreProducto,
    Detalle.Cantidad,
    Detalle.PrecioUnitario,
    Detalle.Cantidad * Detalle.PrecioUnitario AS PrecioTotal
FROM 
    Pedido P
INNER JOIN 
    DetallePedido Detalle ON P.IdPedido = Detalle.IdPedido
INNER JOIN 
    Producto PD ON Detalle.IdProducto = PD.IdProducto
INNER JOIN 
    Cliente C ON P.IdCliente = C.IdCliente;

-- Reporte de ventas mensuales por producto
SELECT 
    YEAR(P.FechaPedido) AS Año,
    MONTH(P.FechaPedido) AS Mes,
    PD.Nombre AS NombreProducto,
    SUM(Detalle.Cantidad) AS TotalVendido,
    SUM(Detalle.Cantidad * Detalle.PrecioUnitario) AS Ingresos
FROM 
    Pedido P
INNER JOIN 
    DetallePedido Detalle ON P.IdPedido = Detalle.IdPedido
INNER JOIN 
    Producto PD ON Detalle.IdProducto = PD.IdProducto
GROUP BY 
    YEAR(P.FechaPedido),
    MONTH(P.FechaPedido),
    PD.Nombre;

alter procedure BuscarEmpleados
(
		@campo varchar (300)
)

CREATE PROCEDURE BuscarEmpleadoPorNombre
    @Nombre NVARCHAR(100)
AS
BEGIN
    SELECT * FROM Empleado WHERE Nombre = @Nombre;
END;

CREATE PROCEDURE BuscarEmpleadoPorApellido
    @Apellido NVARCHAR(100)
AS
BEGIN
    SELECT * FROM Empleado WHERE Apellido = @Apellido;
END;

CREATE PROCEDURE BuscarEmpleadoPorCorreo
    @Correo NVARCHAR(100)
AS
BEGIN
    SELECT * FROM Empleado WHERE Correo = @Correo;
END;

-- Ejemplo de búsqueda por nombre
EXEC BuscarEmpleadoPorNombre @Nombre = 'carlos';

-- Ejemplo de búsqueda por apellido
EXEC BuscarEmpleadoPorApellido @Apellido = 'ApellidoEmpleado';

-- Ejemplo de búsqueda por correo
EXEC BuscarEmpleadoPorCorreo @Correo = 'correo@ejemplo.com';

-------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
CREATE PROCEDURE BuscarTabla
    @tabla NVARCHAR(255)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT * FROM ' + @tabla;
    EXEC sp_executesql @sql;
END;


--------------NombreTablaABuscar
EXEC BuscarTabla 'Genero';



-------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------
CREATE PROCEDURE BuscarDatoYCampo
    @tabla NVARCHAR(255),
    @campo NVARCHAR(255)
AS
BEGIN
    DECLARE @consulta_sql NVARCHAR(MAX);
    DECLARE @sql NVARCHAR(MAX);

    SET @consulta_sql = 'SELECT ' + @campo + ' FROM ' + @tabla;

    SET @sql = 'EXEC sp_executesql N''' + @consulta_sql + '''';
    EXEC sp_executesql @sql;
END;

----------------------NombreTabla---Campo a buscar
EXEC BuscarDatoYCampo 'Empleado', 'Apellido';

SELECT * FROM Genero WHERE Sexo = 'Femenino';

