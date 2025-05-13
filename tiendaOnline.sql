/* 
Crear la Base de Datos: 
- Nombre de la base de datos: TiendaOnline.

Crear Tablas y Definir Estructuras:

- Tabla Usuarios (usuarios):
•id_usuario: Identificador único para cada usuario (clave primaria,
autoincremental).
•nombre: Nombre del usuario.
•correo_electronico: Correo electrónico del usuario.
•contrasena: Contraseña del usuario.
•fecha_creacion: Fecha y hora de creación del usuario (timestamp actual por
defecto).

- Tabla Productos (productos):
•id_producto: Identificador único para cada producto (clave primaria,
autoincremental).
•nombre: Nombre del producto.
•descripcion: Descripción detallada del producto.
•precio: Precio del producto.
•stock: Cantidad de productos disponibles en stock.
•fecha_agregado: Fecha y hora de cuando se agregó el producto (timestamp
actual por defecto).

- Tabla Carrito de Compras (carrito):
•id_carrito: Identificador único para cada carrito (clave primaria,
autoincremental).
•id_usuario: Identificador del usuario al que pertenece el carrito (clave foránea
de usuarios).
•fecha_creacion: Fecha y hora de creación del carrito (timestamp actual por
defecto).

- Tabla Detalles del Carrito (detalles_carrito):
•id_detalle: Identificador único para cada detalle (clave primaria,
autoincremental).
•id_carrito: Identificador del carrito (clave foránea de carrito).
•id_producto: Identificador del producto (clave foránea de productos).
•cantidad: Cantidad del producto específico en el carrito.
•fecha_agregado: Fecha y hora de cuando se agregó el producto al carrito
(timestamp actual por defecto). */

/* creacion de base de datos */
DROP IF EXIST TiendaOnline;
CREATE DATABASE TiendaOnline;

/* uso de base de datos */
USE TiendaOnline;

/* creacion de tablas */
CREATE TABLE usuarios (
    id_usuario PRIMARY KEY INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    contrasena VARCHAR(30) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

CREATE TABLE productos (
    id_producto PRIMARY KEY INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL,
    precio FLOAT(10,2) NOT NULL,
    stock INT NOT NULL,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

CREATE TABLE carrito_compras(
    id_carrito PRIMARY KEY INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREING KEY (id_usuario) REFERENCES usuarios(id_usuario)
)

CREATE TABLE detalles_carrito(
    id_detalle PRIMARY KEY INT NOT NULL AUTO_INCREMENT,
    id_carrito INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad SMALLINT NOT NULL,
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREING KEY (id_carrito) REFERENCES carrito_compras(id_carrito),
    FOREING KEY (id_producto) REFERENCES  productos(id_producto)
)