CREATE TABLE actors_movies
(
  id serial4 primary key,
  actor_id int4 references actors(id),
  movie_id int4 references movies(id)
);  

INSERT INTO actors_movies (actor_id, movie_id) VALUES (1, 7);
INSERT INTO actors_movies (actor_id, movie_id) VALUES (3, 6);
INSERT INTO actors_movies (actor_id, movie_id) VALUES (4, 3);
INSERT INTO actors_movies (actor_id, movie_id) VALUES (5, 2);
INSERT INTO actors_movies (actor_id, movie_id) VALUES (10, 6);