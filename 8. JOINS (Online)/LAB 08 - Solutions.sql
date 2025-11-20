-- LAB 8 - SOLUTIONS
/*
 You need to use the classicmodels database.
1. Retrieve a list of customers whose city is Madrid along
 with details of their orders. Include customer information
 such as customer name as name, and city, along with order
 details such as order date, total amount, and status.
 Display the results ordered by the order date in descending
 order where order status is ‘In Process’.
 */
USE classicmodels;

SELECT c.customerName AS name, c.city, o.orderDate, o.status
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE c.city = 'Madrid'
AND o.status = 'In Process'
ORDER BY o.orderDate ASC;

/*
 You need to use the sakila database.
2. Retrieve all customers whose city is Abu Dhabi.
 ( note: you should get city from city table)
 */

 USE sakila;
SELECT c.*
FROM customer c
JOIN address a
ON c.address_id = a.address_id
JOIN city ci
ON ci.city_id = a.city_id
WHERE ci.city = 'Abu Dhabi';

/*
3. Write a SQL query to retrieve information about actors
who acted in films released in the year 2006 and
have first names starting with the letter 'A'.
Include same person only once.
 */

 SELECT DISTINCT a.actor_id, a.first_name, a.last_name
 FROM actor a
 JOIN film_actor fa
 ON a.actor_id = fa.actor_id
 JOIN film f
 ON fa.film_id = f.film_id
 WHERE f.release_year = 2006
AND a.first_name LIKE 'A%';

/*
 You need to use the classicmodels database.
4. Retrieve all customers whose city is 'San Francisco'
 along with their orders. Include customer details such as
 customerName as name, city, and order details such as
 orderDate, status, and comments. Display the results
 ordered by orderDate in descending order where the status
 is 'Shipped'.
 */

 USE classicmodels;
SELECT
c.customerName as name, c.city, o.orderDate, o.status, o.comments
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE c.city = 'San Francisco'
AND o.status = 'Shipped'
ORDER BY o.orderDate DESC;

/*
 5. Retrieve information about employees who work in offices
 located in 'Paris'. Include employeeNumber, lastName,
 firstName, and jobTitle.
 */

 SELECT e.employeeNumber, e.lastName, e.firstName, e.jobTitle
FROM employees e
 JOIN offices o
 ON e.officeCode = o.officeCode
 WHERE o.city = 'Paris';

/*
6. Retrieve all customers along with the names of the
sales representatives who manage them.
 */

 SELECT c.customerName, e.employeeNumber AS salesRepEmployeeNumber,
        e.lastName AS salesRepLastName, e.firstName AS salesRepFirstName
 FROM customers c
 LEFT JOIN employees e
 ON c.salesRepEmployeeNumber = e.employeeNumber
 ORDER BY c.customerName ASC;

/*
7. Retrieve all orders along with the name of the customers
who placed them. Display the results ordered by orderDate
in descending order.
 */
SELECT o.orderNumber, o.orderDate,
       c.customerName, o.status
FROM orders o
LEFT JOIN customers c
ON o.customerNumber = c.customerNumber
ORDER BY o.orderDate DESC;

/*
8. Retrieve all products in orders with a status of
'Shipped'. Include orderNumber, productCode,
quantityOrdered, priceEach, and status.
 */
SELECT o.orderNumber, od.productCode,
       od.quantityOrdered, od.priceEach,
       o.status
FROM orders o
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
WHERE o.status = 'Shipped';

/*
9. Retrieve all employees and the offices they work in.
 */
SELECT e.employeeNumber, e.lastName, e.firstName,
       o.city, o.country
FROM employees e
JOIN offices o
ON e.officeCode = o.officeCode;

/*
10. Retrieve all products along with the names of their
product lines. Include productCode, productName,
productLine, and productDescription.
 */
SELECT p.productCode, p.productName, p.productLine, p.productDescription
FROM products p;

SELECT p.productCode, p.productName,
       pl.productLine, p.productDescription
FROM products p
JOIN productlines pl
ON p.productLine = pl.productLine;

/*
11. Retrieve the names of customers who have placed orders
along with the order details. Include customerName,
orderNumber, orderDate, and status. Sort by customerName
and then by orderDate in descending order.
 */
 SELECT c.customerName, o.orderNumber, o.orderDate, o.status
 FROM customers c
 JOIN orders o
 ON c.customerNumber = o.customerNumber
 ORDER BY c.customerName ASC, o.orderDate DESC;

/*
12. Retrieve all products that have been ordered along with
their quantities. Include productName, orderNumber,
and quantityOrdered. Sort the results by productName.
 */
SELECT p.productName, od.orderNumber, od.quantityOrdered
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
ORDER BY p.productName;

/*
13. Retrieve the names of employees who report to another
employee along with their manager's name. Include
employeeNumber, employeeName (first and last name),
reportsTo, and managerName.
 */
SELECT e.employeeNumber,
       CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
       e.reportsTo,
       CONCAT(m.firstName, ' ', m.lastName) AS managerName
FROM employees e
LEFT JOIN employees m
       ON e.reportsTo = m.employeeNumber
ORDER BY e.employeeNumber;

/*
14. Retrieve a list of customers along with details of their
orders. Include customer information such as customer name
and city, along with order details such as order number and
order date. Filter the results to include only orders placed
in the year 2005, and display the results ordered by the
customer name in ascending order.
*/
SELECT c.customerName, c.city,
       o.orderNumber, o.orderDate
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE YEAR(o.orderDate) = 2005
ORDER BY c.customerName ASC;

