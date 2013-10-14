create table movies
  (
    id serial4  primary key,
    title varchar(255),
    poster text,
    year varchar(4),
    rated varchar(10),
    genre varchar(100),
    director varchar(100),
    writers varchar(200),
    actors varchar(200)
    );

INSERT INTO movies (title, year, rated, genre, director, writers, actors, poster) 
VALUES ('Rocky','1976', '4', 'Drama', 'John G. Avildsen', 'Sylvester Stallone','Sylvester Stallone, Talia Shire, Burt Young', 'http://ia.media-imdb.com/images/M/MV5BMTY5MDMzODUyOF5BMl5BanBnXkFtZTcwMTQ3NTMyNA@@._V1_SX214_.jpg');

INSERT INTO movies (title, year, rated, genre, director, writers, actors, poster) 
VALUES ('Harry Potter and the Sorcerers Stone','2001', '3', 'Adventure', 'Chris Columbus', 'J.K. Rowling','Daniel Radcliffe, Rupert Grint, Richard Harris', 'http://ia.media-imdb.com/images/M/MV5BMTYwNTM5NDkzNV5BMl5BanBnXkFtZTYwODQ4MzY5._V1_SY317_CR8,0,214,317_.jpg');

INSERT INTO movies (title, year, rated, genre, director, writers, actors, poster) 
VALUES ('The Professional','1994', '5', 'Thriller', 'Luc Besson', 'Luc Besson','Jean Reno, Gary Oldman, Natalie Portman', 'http://ia.media-imdb.com/images/M/MV5BMTgzMzg4MDkwNF5BMl5BanBnXkFtZTcwODAwNDg3OA@@._V1_SY317_CR4,0,214,317_.jpg');

INSERT INTO movies (title, year, rated, genre, director, writers, actors, poster) 
VALUES ('The Kings Speech','2010', '5', 'Biography', 'Tom Hooper', 'David Seidler','Colin Firth, Geoffrey Rush, Helena Bonham Carter', 'http://ia.media-imdb.com/images/M/MV5BMzU5MjEwMTg2Nl5BMl5BanBnXkFtZTcwNzM3MTYxNA@@._V1_SY317_CR1,0,214,317_.jpg');