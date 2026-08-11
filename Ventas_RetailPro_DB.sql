
-- =====================================================
-- BASE DE DATOS: Ventas_RetailPro_DB
-- Proyecto Integrador RetailPro (M3 + M5)
-- =====================================================

-- =====================================================
-- 1. CREAR BASE DE DATOS
-- =====================================================

CREATE DATABASE Ventas_RetailPro_DB;
GO

USE Ventas_RetailPro_DB;
GO


-- =====================================================
-- 2. ELIMINAR TABLAS SI EXISTEN
-- =====================================================

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS territorios;
DROP TABLE IF EXISTS categorias;
GO


-- =====================================================
-- 3. TABLA CATEGORÍAS
-- =====================================================

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150)
);
GO


-- =====================================================
-- 4. TABLA TERRITORIOS
-- =====================================================

CREATE TABLE territorios (
    id_territorio INT PRIMARY KEY,
    provincia VARCHAR(50) NOT NULL,
    region VARCHAR(30) NOT NULL
);
GO


-- =====================================================
-- 5. TABLA CLIENTES
-- =====================================================

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    fecha_registro DATE NOT NULL,
    segmento VARCHAR(30),
    id_territorio INT,

    FOREIGN KEY (id_territorio)
        REFERENCES territorios(id_territorio)
);
GO


-- =====================================================
-- 6. TABLA PRODUCTOS
-- =====================================================

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    marca VARCHAR(30) NOT NULL,
    id_categoria INT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    activo BIT DEFAULT 1,

    FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);
GO


-- =====================================================
-- 7. TABLA VENTAS
-- =====================================================

CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta DATE NOT NULL,
    canal VARCHAR(20),

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
);
GO


-- =====================================================
-- 8. CARGA DE CATEGORÍAS
-- =====================================================

INSERT INTO categorias VALUES
(1,'Smartphones','Teléfonos celulares'),
(2,'Accesorios','Accesorios para celulares'),
(3,'Audio','Auriculares y parlantes'),
(4,'Wearables','Relojes inteligentes');
GO


-- =====================================================
-- 9. CARGA DE TERRITORIOS
-- =====================================================

INSERT INTO territorios VALUES
(1,'Córdoba','Centro'),
(2,'Santa Fe','Centro'),
(3,'Entre Ríos','Centro'),
(4,'Buenos Aires','AMBA'),
(5,'Mendoza','Cuyo');
GO


-- =====================================================
-- 10. CARGA DE CLIENTES
-- =====================================================

INSERT INTO clientes VALUES
(1,'María López','maria@retailpro.com','Córdoba','2024-01-05','Minorista',1),
(2,'Carlos Ruiz','carlos@retailpro.com','Rosario','2024-01-10','Corporativo',2),
(3,'Ana Gómez','ana@retailpro.com','Paraná','2024-02-01','Minorista',3),
(4,'Pedro Sanz','pedro@retailpro.com','Buenos Aires','2024-02-15','Corporativo',4),
(5,'Laura Torres','laura@retailpro.com','Mendoza','2024-03-01','Minorista',5),

-- Cliente sin ventas (para LEFT JOIN)
(6,'Sofía Martínez','sofia@retailpro.com','Córdoba','2024-03-18','Corporativo',1);
GO


-- =====================================================
-- 11. CARGA DE PRODUCTOS
-- =====================================================

INSERT INTO productos VALUES
(1,'iPhone 15','Apple',1,1200.00,15,1),
(2,'Galaxy S24','Samsung',1,950.00,20,1),
(3,'Moto G84','Motorola',1,350.00,25,1),
(4,'Galaxy A55','Samsung',1,450.00,18,1),
(5,'iPhone 13','Apple',1,800.00,10,1),
(6,'Nova 11','Huawei',1,500.00,12,1),

-- Producto sin ventas (para LEFT JOIN)
(7,'Moto G54','Motorola',1,280.00,30,1);
GO


-- =====================================================
-- 12. CARGA DE VENTAS
-- =====================================================

INSERT INTO ventas VALUES
(1,1,1,2,1200.00,'2024-03-05','Online'),
(2,2,2,1,950.00,'2024-03-06','Presencial'),
(3,3,3,2,350.00,'2024-03-07','Online'),
(4,1,4,1,450.00,'2024-03-08','Presencial'),
(5,4,5,1,800.00,'2024-03-10','Online'),
(6,2,6,2,500.00,'2024-03-11','Presencial'),
(7,5,1,1,1200.00,'2024-03-12','Online'),
(8,3,2,1,950.00,'2024-03-13','Presencial'),
(9,4,3,3,350.00,'2024-03-14','Online'),
(10,5,4,1,450.00,'2024-03-15','Presencial'),
(11,1,2,1,950.00,'2024-03-16','Online'),
(12,2,5,1,800.00,'2024-03-17','Presencial');
GO


-- =====================================================
-- 13. VERIFICAR CARGA DE DATOS
-- =====================================================

SELECT * FROM categorias;
SELECT * FROM territorios;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
GO

USE Ventas_RetailPro_DB;
GO

SELECT COUNT(*) AS cantidad_categorias FROM categorias;
SELECT COUNT(*) AS cantidad_territorios FROM territorios;
SELECT COUNT(*) AS cantidad_clientes FROM clientes;
SELECT COUNT(*) AS cantidad_productos FROM productos;
SELECT COUNT(*) AS cantidad_ventas FROM ventas;