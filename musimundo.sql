/* Consultas SELECT */

/* 1. ¿Qué álbumes tenemos?
Viene el manager de Musimundos y, para organizar su inventario de discos, te pide un informe con todos los álbumes que posee la empresa. Realiza una consulta que devuelva todos los álbumes. */

SELECT titulo FROM albumes;

/* 2. Control de ventas
Para realizar un control de ventas, Musimundos te pide consultar el primer nombre y teléfono de todos sus clientes. */

SELECT primer_nombre, telefono FROM clientes;

/* 3. Clientes de Estados Unidos
Ahora que ya tenemos los nombres de los clientes necesitamos que obtengas sólo
aquellos que sean de USA. */

SELECT primer_nombre, telefono 
FROM clientes
WHERE pais = 'USA';

/* 4. Canciones semi-largas
Vamos a ponernos un poco más finos con la selección. El departamento de
canciones te pide un informe de aquellas cuya duración sea entre 200.000 y 
300.000 milisegundos. */

SELECT nombre, milisegundos FROM canciones WHERE milisegundos BETWEEN '200000' AND '300000';

/* 5. Clientes hispanohablantes
URGENTE! Una banda argentina acaba de sacar un álbum, y nos pidio una lista de
clientes hispanohablantes para poder divulgar su producto. Te pedimos que obtengas una lista de clientes cuyo país de origen sea Spain o Argentina. ¡Suerte con eso! */

SELECT primer_nombre, apellido, pais 
FROM clientes 
WHERE pais = 'Spain' OR pais = 'Argentina';

/* 6. Todos los géneros de los álbumes.
Musimundos desea agregar una lista con todos los géneros a los que pertenecen sus álbumes, pero ordenados por nombre de manera alfabética. */

SELECT nombre 
FROM generos
ORDER BY nombre ASC;

/* 7. Nombres de clientes ordenados
Los gerentes están muy satisfechos con tu trabajo! Pero las tareas todavía no
terminan. Ahora necesitan una lista con solamente los nombres de los clientes de
Musimundos, ordenada por país de origen (descendente) y, como segundo
parámetro, por ciudad. ¿Estás listo? */

SELECT primer_nombre, apellido, pais, ciudad 
FROM clientes
ORDER BY pais DESC, ciudad DESC;

/* 8. Tipos de medio
Decidimos que "nombre" era un poco ambigüo para una columna de tipos de medios.
Por eso, Musimundos te pide una lista de los nombres de tipos de medio en una
columna que se llame "nombres_de_medios". */

SELECT nombre AS nombres_de_medios
FROM tipos_de_medio;

/* 9. Top 3
El encargado del equipo de UX de Musimundos necesita hacer una presentación
mostrando solo tres canciones de nuestra colección. Además, pide que sean las tres con mayor duración. ¡Vamos con eso! */

SELECT nombre, milisegundos 
FROM canciones
ORDER BY milisegundos DESC
LIMIT 3;

/* 10.Paginación
Tenemos un nuevo comunicado del departamento de UX.
En esta ocasión necesitan hacer una paginación de canciones. La primera página ya está resuelta, pero para la segunda debes saltear cinco canciones y traer las
próximas cinco. Estas deben estar ordenadas alfabéticamente por nombre. */

SELECT nombre
FROM canciones
ORDER BY nombre ASC
LIMIT 5 OFFSET 5;