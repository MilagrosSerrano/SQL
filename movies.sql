/*  CONSULTAS  */

/* SELECT

1. Mostrar todos los registros de la tabla de movies.
2. Mostrar el nombre, apellido y rating de todos los actores.
3. Mostrar el título de todas las series.*/



SELECT * FROM movies;

SELECT first_name, last_name, rating FROM actors;

SELECT title FROM series;


/* WHERE Y ORDER BY

4. Mostrar el nombre y apellido de los actores cuyo rating sea mayor a 7,5.
5. Mostrar el título de las películas, el rating y los premios de las películas con
un rating mayor a 7,5 y con más de dos premios.
6. Mostrar el título de las películas y el rating ordenadas por rating en forma
ascendente. */

SELECT first_name, last_name FROM actors WHERE rating > 7.5;

SELECT title, rating, awards FROM movies WHERE rating > 7.5 AND awards > 2;

SELECT title, rating FROM movies ORDER BY rating ASC;

/* BETWEEN y LIKE
7. Mostrar el título y rating de todas las películas cuyo título incluya Toy Story.
8. Mostrar a todos los actores cuyos nombres empiecen con Sam.
9. Mostrar el título de las películas que salieron entre el ‘2004-01-01’ y
‘2008-12-31’. */

SELECT title, rating FROM movies WHERE title LIKE '%Toy Story%';

SELECT first_name, last_name FROM actors WHERE first_name LIKE 'Sam%';

SELECT title, release_date FROM movies WHERE release_date BETWEEN '2004-01-01' AND '2008-12-31';

/* Alias, limit y offset
10. Mostrar el título de todas las series y usar alias para que el nombre del campo esté en
español.
11. Traer el título de las películas con el rating mayor a 3, con más de 1 premio y con fecha de
lanzamiento entre el año ‘1988-01-01’ al ‘2009-12-31’. Ordenar los resultados por rating
descendentemente.
12. Traer el top 3 a partir del registro 10 de la consulta anterior.
13. ¿Cuáles son los 3 peores episodios teniendo en cuenta su rating?
14. Obtener el listado de todos los actores. Quitar las columnas de fechas y película favorita,
además traducir los nombres de las columnas. */

SELECT title as titulo FROM series;

SELECT title, rating, awards, release_date
FROM movies
WHERE rating > 3
  AND awards > 1
  AND release_date BETWEEN '1988-01-01' AND '2009-12-31'
ORDER BY rating DESC;

SELECT title, rating, awards, release_date
FROM movies
WHERE rating > 3
  AND awards > 1
  AND release_date BETWEEN '1988-01-01' AND '2009-12-31'
ORDER BY rating DESC
LIMIT 3 OFFSET 10;

SELECT title, rating, awards, release_date
FROM movies
WHERE rating > 3
  AND awards > 1
  AND release_date BETWEEN '1988-01-01' AND '2009-12-31'
ORDER BY rating ASC
LIMIT 3;

SELECT 
first_name AS nombre,
last_name AS apellido,
rating AS puntuacion
FROM actors
ORDER BY puntuacion DESC;


/* Funciones de agregación, GROUP BY y HAVING
1. ¿Cuántas películas hay?
2. ¿Cuántas películas tienen entre 3 y 7 premios?
3. ¿Cuántas películas tienen entre 3 y 7 premios y un rating mayor a 7?
4. Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por id. de género.
5. De la consulta anterior, listar sólo aquellos géneros que tengan como suma de
premios un número mayor a 5. */

SELECT SUM(id) AS cantidad_peliculas
FROM movies;

SELECT title, awards
FROM movies
WHERE awards BETWEEN '3' AND '7';

SELECT title, awards, rating
FROM movies
WHERE awards BETWEEN '3' AND '7' AND rating > 7;

SELECT genre_id, COUNT(genre_id) AS cant_genre
FROM movies
GROUP BY genre_id;

SELECT genre_id, COUNT(genre_id) AS cant_genre, SUM(awards) AS total_awards
FROM movies
GROUP BY genre_id
HAVING SUM(awards) > 5;