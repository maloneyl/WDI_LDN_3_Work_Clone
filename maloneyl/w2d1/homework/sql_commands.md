## Write SQL statements for the included DB that:

1. Selects the names of all products that are not on sale.
``````
SELECT name FROM products WHERE on_sale= 'f';
``````

2. Selects the names of all products that cost less than £20.
``````
SELECT name FROM products WHERE price < 20;
``````

3. Selects the name and price of the most expensive product.
``````
SELECT name, price FROM products ORDER BY price DESC LIMIT 1;
``````
or (from homework review):
``````
SELECT name MAX(price) AS max_price FROM products;
``````
NOTE that your labeling of the "AS" will become the column heading in your result table

4. Selects the name and price of the second most expensive product.
``````
SELECT name, price FROM products ORDER BY price DESC OFFSET 1 LIMIT 1;
``````

5. Selects the name and price of the least expensive product.
``````
SELECT name, price FROM products ORDER BY price ASC LIMIT 1;
``````
or (from homework review):
``````
SELECT name MIN(price) AS min_price FROM products;
``````

6. Selects the names and prices of all products, ordered by price in descending order.
``````
SELECT name, price FROM products ORDER BY price DESC;
``````

7. Selects the average price of all products.
``````
SELECT AVG(price) AS average_price FROM products;
``````
or (from homework review):
``````
SELECT AVG(price) FROM products;
``````

8. Selects the sum of the price of all products.
``````
SELECT SUM(price) AS total_price FROM products;
``````

9. Selects the sum of the price of all products whose prices is less than £20.
``````
SELECT SUM(price) AS total_price_of_cheap_enough_products FROM products WHERE price < 20;
``````

10. Selects the id of the user with your name.
``````
SELECT id FROM users WHERE name = 'Maloney';
``````
  
11. Selects the names of all users whose names start with the letter "A".
``````
SELECT name FROM users WHERE name LIKE 'A%';
``````

12. Selects the number of users whose first names are "Jonathan".
``````
SELECT COUNT(*) FROM users WHERE name = 'Jonathan';
``````
oops, forgot our table's 'name' column isn't first-name-only. answer from homework review:
``````
SELECT COUNT(id) FROM users WHERE name = 'Jonathan %';
``````

13. Selects the number of users who want a "Teddy Bear".
``````
SELECT COUNT(*) FROM wishlists WHERE product_id = (SELECT id FROM products WHERE name = 'Teddy Bear');
``````
v.s. this answer from homework review -- use IN instead of '=' because the latter will only work if there's one result:
``````
SELECT COUNT(users) FROM wishlists WHERE product_id IN (SELECT id FROM products WHERE name = 'Teddy Bear');
``````

14. Selects the count of items on the wishlish of the user with your name.
``````
SELECT COUNT(*) FROM wishlists WHERE user_id = (SELECT id FROM users WHERE name = 'Maloney');
``````
v.s. this answer from homework review -- again, use IN instead:
``````
SELECT COUNT(users) FROM wishlists WHERE user_id IN (SELECT id FROM products WHERE name = 'Maloney');
``````

15. Selects the count and name of all products on the wishlist, ordered by count in descending order.
``````
SELECT COUNT(*), (SELECT name FROM products WHERE wishlists.product_id = products.id) FROM wishlists GROUP BY product_id ORDER BY COUNT DESC;
``````
v.s. this answer from homework review:
``````
SELECT name, COUNT(id) AS products_count FROM products WHERE product_id IN
(SELECT product_id FROM wishlists) GROUP BY name ORDER BY products_count DESC;
``````
subrequests work, but you can join tables too (which we'll learn later)

16. Selects the count and name of all products that are not on sale on the wishlist, ordered by count in descending order. ****
``````
SELECT COUNT(*), name FROM products WHERE on_sale = 'f' IN (SELECT product_id FROM wishlists WHERE products.id = wishlists.product_id) GROUP BY on_sale ORDER BY COUNT DESC; / SELECT COUNT(*), (SELECT name FROM products WHERE wishlists.product_id = products.id), (SELECT on_sale FROM products WHERE products.on_sale = 'f') FROM wishlists ORDER BY COUNT DESC;
``````
v.s. this answer from homework review -- you can add a double WHERE condition with AND:
``````
SELECT name, COUNT(id) AS products_count FROM products WHERE on_sale = 'f' AND product_id IN (SELECT product_id FROM wishlists) GROUP BY name ORDER BY products_count DESC;
``````

17. Inserts a user with the name "Jonathan Postel" into the users table. Ensure the created_at column is set to the current time.
``````
INSERT INTO users (created_at, name) VALUES (LOCALTIMESTAMP, 'Jonathan Postel');
``````
v.s. this answer from homework review:
``````
INSERT INTO users (name, created_at) VALUES ('Jonathan Postel', NOW());
``````
NOW is another SQL function


18. Selects the id of the user with the name "Jonathan Postel"? Ensure the created_at column is set to the current time.
``````
SELECT id FROM users WHERE name = 'Jonathan Postel';
``````
v.s. this answer from homework review:
``````
SELECT id FROM users WHERE name = 'Jonathan Postel' AND created_at = NOW();
``````

19. Inserts a wishlist entry for the user with the name "Jonathan Postel" for the product "The Ruby Programming Language".
``````
INSERT INTO wishlists (created_at, user_id, product_id) VALUES (LOCALTIMESTAMP, (SELECT id FROM users WHERE name = 'Jonathan Postel'), (SELECT id FROM products WHERE name = 'The Ruby Programming Language'));
``````

20. Updates the name of the "Jonathan Postel" user to be "Jon Postel".
``````
UPDATE users SET name = 'Jon Postel' WHERE name = 'Jonathan Postel';
``````

21. Deletes the user with the name "Jon Postel".
``````
DELETE FROM users WHERE name = 'Jon Postel';
``````

22. Deletes the wishlist item for the user you just deleted. ****
``````
DELETE FROM wishlist WHERE user_id = (SELECT id FROM users WHERE name = 'Jon Postel');
``````
correct answer from homework review:
``````
DELETE FROM wishlists WHERE user_id NOT IN (SELECT id FROM users);
``````



Products
id
created_at
name
on_sale (Boolean)
Price

Users
id
created_at
name

wishlists
id
created_at
user_id
product_id