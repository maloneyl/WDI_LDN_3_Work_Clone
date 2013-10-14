create table actors
  (
    id serial4 primary key,
    first_name varchar(255),
    last_name varchar(255),
    dob date,
    image_url text
  );

INSERT INTO actors (first_name, last_name, dob, image_url)
VALUES ('Jon', 'Heder', '1977-10-26', 'http://upload.wikimedia.org/wikipedia/commons/7/7c/Jon_Heder_by_Gage_Skidmore.jpg');

INSERT INTO actors (first_name, last_name, dob, image_url)
VALUES ('James', 'McAvoy', '1979-04-21', 'http://upload.wikimedia.org/wikipedia/commons/f/f4/James_McAvoy.jpg');

INSERT INTO actors (first_name, last_name, dob, image_url)
VALUES ('Cate', 'Blanchett', '1969-05-14', 'http://upload.wikimedia.org/wikipedia/commons/4/4f/Cate_Blanchett_2011.jpg');

INSERT INTO actors (first_name, last_name, dob, image_url)
VALUES ('Natalie', 'Portman', '1981-06-09', 'http://upload.wikimedia.org/wikipedia/commons/8/8c/Natalie_Portman_%2883rd_Academy_Awards%29_cropped.jpg');

INSERT INTO actors (first_name, last_name, dob, image_url)
VALUES ('Daniel', 'Radcliffe', '1989-07-23', 'http://upload.wikimedia.org/wikipedia/commons/2/25/Daniel_Radcliffe_2011_%28Straighten_Colors%29.jpg');

INSERT INTO actors (first_name, last_name, dob, image_url)
VALUES ('Colin', 'Firth', '1960-09-10', 'http://upload.wikimedia.org/wikipedia/commons/4/4b/Colin_Firth_%28Berlin_Film_Festival_2011%29.jpg');

INSERT INTO actors (first_name, last_name, dob, image_url)
VALUES ('Sandra', 'Bullock', '1964-07-26', 'http://upload.wikimedia.org/wikipedia/commons/d/da/Sandra_Bullock%2C_The_Heat%2C_London%2C_2013_%28crop%29.jpg');

INSERT INTO actors (first_name, last_name, dob, image_url)
VALUES ('George', 'Clooney', '1961-05-06', 'http://upload.wikimedia.org/wikipedia/commons/3/36/George_Clooney_2012.jpg');

INSERT INTO actors (first_name, last_name, dob, image_url)
VALUES ('Benedict', 'Cumberbatch', '1976-07-19', 'http://upload.wikimedia.org/wikipedia/commons/c/c3/Benedict_Cumberbatch_2011_%28jpg%29.jpg');



