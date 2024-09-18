-- Insertar roles
INSERT INTO ROL (nombre) VALUES
('vendedor'), ('comprador'), ('administrador');

-- Insertar usuarios
INSERT INTO USUARIO (nombre, email, contrasena, fecha_registro) VALUES
('Juan Pérez', 'juan@example.com', 'password123', '2024-01-01'),
('Ana García', 'ana@example.com', 'password456', '2024-01-02'),
('Admin User', 'admin@example.com', 'adminpass', '2024-01-03');

-- Asignar roles a usuarios
INSERT INTO USUARIO_ROL (id_usuario, id_rol) VALUES
(1, 1), (1, 2), -- Juan es vendedor y comprador
(2, 2), -- Ana es compradora
(3, 3); -- Admin User es administrador

-- Insertar información de contacto
INSERT INTO INFORMACION_CONTACTO (id_usuario, telefono, direccion, ciudad, pais) VALUES
(1, '123456789', 'Calle 1 #123', 'Ciudad A', 'País X'),
(2, '987654321', 'Avenida 2 #456', 'Ciudad B', 'País Y'),
(3, '555555555', 'Plaza 3 #789', 'Ciudad C', 'País Z');

-- Insertar categorías
INSERT INTO CATEGORIA (nombre) VALUES
('Muebles'), ('Joyería'), ('Arte'), ('Libros');

-- Insertar épocas
INSERT INTO EPOCA (nombre, ano_inicio, ano_fin) VALUES
('Victoriana', 1837, 1901),
('Art Deco', 1920, 1939),
('Mid-Century Modern', 1945, 1969);

-- Insertar estados de conservación
INSERT INTO ESTADO_CONSERVACION (descripcion) VALUES
('Excelente'), ('Bueno'), ('Regular'), ('Restauración necesaria');

-- Insertar antigüedades
INSERT INTO ANTIGUEDAD (nombre, descripcion, id_categoria, id_epoca, id_estado, id_vendedor, estatus, fecha_registro) VALUES
('Sillón Victorian', 'Sillón de caoba del período Victoriano', 1, 1, 2, 1, 'en_venta', '2024-02-01'),
('Collar Art Deco', 'Collar de plata con diseño geométrico', 2, 2, 1, 1, 'en_venta', '2024-02-02'),
('Pintura abstracta', 'Óleo sobre lienzo de mediados del siglo XX', 3, 3, 2, 1, 'en_venta', '2024-02-03');

-- Insertar características de antigüedades
INSERT INTO CARACTERISTICA_ANTIGUEDAD (id_antiguedad, nombre_caracteristica, valor_caracteristica) VALUES
(1, 'Material', 'Caoba'),
(1, 'Estilo', 'Victorian'),
(2, 'Material', 'Plata'),
(2, 'Longitud', '45 cm'),
(3, 'Técnica', 'Óleo'),
(3, 'Dimensiones', '80x100 cm');

-- Insertar historial de precios
INSERT INTO HISTORIAL_PRECIO (id_antiguedad, precio, fecha_cambio) VALUES
(1, 1500.00, '2024-02-01'),
(2, 800.00, '2024-02-02'),
(3, 2000.00, '2024-02-03');

-- Insertar métodos de pago
INSERT INTO METODO_PAGO (id_usuario, tipo, detalles) VALUES
(1, 'Tarjeta de crédito', 'VISA terminada en 1234'),
(2, 'PayPal', 'ana@example.com');

-- Insertar transacciones
INSERT INTO TRANSACCION (id_antiguedad, id_vendedor, id_comprador, id_metodo_pago, precio_venta, fecha_transaccion, estado_transaccion) VALUES
(2, 1, 2, 2, 800.00, '2024-03-01', 'completada');

-- Insertar fotos de antigüedades
INSERT INTO FOTO_ANTIGUEDAD (id_antiguedad, url_foto) VALUES
(1, 'https://example.com/sillon_victorian.jpg'),
(2, 'https://example.com/collar_artdeco.jpg'),
(3, 'https://example.com/pintura_abstracta.jpg');

-- Insertar visitas
INSERT INTO VISITA (id_antiguedad, id_usuario, fecha_visita) VALUES
(1, 2, '2024-02-15 10:30:00'),
(2, 2, '2024-02-16 14:45:00'),
(3, 2, '2024-02-17 16:20:00');