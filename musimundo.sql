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

/* JOIN - PARTE III */

/* 1. Rock Nacional
Es la semana del rock a nivel mundial, y nuestro gerente de Musimundos nos pide
crear anuncios con canciones del género Rock. Hacé una consulta a nuestra base de datos que nos devuelva los nombres de las canciones que tengan género rock. */

SELECT canciones.nombre AS nombre_canciones, generos.nombre AS genero
FROM canciones
INNER JOIN generos
ON canciones.id_genero = generos.id
WHERE generos.nombre = 'Rock'

/* 2. Deep Purple
En el salón de Musimundos hay un cliente fanático de Deep Purple, este quiere
comprar todos los álbumes que tengan como artista a Deep Purple. Hacé una
consulta a nuestra base de datos que nos traiga el título del álbum y el autor, para saber si lo que le estamos vendiendo es correcto. */

SELECT artistas.nombre AS nombre_artista, albumes.titulo AS albumes
FROM artistas
INNER JOIN albumes 
ON artistas.id = albumes.id_artista
WHERE artistas.nombre LIKE '%Deep Purple%'

/* 3. MPEG
En el departamento de desarrollo de Musimundos están creando la nueva aplicación
mobile, en la cual vas a poder escuchar musica online de tus artistas favoritos. Para evitar posibles problemas de compatibilidad, los desarrolladores decidieron que sólo van a subir canciones que tengan el tipo de medio "MPEG audio file". Ayudá al equipo y obtengamos una lista en las cuales tengas el nombre de las canciones que tengan ese tipo de medio. */

SELECT 
canciones.nombre AS nombre_canciones, 
tipos_de_medio.nombre AS tipos_de_medio
FROM canciones
INNER JOIN tipos_de_medio
ON canciones.id_tipo_de_medio = tipos_de_medio.id
WHERE tipos_de_medio.nombre LIKE '%MPEG audio file%'

/* 4. Ranking canciones
Desde el departamento de desarrollo de Musimundos están preparando el ranking de
las canciones favoritas del público.Para ello, te piden que le pasemos el nombre de todas las canciones que están en una playlist, y el nombre de la playlist a la que pertenecen. Ojo! Tengamos cuidado de no repetir el nombre de las canciones. Para esta consulta vamos a tener que usar información de las tablas canciones, canciones_de_playlists y playlists. */

SELECT 
DISTINCT canciones.nombre AS nombre_canciones,
playlists.nombre AS nombre_playlist
FROM canciones 
INNER JOIN canciones_de_playlists
ON canciones.id = canciones_de_playlists.id_cancion
INNER JOIN playlists
ON playlists.id = canciones_de_playlists.id_playlist
ORDER BY nombre_playlist, nombre_canciones



/* FUNCIONES */

/* 1. Ranking canciones
Desde el departamento de desarrollo de Musimundos están preparando la parte de la aplicación en la cual accedemos a una canción en particular. Nos comentan que
debajo de la imagen de la canción deberá aparecer un texto específico, y necesitan nuestra ayuda. El texto tiene que ser:
"La canción " (nombre del tema) " fue compuesta por " (compositor del tema).
Hacé una consulta a nuestra base de datos que nos traiga el nombre y el compositor de cada tema, sin repeticiones y agregando el texto que el equipo de desarrollo nos mencionaba.
Ojo! Tené en cuenta los espacios dentro de los textos que nos pidieron añadir. */

SELECT DISTINCT nombre, CASE WHEN trim(compositor) = "" THEN "Desconocido" ELSE compositor END AS compositor, CONCAT("La canción ", nombre, " fue compuesta por ", CASE WHEN trim(compositor) = "" THEN "Desconocido" ELSE compositor END,".") AS resultado
FROM canciones

/* 2. Facturas
En el departamento de Finanzas de Musimundos quieren separar las facturas
dependiendo del origen de las mismas, pero les dicen que encuentran que hay
algunas columnas con resultados nulos.
Hacé una consulta a la base de datos que nos traiga la primer columna no nula que encuentre entre las columnas estado_o_provincia_de_facturacion, pais_de_facturacion y codigo_postal_de_facturacion. */

SELECT 
COALESCE(
estado_o_provincia_de_facturacion, 
pais_de_facturacion,
codigo_postal_de_facturacion) AS origen
FROM facturas

/* 3. Edad empleados
En el departamento de Recursos Humanos de Musimundos quieren saber la edad de
los empleados al momento que empezaron a trabajar en la empresa.
Hacé una consulta la base de datos que traiga la diferencia entre su fecha de
nacimiento y la fecha de contratación.
TIP: Recordá que DATEDIFF() retorna la diferencia entre las fechas expresada en
DÍAS. Teniendo esto en cuenta y sabiendo que un año pretende tener 365, cómo
realizarías la consulta? */

SELECT 
nombre, 
apellido, 
fecha_de_contratacion,
fecha_nacimiento,
floor((DATEDIFF(fecha_de_contratacion, fecha_nacimiento) / 365 )) AS edad
FROM empleados


