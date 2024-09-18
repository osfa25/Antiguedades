-- 1. Listar todas las antigüedades disponibles para la venta con sus características
SELECT a.id, a.nombre, c.nombre AS categoria, e.nombre AS epoca, ec.descripcion AS estado_conservacion,
       ca.nombre_caracteristica, ca.valor_caracteristica, hp.precio
FROM ANTIGUEDAD a
JOIN CATEGORIA c ON a.id_categoria = c.id
JOIN EPOCA e ON a.id_epoca = e.id
JOIN ESTADO_CONSERVACION ec ON a.id_estado = ec.id
LEFT JOIN CARACTERISTICA_ANTIGUEDAD ca ON a.id = ca.id_antiguedad
LEFT JOIN (
    SELECT id_antiguedad, precio
    FROM HISTORIAL_PRECIO
    WHERE (id_antiguedad, fecha_cambio) IN (
        SELECT id_antiguedad, MAX(fecha_cambio)
        FROM HISTORIAL_PRECIO
        GROUP BY id_antiguedad
    )
) hp ON a.id = hp.id_antiguedad
WHERE a.estatus = 'en_venta';

-- 2. Buscar antigüedades por categoría y rango de precio
SELECT a.id, a.nombre, hp.precio
FROM ANTIGUEDAD a
JOIN CATEGORIA c ON a.id_categoria = c.id
JOIN (
    SELECT id_antiguedad, precio
    FROM HISTORIAL_PRECIO
    WHERE (id_antiguedad, fecha_cambio) IN (
        SELECT id_antiguedad, MAX(fecha_cambio)
        FROM HISTORIAL_PRECIO
        GROUP BY id_antiguedad
    )
) hp ON a.id = hp.id_antiguedad
WHERE c.nombre = 'Muebles' AND hp.precio BETWEEN 500 AND 2000 AND a.estatus = 'en_venta';

-- 3. Mostrar el historial de ventas de un vendedor específico
SELECT a.nombre AS antiguedad, t.precio_venta, t.fecha_transaccion, 
       uc.nombre AS comprador, mp.tipo AS metodo_pago
FROM TRANSACCION t
JOIN ANTIGUEDAD a ON t.id_antiguedad = a.id
JOIN USUARIO uc ON t.id_comprador = uc.id
JOIN METODO_PAGO mp ON t.id_metodo_pago = mp.id
WHERE t.id_vendedor = 1;

-- 4. Obtener el total de ventas realizadas en un periodo de tiempo
SELECT SUM(precio_venta) AS total_ventas
FROM TRANSACCION
WHERE fecha_transaccion BETWEEN '2024-01-01' AND '2024-12-31' AND estado_transaccion = 'completada';

-- 5. Encontrar los usuarios más activos (con más compras realizadas)
SELECT u.nombre, COUNT(*) AS total_compras
FROM USUARIO u
JOIN TRANSACCION t ON u.id = t.id_comprador
WHERE t.estado_transaccion = 'completada'
GROUP BY u.id
ORDER BY total_compras DESC
LIMIT 5;

-- 6. Listar las antigüedades más populares por número de visitas
SELECT a.nombre, COUNT(*) AS total_visitas
FROM ANTIGUEDAD a
JOIN VISITA v ON a.id = v.id_antiguedad
GROUP BY a.id
ORDER BY total_visitas DESC
LIMIT 10;

-- 7. Obtener un informe de inventario actual con el último precio registrado
SELECT c.nombre AS categoria, COUNT(*) AS cantidad, AVG(hp.precio) AS precio_promedio
FROM ANTIGUEDAD a
JOIN CATEGORIA c ON a.id_categoria = c.id
JOIN (
    SELECT id_antiguedad, precio
    FROM HISTORIAL_PRECIO
    WHERE (id_antiguedad, fecha_cambio) IN (
        SELECT id_antiguedad, MAX(fecha_cambio)
        FROM HISTORIAL_PRECIO
        GROUP BY id_antiguedad
    )
) hp ON a.id = hp.id_antiguedad
WHERE a.estatus = 'en_venta'
GROUP BY c.id;

-- 8. Listar todas las transacciones con detalles de comprador, vendedor y método de pago
SELECT t.id, a.nombre AS antiguedad, uv.nombre AS vendedor, uc.nombre AS comprador,
       t.precio_venta, t.fecha_transaccion, mp.tipo AS metodo_pago, t.estado_transaccion
FROM TRANSACCION t
JOIN ANTIGUEDAD a ON t.id_antiguedad = a.id
JOIN USUARIO uv ON t.id_vendedor = uv.id
JOIN USUARIO uc ON t.id_comprador = uc.id
JOIN METODO_PAGO mp ON t.id_metodo_pago = mp.id
ORDER BY t.fecha_transaccion DESC;