/*
15. Retrieve a list of products and their order details for
orders where the status is 'Shipped'. Include product
information such as product code and product name, along
with order details such as order number, order date, and
quantity ordered. Display the results ordered by product
code in ascending order.
 */
SELECT
    p.productCode,
    p.productName,
    o.orderNumber,
    o.orderDate,
    od.quantityOrdered
FROM products p
JOIN orderdetails od
    ON p.productCode = od.productCode
JOIN orders o
    ON od.orderNumber = o.orderNumber
WHERE o.status = 'Shipped'
ORDER BY p.productCode ASC;

/*
 You need to use the sakila database.
16. Retrieve a list of customers along with their rental
 details. Include customer information such as customer
 name, along with rental details such as rental date,
 return date, and film title. Display the results
 ordered by rental date in descending order.
 */
USE sakila;
SELECT c.first_name AS customerFirstName, c.last_name AS customerLastName,
       r.rental_date, r.return_date,
       f.title AS filmTitle
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY r.rental_date DESC;

/*
17. Retrieve a list of staff members along with their store
information. Include staff details such as staff name and
email, and store details such manager name. Display the
results ordered by staff name in ascending order.
 */
SELECT
    s1.first_name AS staffFirstName,
    s1.last_name AS staffLastName,
    s1.email AS staffEmail,
    s2.manager_staff_id,
    CONCAT(m.last_name, ' ', m.first_name) AS StoreManagerName
FROM
    staff s1
JOIN
    store s2 ON s1.store_id = s2.store_id
JOIN
    staff m ON s2.manager_staff_id = m.staff_id
ORDER BY staffFirstName;

/*
18. Retrieve all customers along with the names
of the stores they belong to. Include customer_id,
first_name, last_name, and store_id. Sort the
results by last_name in ascending order.
 */
SELECT c.customer_id, c.first_name, c.last_name,
       s.store_id
FROM customer c
JOIN store s
ON c.store_id = s.store_id
ORDER BY c.last_name ASC;

/*
19. Retrieve all rentals along with the
full names of the customers who rented the
films. Include rental_id, rental_date,
first_name, and last_name. Display the results
ordered by rental_date in descending order.
 */
SELECT r.rental_id, r.rental_date,
       c.first_name, c.last_name
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
ORDER BY r.rental_date DESC;

/*
20. Retrieve all films along with their corresponding
categories. Include film_id, title, name
(category name), and description.
Sort the results by title in ascending order.
 */
SELECT f.film_id, f.title,
       c.name AS category_name, f.description
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
ORDER BY f.title ASC;

/*
21. Retrieve all actors who appeared in the film
'Academy Dinosaur'. Include actor_id, first_name,
last_name, and title.
 */
SELECT a.actor_id, a.first_name, a.last_name,
       f.title
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON fa.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur';

/*
22. Retrieve all staff members and the stores
they work in. Include staff_id, first_name,
last_name, store_id, and address.
 */

#For address of the staff
SELECT st.staff_id, st.first_name, st.last_name,
       s.store_id, a.address
FROM staff st
JOIN store s
ON st.store_id = s.store_id
JOIN address a
ON a.address_id = st.address_id;

#For address of the store
SELECT st.staff_id, st.first_name, st.last_name,
       s.store_id, a.address
FROM staff st
JOIN store s
ON st.store_id = s.store_id
JOIN address a
ON a.address_id = s.address_id;

/*
23. Retrieve all films that have been rented
along with their rental dates. Include title,
rental_date, and return_date. Sort the results
by rental_date in descending order.
 */
SELECT f.title, r.rental_date, r.return_date
FROM rental r
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
ORDER BY r.rental_date DESC;

/*
24. Retrieve all films in the 'Action' category
along with their actors. Include title, first_name,
and last_name.
 */

#Correct number of rows: 363

SELECT f.title, a.first_name, a.last_name
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
JOIN film_actor fa
ON fa.film_id = f.film_id
JOIN actor a
ON fa.actor_id = a.actor_id
WHERE c.name = 'Action';

/*
25. Retrieve all customers and the films they
rented. Include first_name, last_name, title,
and rental_date. Display the results ordered
by rental_date in ascending order.
 */
SELECT c.first_name, c.last_name,
       f.title,
       r.rental_date
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
ORDER BY r.rental_date;

/*
26. Retrieve all films along with the stores
where they are available. Include title, store_id,
and inventory_id.
 */
SELECT
    f.title,
    i.store_id,
    i.inventory_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
ORDER BY f.title, i.store_id, i.inventory_id;

/*
27. Retrieve all films that have been rented
by customers from the city of 'Aurora'.
Include title, first_name, last_name, and rental_date.
 */
SELECT f.title,
       c.first_name, c.last_name,
       r.rental_date
FROM city ci
JOIN address a
ON ci.city_id = a.city_id
JOIN customer c
ON a.address_id = c.address_id
JOIN rental r
ON c.customer_id = r.customer_id
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
WHERE ci.city = 'Aurora'
ORDER BY f.title;

/*
28. Retrieve all films rented by customers who
live in cities within the country 'Canada'.
Include title, first_name, last_name, city,
rental_date. Display the results ordered by
city and then by rental_date in descending
order.
 */
SELECT f.title,
       c.first_name, c.last_name,
       ci.city,
       r.rental_date
FROM country co
JOIN city ci
ON co.country_id = ci.country_id
JOIN address a
ON ci.city_id = a.city_id
JOIN customer c
ON a.address_id = c.address_id
JOIN rental r
ON c.customer_id = r.customer_id
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
WHERE co.country = 'Canada'
ORDER BY ci.city, r.rental_date DESC;