/* 4. Última factura
En la aplicación de Musimundos, un usuario está revisando sus últimas facturas y
quiere saber en qué mes fue su última factura.
Hacé una consulta a la base de datos que traiga todas las facturas del cliente número 2 ordenadas por su fecha y extrae el mes de la misma. */

SELECT 
fecha_factura,
month(fecha_factura) AS mes_factura 
FROM facturas
WHERE id_cliente = 2
ORDER BY fecha_factura DESC



/* SUBCONSULTAS */

/* 1. Playlists
Desde el departamento de marketing quieren conocer todos los datos de la tabla de canciones que se encuentren en al menos 5 playlists. */

SELECT *
FROM canciones 
WHERE id IN (
SELECT 
id_cancion
FROM canciones_de_playlists 
GROUP BY id_cancion
HAVING COUNT(id_playlist) >= 5 )

/* 2. Facturas
En el departamento de Finanzas necesitan incluir dentro de la tabla de Facturas un total de facturas que sume la columna total.
Este valor se debe repetir en todas las filas de la tabla. */

SELECT 
* ,
(SELECT SUM(total) FROM facturas
) AS total_facturado
FROM facturas

/* 3. Clientes VIP
En el departamento de Marketing de Musimundos quieren entender cómo se
comportan los clientes.
Es por esto que nos solicitan agregar dentro de la tabla de clientes, una columna que cuente el total de facturas emitidas para cada uno de los clientes. */

SELECT 
*,
(
SELECT COUNT(*) FROM facturas WHERE clientes.id = facturas.id_cliente
) AS cant_facturas
FROM clientes


/* UNIONES
Facturas - Pivote 
Desde el departamento de finanzas necesitan un reporte, este debe contener lo siguiente: total facturado y cantidad total de facturas, (dos filas) pero solo para los meses de octubre, noviembre y diciembre del año 2010 (tres columnas). Resolver la consulta con los datos de Total facturado y luego con Cantidad de facturas. */

/* En primer instancia se recolecta la fecha de las facturas, su total por fecha y se añade una columna total_facturado que indica la suma total de las facturas de ese día, además se añade clausula where en donde se filtran las fechas por año y luego por mes. Finalmente se añade, columna de nov y dic para luego unir todas las consultas (se repite consulta para nov y dic).
Se aplica UNION ALL (ya los datos fueron filtrados, UNION ALL tiene mejor performance que UNION) para unir todas las consultas y con un SELECT se comprimen los datos en una sola fila, se puede añadir un alias para agregar una columna que indique una referencia al contenido de las filas. */

SELECT 
"Total_facturado" AS metricas,
SUM(Octubre) AS Octubre,
SUM(Noviembre) AS Noviembre,
SUM(Diciembre) AS Diciembre
FROM (
--Octubre
SELECT 
MONTH(fecha_factura) as Mes,
SUM(total) AS Octubre,
0 AS Noviembre,
0 AS Diciembre
FROM 
facturas
WHERE YEAR (fecha_factura) = 2010
AND MONTH (fecha_factura) = 10
GROUP BY MONTH(fecha_factura)
UNION ALL
--Noviembre
SELECT 
MONTH(fecha_factura) as Mes,
0 AS Octubre,
SUM(total) AS Noviembre,
0 AS Diciembre
FROM 
facturas
WHERE YEAR (fecha_factura) = 2010
AND MONTH (fecha_factura) = 11
GROUP BY MONTH(fecha_factura)
UNION ALL
--Diciembre
SELECT 
MONTH(fecha_factura) as Mes,
0 AS Octubre,
0 AS Noviembre,
SUM(total) AS Diciembre
FROM 
facturas
WHERE YEAR (fecha_factura) = 2010
AND MONTH (fecha_factura) = 12
GROUP BY MONTH(fecha_factura)

) AS total_facturado

/*Continuamos con la consulta de las cantidades de facturas, se procede de manera similar a la consulta anterior, se cambia el SUM por un COUNT y luego se unen ambas consultas para obtener una única tabla. */

UNION ALL

SELECT 
"Cantidad_total_facturas" AS metricas,
SUM(Octubre) AS Octubre,
SUM(Noviembre) AS Noviembre,
SUM(Diciembre) AS Diciembre
FROM (
--Octubre
SELECT 
MONTH(fecha_factura) as Mes,
COUNT(id) AS Octubre,
0 AS Noviembre,
0 AS Diciembre
FROM 
facturas
WHERE YEAR (fecha_factura) = 2010
AND MONTH (fecha_factura) = 10
GROUP BY MONTH(fecha_factura)
UNION ALL
--Noviembre
SELECT 
MONTH(fecha_factura) as Mes,
0 AS Octubre,
COUNT(id) AS Noviembre,
0 AS Diciembre
FROM 
facturas
WHERE YEAR (fecha_factura) = 2010
AND MONTH (fecha_factura) = 11
GROUP BY MONTH(fecha_factura)
UNION ALL
--Diciembre
SELECT 
MONTH(fecha_factura) as Mes,
0 AS Octubre,
0 AS Noviembre,
COUNT(id) AS Diciembre
FROM 
facturas
WHERE YEAR (fecha_factura) = 2010
AND MONTH (fecha_factura) = 12
GROUP BY MONTH(fecha_factura)

) AS Cantidad_total_facturas