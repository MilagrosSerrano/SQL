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

/* CONSULTAS */

/* JOIN - PARTE I */

/* 1. Utilizando la base de datos de movies, queremos conocer, por un lado, los títulos y el nombre del género de todas las series de la base de datos.
2. Por otro lado, necesitamos listar los títulos de los episodios junto con el nombre y apellido de los actores que trabajan en cada uno de ellos.
3. Para nuestro próximo desafío, necesitamos obtener a todos los actores o actrices (mostrar nombre y apellido) que han trabajado en cualquier película de la saga de La Guerra de las Galaxias.
4. Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por nombre de género. */

SELECT series.title, genres.name 
FROM series
INNER JOIN genres
ON series.genre_id = genres.id

SELECT episodes.title, actors.first_name, actors.last_name
FROM episodes
INNER JOIN actor_episode
ON episodes.id = actor_episode.episode_id
INNER JOIN actors 
ON actor_episode.actor_id = actors.id

SELECT DISTINCT actors.first_name, actors.last_name,  movies.title
FROM movies
INNER JOIN actor_movie
ON movies.id = actor_movie.movie_id
INNER JOIN actors 
ON actor_movie.actor_id = actors.id
WHERE movies.title LIKE 'La Guerra de las Galaxias%'
ORDER BY actors.first_name

SELECT genres.name, COUNT(genre_id) AS cant_genre
FROM movies
RIGHT JOIN genres
ON movies.genre_id = genres.id
GROUP BY genres.name

/* JOIN - PARTE II */ 

/* 1. Obtener los artistas que han actuado en una o más películas.
2. Obtener las películas donde han participado más de un artista según nuestra base de datos.
3. Obtener los artistas junto con los datos de las películas en las que han actuado. Incluir aquellos artistas que no han actuado en ninguna película.
4. Obtener las películas que no se le han asignado artistas en nuestra base de datos.
5. Obtener aquellos artistas que no han actuado en alguna película, según nuestra base de datos.
6. Obtener aquellos artistas que han actuado en dos o más películas según nuestra base de datos. */

SELECT actors.first_name, actors.last_name
FROM actors
INNER JOIN actor_movie
ON actors.id = actor_movie.actor_id
GROUP BY actors.first_name, actors.last_name
HAVING COUNT(actor_movie.movie_id) >= 2;


SELECT movies.title
FROM movies
INNER JOIN actor_movie
ON movies.id = actor_movie.movie_id
GROUP BY movies.title
HAVING COUNT(actor_movie.actor_id) >= 2;


SELECT actors.first_name, actors.last_name, movies.title
FROM actors
LEFT JOIN actor_movie
ON actors.id = actor_movie.actor_id
LEFT JOIN movies 
ON actor_movie.movie_id = movies.id
ORDER BY actors.first_name, actors.last_name, movies.title;


SELECT movies.title
FROM movies
LEFT JOIN actor_movie
ON movies.id = actor_movie.movie_id
WHERE actor_movie.actor_id is null


SELECT actors.first_name, actors.last_name
FROM actors
LEFT JOIN actor_movie
ON actors.id = actor_movie.actor_id
WHERE actor_movie.id is null

SELECT actors.first_name, actors.last_name
FROM actors 
INNER JOIN actor_movie
ON actors.id = actor_movie.actor_id
GROUP BY actors.first_name, actors.last_name
HAVING COUNT(actor_movie.movie_id) >= 2


/* SUBCONSULTAS */

/* 1. Generar una consulta que devuelva como resultado todas las películas cuyo rating esté por arriba del promedio. */

SELECT 
title,
rating, 
(SELECT AVG(rating) FROM movies) AS rating_promedio
FROM movies
WHERE rating >= 
(
  SELECT AVG(rating) FROM movies
)

/* 2. Modificar la consulta anterior, agregando un filtro en el cálculo del promedio, excluyendo los que tienen rating = 0.
Esto es para que el promedio del rating no esté afectado por los ceros. */

SELECT 
title,
rating, 
(SELECT AVG(rating) FROM movies) AS rating_promedio
FROM movies
WHERE rating >= 
(
  SELECT AVG(rating) FROM movies WHERE rating <> 0
)


/* 3. Generar una consulta que evalúe todos los actores que no han actuado en una película ni tampoco en una serie. */

SELECT * FROM actors
WHERE actors.id NOT IN (SELECT actor_id FROM actor_movie)
AND actors.id NOT IN (SELECT actor_id FROM actor_episode)

/* CONSULTAS UNION  */

/* Entretenimiento:
Generar un resultado que combine los nombres de las películas y los nombres de las series.
Adicionalmente debe contener el género de la película o serie. Y una columna adicional que sea “Tipo de entretenimiento” con los valores de película o serie. */

SELECT 
movies.title AS Titulo, 
genres.name AS Genero, 
"Pelicula" AS Tipo_entretenimiento
FROM movies
JOIN genres 
ON movies.genre_id = genres.id
UNION ALL
SELECT 
series.title AS Titulo, 
genres.name AS Genero, 
"Serie" AS Tipo_entretenimiento
FROM series
JOIN genres 
ON series.genre_id = genres.id
ORDER BY Genero

/* Movies
El administrador de la base de datos creó una nueva tabla para los inserts nuevos de películas. Estos se encontraran en la tabla Movies_2020.
Cómo resultado, debemos crear una query que consolide los nombres de las películas de la tabla de Movies y Movies_2020.
¿Qué sucede si en vez de Union all empleamos Union? */

SELECT 
movies.title AS Titulo
FROM movies
UNION
SELECT 
movies_2020.title AS Titulo
FROM movies_2020
ORDER BY Titulo

/* Si se utiliza UNION ALL en lugar de UNION, se obtendrían datos repetidos, ya que hay títulos que se encuentran en ambas tablas. */