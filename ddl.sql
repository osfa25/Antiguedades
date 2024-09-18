DROP DATABASE IF EXISTS AntiguedadesDB;
CREATE DATABASE AntiguedadesDB;
USE AntiguedadesDB;



-- Creación de la tabla USUARIO
CREATE TABLE USUARIO (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro DATE NOT NULL
);

-- Creación de la tabla INFORMACION_CONTACTO
CREATE TABLE INFORMACION_CONTACTO (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    telefono VARCHAR(20),
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    pais VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id)
);

-- Creación de la tabla ROL
CREATE TABLE ROL (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Creación de la tabla USUARIO_ROL
CREATE TABLE USUARIO_ROL (
    id_usuario INT,
    id_rol INT,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id),
    FOREIGN KEY (id_rol) REFERENCES ROL(id)
);

-- Creación de la tabla CATEGORIA
CREATE TABLE CATEGORIA (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Creación de la tabla EPOCA
CREATE TABLE EPOCA (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    ano_inicio INT,
    ano_fin INT
);

-- Creación de la tabla ESTADO_CONSERVACION
CREATE TABLE ESTADO_CONSERVACION (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) UNIQUE NOT NULL
);

-- Creación de la tabla ANTIGUEDAD
CREATE TABLE ANTIGUEDAD (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_categoria INT,
    id_epoca INT,
    id_estado INT,
    id_vendedor INT,
    estatus ENUM('en_venta', 'vendido', 'retirado') NOT NULL,
    fecha_registro DATE NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id),
    FOREIGN KEY (id_epoca) REFERENCES EPOCA(id),
    FOREIGN KEY (id_estado) REFERENCES ESTADO_CONSERVACION(id),
    FOREIGN KEY (id_vendedor) REFERENCES USUARIO(id)
);

-- Creación de la tabla CARACTERISTICA_ANTIGUEDAD
CREATE TABLE CARACTERISTICA_ANTIGUEDAD (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_antiguedad INT,
    nombre_caracteristica VARCHAR(100) NOT NULL,
    valor_caracteristica VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_antiguedad) REFERENCES ANTIGUEDAD(id)
);

-- Creación de la tabla HISTORIAL_PRECIO
CREATE TABLE HISTORIAL_PRECIO (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_antiguedad INT,
    precio DECIMAL(10, 2) NOT NULL,
    fecha_cambio DATE NOT NULL,
    FOREIGN KEY (id_antiguedad) REFERENCES ANTIGUEDAD(id)
);

-- Creación de la tabla METODO_PAGO
CREATE TABLE METODO_PAGO (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    tipo VARCHAR(50) NOT NULL,
    detalles VARCHAR(255),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id)
);

-- Creación de la tabla TRANSACCION
CREATE TABLE TRANSACCION (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_antiguedad INT,
    id_vendedor INT,
    id_comprador INT,
    id_metodo_pago INT,
    precio_venta DECIMAL(10, 2) NOT NULL,
    fecha_transaccion DATE NOT NULL,
    estado_transaccion ENUM('pendiente', 'completada', 'cancelada') NOT NULL,
    FOREIGN KEY (id_antiguedad) REFERENCES ANTIGUEDAD(id),
    FOREIGN KEY (id_vendedor) REFERENCES USUARIO(id),
    FOREIGN KEY (id_comprador) REFERENCES USUARIO(id),
    FOREIGN KEY (id_metodo_pago) REFERENCES METODO_PAGO(id)
);

-- Creación de la tabla FOTO_ANTIGUEDAD
CREATE TABLE FOTO_ANTIGUEDAD (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_antiguedad INT,
    url_foto VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_antiguedad) REFERENCES ANTIGUEDAD(id)
);

-- Creación de la tabla VISITA
CREATE TABLE VISITA (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_antiguedad INT,
    id_usuario INT,
    fecha_visita DATETIME NOT NULL,
    FOREIGN KEY (id_antiguedad) REFERENCES ANTIGUEDAD(id),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id)
);

CREATE INDEX idx_email ON USUARIO(email);

CREATE INDEX idx_antigueda

CREATE INDEX idx_antiguedad_estatus ON ANTIGUEDAD(estatus);
CREATE INDEX idx_transaccion_fecha ON TRANSACCION(fecha_transaccion);
CREATE INDEX idx_historial_precio_fecha ON HISTORIAL_PRECIO(fecha_cambio);

-- Índice para mejorar la búsqueda por categoría y precio
CREATE INDEX idx_categoria_precio ON ANTIGUEDAD(id_categoria, id_vendedor);

-- Índice para mejorar las búsquedas en el historial de precios
CREATE INDEX idx_historial_precio ON HISTORIAL_PRECIO(id_antiguedad, fecha_cambio);

-- Índice para mejorar las búsquedas de transacciones por vendedor y fecha
CREATE INDEX idx_transaccion_vendedor_fecha ON TRANSACCION(id_vendedor, fecha_transaccion);

-- Índice para mejorar las búsquedas de transacciones por comprador
CREATE INDEX idx_transaccion_comprador ON TRANSACCION(id_comprador);

-- Índice para mejorar las búsquedas de visitas por antigüedad
CREATE INDEX idx_visita_antiguedad ON VISITA(id_antiguedad);

-- Crear una vista para el último precio de cada antigüedad
CREATE VIEW v_ultimo_precio AS
SELECT hp.id_antiguedad, hp.precio
FROM HISTORIAL_PRECIO hp
INNER JOIN (
    SELECT id_antiguedad, MAX(fecha_cambio) AS max_fecha
    FROM HISTORIAL_PRECIO
    GROUP BY id_antiguedad
) max_hp ON hp.id_antiguedad = max_hp.id_antiguedad AND hp.fecha_cambio = max_hp.max_fecha;