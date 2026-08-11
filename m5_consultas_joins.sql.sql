--Consulta 1 — Vista base del proyecto (INNER JOIN)

USE Ventas_RetailPro_DB;
GO

SELECT
    v.fecha_venta AS fecha,
    c.nombre AS nombre_cliente,
    c.segmento,
    t.region,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta,
    v.canal
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN territorios t
    ON c.id_territorio = t.id_territorio
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria;

    --Consulta 2 — Clientes sin ventas (LEFT JOIN)
    --clientes registrados que aún no han realizado ninguna compra

    SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

--Consulta 3 — Productos sin ventas (LEFT JOIN)
--Productos sin ventas
SELECT
    p.nombre_producto,
    c.nombre_categoria,
    p.precio
FROM productos p
INNER JOIN categorias c
    ON p.id_categoria = c.id_categoria
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- CONSULTA 4
-- Consolidado por canal

SELECT
    canal,
    COUNT(*) AS cantidad_ventas,
    SUM(total_venta) AS total_facturado
FROM (
    SELECT
        id_venta,
        cantidad,
        precio_unitario,
        cantidad * precio_unitario AS total_venta,
        canal
    FROM ventas
    WHERE canal = 'Online'

    UNION ALL

    SELECT
        id_venta,
        cantidad,
        precio_unitario,
        cantidad * precio_unitario AS total_venta,
        canal
    FROM ventas
    WHERE canal = 'Presencial'
) AS ventas_consolidadas
GROUP BY canal;

