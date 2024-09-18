# Antiguedades

# Documentación Técnica: Base de Datos de Antigüedades CampusLands

## Descripción General
Esta base de datos ha sido diseñada para gestionar un negocio de antigüedades, permitiendo el registro de usuarios, antigüedades, transacciones y otras entidades relacionadas.

## Estructura de la Base de Datos

### Tablas Principales
1. USUARIO: Almacena información básica de usuarios.
2. INFORMACION_CONTACTO: Detalles de contacto de los usuarios.
3. ROL: Roles de usuario disponibles.
4. USUARIO_ROL: Asignación de roles a usuarios.
5. ANTIGUEDAD: Detalles de las antigüedades en venta.
6. CARACTERISTICA_ANTIGUEDAD: Características específicas de cada antigüedad.
7. HISTORIAL_PRECIO: Registro de cambios de precio de las antigüedades.
8. CATEGORIA: Categorías de antigüedades.
9. EPOCA: Épocas históricas de las antigüedades.
10. ESTADO_CONSERVACION: Estados de conservación de las antigüedades.
11. TRANSACCION: Registro de ventas realizadas.
12. METODO_PAGO: Métodos de pago disponibles para los usuarios.
13. FOTO_ANTIGUEDAD: URLs de fotos de las antigüedades.
14. VISITA: Registro de visitas a las páginas de antigüedades.

### Relaciones Clave
- ANTIGUEDAD está relacionada con CATEGORIA, EPOCA, ESTADO_CONSERVACION y USUARIO (vendedor).
- TRANSACCION está relacionada con ANTIGUEDAD, USUARIO (vendedor y comprador) y METODO_PAGO.
- USUARIO está relacionada con INFORMACION_CONTACTO, ROL y METODO_PAGO.

## Índices Importantes
- idx_email en USUARIO(email)
- idx_antiguedad_estatus en ANTIGUEDAD(estatus)
- idx_transaccion_fecha en TRANSACCION(fecha_transaccion)
- idx_historial_precio_fecha en HISTORIAL_PRECIO(fecha_cambio)
- idx_categoria_precio en ANTIGUEDAD(id_categoria, id_vendedor)
- idx_historial_precio en HISTORIAL_PRECIO(id_antiguedad, fecha_cambio)
- idx_transaccion_vendedor_fecha en TRANSACCION(id_vendedor, fecha_transaccion)
- idx_transaccion_comprador en TRANSACCION(id_comprador)
- idx_visita_antiguedad en VISITA(id_antiguedad)

## Vistas
- v_ultimo_precio: Proporciona el último precio registrado para cada antigüedad.

## Consultas Comunes
Consultar el archivo 'sql-test-queries-revised.sql' para ejemplos de consultas frecuentes.

## Mantenimiento
- Realizar copias de seguridad diarias usando mysqldump.
- Monitorear el crecimiento de las tablas, especialmente ANTIGUEDAD, TRANSACCION y HISTORIAL_PRECIO.
- Revisar y optimizar consultas lentas periódicamente usando EXPLAIN.
- Actualizar estadísticas de la base de datos regularmente con ANALYZE TABLE.

## Consideraciones de Seguridad
- Utilizar conexiones SSL/TLS para acceder a la base de datos.
- Implementar un sistema de gestión de contraseñas seguro para los usuarios de la base de datos.
- Realizar auditorías regulares de los accesos y operaciones en la base de datos.
- Mantener actualizado el servidor MySQL y aplicar parches de seguridad oportunamente.

## Contacto
Para soporte técnico, contactar al equipo de desarrollo en: soporte@antiguedadescampuslands.com