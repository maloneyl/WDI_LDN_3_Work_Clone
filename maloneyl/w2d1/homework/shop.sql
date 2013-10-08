CREATE TABLE products
(
  id serial4 primary key,
  created_at date,
  name varchar(50),
  on_sale boolean,
  price real
);

CREATE TABLE users
(
  id serial4 primary key,
  created_at date,
  name varchar(50)
);

CREATE TABLE wishlists
(
  id serial4 primary key,
  created_at date,
  user_id int4 references users(id),
  product_id int4 references products(id)
);

INSERT INTO products (created_at, name, on_sale, price) VALUES ('1/1/2013', 'orange juice', 'false', '0.50');
INSERT INTO products (created_at, name, on_sale, price) VALUES ('1/6/2013', 'smoked salmon cream cheese', 'yes', '2.50');
INSERT INTO products (created_at, name, on_sale, price) VALUES ('10/6/2013', 'bourbon whiskey', 'yes', '20.20');
INSERT INTO users (created_at, name) VALUES ('12/12/2012', 'Amanda');
INSERT INTO users (created_at, name) VALUES ('12/11/2011', 'Ben');
INSERT INTO users (created_at, name) VALUES ('9/7/2013', 'Derek');
# INSERT INTO users (created_at, name) VALUES ('10/7/2013', 'Jonathan')

# INSERT INTO wishlists (created_at, user_id, product_id) VALUES (LOCALTIMESTAMP, (), ())