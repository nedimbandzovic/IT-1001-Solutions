/*
You need to use the classicmodels database.

1. Show each payment made with an amount greater
than 5000, with the customer name and the average
payment amount for that customer.

Output: customerName, checkNumber, paymentDate, amount, avg_amount_customer.
 */

USE classicmodels;

SELECT
    c.customerName,
    p.checkNumber,
    p.paymentDate,
    p.amount,
    AVG(p.amount) OVER (
        PARTITION BY p.customerNumber
        ) AS avg_amount_customer
FROM payments p
JOIN customers c ON p.customerNumber = c.customerNumber
WHERE p.amount > 5000;

/*
2. Show check number, customer number, payment amount,
and payment rank per customer (highest to lowest).
 */

SELECT
    checkNumber,
    customerNumber,
    amount,
    RANK() OVER (
        PARTITION BY customerNumber
        ORDER BY amount DESC
        ) AS payment_rank
FROM payments;

/*
3. Show each Sales Rep employee with their office city
and the number of Sales Reps in that city.
Output: employeeNumber, firstName, lastName, city, salesrep_count_city.
 */
SELECT
    e.employeeNumber,
    e.firstName,
    e.lastName,
    o.city,
    COUNT(*) OVER (
        PARTITION BY o.city
        ) AS salesrep_count_city
FROM employees e
JOIN offices o
    ON e.officeCode = o.officeCode
WHERE e.jobTitle = 'Sales Rep';

/*
4. Show the payment check number,
payment amount, and the ove rall
average payment amount.
 */

SELECT
    checkNumber,
    amount,
    AVG(amount) OVER () AS avg_payment
FROM payments
ORDER BY amount;

/*
You need to use the sakila database.

5. Show film title, length, and average film
length of all films.
 */

USE sakila;

SELECT
    title,
    length,
    AVG(length) OVER () AS avg_film_length
FROM film
order by length;

/*
6. Display each rental along with the first rental
date of the same customer.
Show rental ID, customer ID, rental date, and first rental date.
 */

SELECT
    rental_id,
    customer_id,
    rental_date,
    MIN(rental_date) OVER (
        PARTITION BY customer_id
        ) AS first_rental_date
FROM rental;
/*
7. Display each payment along with the running
total per customer ordered by payment date.
Show customer ID, payment date, amount, and running total.
 */

SELECT
    customer_id,
    payment_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY payment_date
        ) AS running_total
FROM payment
ORDER BY customer_id, payment_date;

/*
8. Show each active staff member with store_id
and the number of active staff in that store.
Output: staff_id, first_name, last_name,
store_id, staff_count_store.
 */

SELECT
    staff_id,
    first_name,
    last_name,
    store_id,
    COUNT(*) OVER () AS staff_count_store
FROM staff
WHERE active = 1;

/*
9. Find the films with the average rental duration,
and rank them based on their average
rental duration.
 */

SELECT
    f.film_id,
    f.title,
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS avgRentalDuration,
    RANK() OVER (ORDER BY AVG(DATEDIFF(r.return_date, r.rental_date)) DESC) AS rentalDurationRank
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL
GROUP BY f.film_id, f.title
ORDER BY avgRentalDuration DESC;

/*
You need to use the classicmodels database.

10. Calculate the percentage contribution
of each product to the total sales revenue.
 */

USE classicmodels;
SELECT
    p.productName,
    SUM(od.quantityOrdered * od.priceEach) AS totalRevenue,
    ROUND(
        SUM(od.quantityOrdered * od.priceEach)
        / SUM(SUM(od.quantityOrdered * od.priceEach)) OVER () * 100,
        2
    ) AS revenueContributionPercentage
FROM products p
JOIN orderdetails od
    ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName
ORDER BY revenueContributionPercentage DESC;

 /*
You need to use the sakila database.

11. Rank customers based on their total rental revenue.
  */

USE sakila;

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_rental_revenue,
    RANK() OVER (
        ORDER BY SUM(p.amount) DESC
        ) AS revenue_rank
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id;

/*
You need to use the employees database.

12. Rank employees based on the number of
departments they have worked in.
Display the rank along with the number of
departments for each employee.
 */
USE employees;

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    COUNT(de.dept_no) AS departmentCount,
    RANK() OVER (
        ORDER BY COUNT(de.dept_no) DESC
        ) AS departmentRank
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
GROUP BY e.emp_no;