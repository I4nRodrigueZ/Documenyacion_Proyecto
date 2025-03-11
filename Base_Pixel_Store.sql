-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS PixelStore;
USE PixelStore
;

-- Tabla Usuario
CREATE TABLE Usuario (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Contraseña VARCHAR(100) NOT NULL,
    Fecha_Registro DATE NOT NULL,
    Direccion VARCHAR(150),
    Telefono VARCHAR(20),
    Nombre_Rol ENUM('Administrador', 'Cliente', 'Vendedor') NOT NULL
);

--Tabla Rol
    ID_Rol IN AUTOINCREMENT PRIMARY KEY,
    Nombre_Rol VARCHAR (50) NOT NULL

-- Tabla Carrito
CREATE TABLE Carrito (
    ID_Carrito INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Fecha_Creacion DATE NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE
);

-- Tabla Divisas
CREATE TABLE Divisas (
    ID_Divisa INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Divisa VARCHAR(50) NOT NULL,
    Simbolo VARCHAR(10),
    Tipo_Cambio DECIMAL(10, 4) NOT NULL
);

-- Tabla Factura
CREATE TABLE Factura (
    ID_Factura INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Fecha_Factura DATE NOT NULL,
    Monto_Total DECIMAL(10, 2) NOT NULL,
    Impuestos DECIMAL(10, 2) DEFAULT 0,
    Total_Factura DECIMAL(10, 2) NOT NULL,
    Metodo_Pago VARCHAR(50) NOT NULL,
    ID_Divisa INT,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE SET NULL,
    FOREIGN KEY (ID_Divisa) REFERENCES Divisas(ID_Divisa) ON DELETE SET NULL
);

-- Tabla Categoría
CREATE TABLE Categoria (
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Categoria VARCHAR(50) NOT NULL,
    Descripcion TEXT
);

-- Tabla Juegos
CREATE TABLE Juegos (
    ID_Juego INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Juego VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10, 2) NOT NULL,
    Stock INT DEFAULT 0,
    Condicion ENUM('Nuevo', 'Usado') NOT NULL,
    ID_Categoria INT,
    FOREIGN KEY (ID_Categoria) REFERENCES Categoria(ID_Categoria) ON DELETE SET NULL
);

-- Tabla Detalle_Factura
CREATE TABLE Detalle_Factura (
    ID_Factura INT,
    ID_Juego INT,
    Cantidad INT NOT NULL,
    Precio_Unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ID_Factura, ID_Juego),
    FOREIGN KEY (ID_Factura) REFERENCES Factura(ID_Factura) ON DELETE CASCADE,
    FOREIGN KEY (ID_Juego) REFERENCES Juegos(ID_Juego) ON DELETE CASCADE
);

-- Tabla Reseñas
CREATE TABLE Resena (
    ID_Resena INT AUTO_INCREMENT PRIMARY KEY,
    ID_Juego INT,
    ID_Usuario INT,
    Calificacion INT,
    Comentario TEXT,
    Fecha_Resena DATE NOT NULL,
    FOREIGN KEY (ID_Juego) REFERENCES Juegos(ID_Juego) ON DELETE CASCADE,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE SET NULL
);

-- Tabla Promociones
CREATE TABLE Promocion (
    ID_Promocion INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Promocion VARCHAR(100) NOT NULL,
    Tipo_Descuento ENUM('Porcentaje', 'Fijo') NOT NULL,
    Valor_Descuento DECIMAL(5, 2) NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL
);

-- Tabla Juegos_Promociones (relación N a M entre Juegos y Promociones)
CREATE TABLE Juegos_Promociones (
    ID_Juego INT,
    ID_Promocion INT,
    PRIMARY KEY (ID_Juego, ID_Promocion),
    FOREIGN KEY (ID_Juego) REFERENCES Juegos(ID_Juego) ON DELETE CASCADE,
    FOREIGN KEY (ID_Promocion) REFERENCES Promocion(ID_Promocion) ON DELETE CASCADE
);

-- Tabla Métodos_Pago
CREATE TABLE Metodo_Pago (
    ID_Metodo INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Metodo VARCHAR(50) NOT NULL
);

-- Tabla Historial_Precio
CREATE TABLE Historial_Precio (
    ID_Historial INT AUTO_INCREMENT PRIMARY KEY,
    ID_Juego INT,
    Precio DECIMAL(10, 2) NOT NULL,
    Fecha_Cambio DATE NOT NULL,
    FOREIGN KEY (ID_Juego) REFERENCES Juegos(ID_Juego) ON DELETE CASCADE
);

-- Tabla Logs
CREATE TABLE Logs (
    ID_Log INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Accion VARCHAR(255) NOT NULL,
    Fecha_Hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    c TEXT,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE SET NULL
);
