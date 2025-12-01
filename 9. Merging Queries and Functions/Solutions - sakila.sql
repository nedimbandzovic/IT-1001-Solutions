 -- Task 3
 -- Create a detailed contact list containing the names and contact details of all customers and staff members. Display the contact type ('Customer' or 'Staff'), name, phone number, and email address. Order the results alphabetically by contact type and then by name.
(SELECT 'Customer' AS contact_type, CONCAT(first_name, ' ', last_name) AS name, email
FROM customer)

UNION

(SELECT 'Staff' AS contact_type, CONCAT(first_name, ' ', last_name) AS name, email
FROM staff)
ORDER BY contact_type, name;

-- Task 4
--Write a query to display the film title, rental date, and return date for all rentals that have already been returned (i.e., the return date is not NULL and earlier than the current date). Sort the results by rental date.

SELECT f.title AS 'film_title', r.rental_date, r.return_date FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
AND r.return_date < NOW()
ORDER BY r.rental_date;

--Task 5

SELECT DISTINCT f.title FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE QUARTER(r.rental_date) IN (1, 2)
ORDER BY f.title;

--Task 6

SELECT DISTINCT c.customer_id FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING COUNT(r.rental_id) > 0  

-- Task 22

SELECT c.customer_id, c.first_name, c.last_name, p.amount, p.payment_date FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
ORDER BY p.payment_date DESC;

--Task 23

SELECT DISTINCT r.customer_id FROM rental r
JOIN payment p ON r.customer_id = p.customer_id
WHERE YEAR(r.rental_date) = 2005 AND YEAR(p.payment_date) = 2005
ORDER BY r.customer_id;

--Task 24

SELECT DISTINCT f.title FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL
ORDER BY f.title;

--Task 25

SELECT staff_id
FROM payment

UNION

SELECT staff_id
FROM rental;


