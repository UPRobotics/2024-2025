CREATE DATABASE almacenamientoo;
USE almacenamientoo;

CREATE TABLE IF NOT EXISTS TiposHerramientas (
    codigo CHAR(1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Crear la tabla para los cajones
CREATE TABLE Cajones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_id VARCHAR(10) NOT NULL,
    tipo_herramienta VARCHAR(50),
    cantidad_herramientas INT,
    numero_caja VARCHAR(10)
);

-- Crear la tabla para las herramientas
CREATE TABLE Herramientas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_id VARCHAR(10) NOT NULL,
    tipo_herramienta VARCHAR(50),
    numero_herramienta VARCHAR(10)
);

-- Crear la tabla para relacionar herramientas con cajones
CREATE TABLE Relaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cajon INT,
    id_herramienta INT,
    FOREIGN KEY (id_cajon) REFERENCES Cajones(id),
    FOREIGN KEY (id_herramienta) REFERENCES Herramientas(id)
);
