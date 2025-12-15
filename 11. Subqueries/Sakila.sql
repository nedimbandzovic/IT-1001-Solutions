USE sakila;

#Task 19

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name FROM customer c
WHERE c.customer_id IN (
    SELECT r.customer_id FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    GROUP BY r.customer_id
    HAVING COUNT(DISTINCT fc.category_id) > 1
)
ORDER BY customer_name;

#Task 21

SELECT c.name AS category_name, f.title, f.rental_duration FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE EXISTS (
    SELECT 1 FROM film f2
    JOIN film_category fc2 ON f2.film_id = fc2.film_id
    WHERE fc2.category_id = fc.category_id AND f2.rental_duration = f.rental_duration AND f2.film_id <> f.film_id
)
ORDER BY c.name, f.title;

#Task 22

SELECT f.title, c.name AS category_name, f.rental_rate,
       (
           SELECT COUNT(DISTINCT f2.rental_rate) + 1 FROM film f2
           JOIN film_category fc2 ON f2.film_id = fc2.film_id WHERE fc2.category_id = fc.category_id AND f2.rental_rate > f.rental_rate
       ) AS rank_in_category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
ORDER BY c.name, rank_in_category, f.title;

#Task 35

SELECT f.film_id, f.title, f.length
FROM film f
WHERE f.length = (
    SELECT MAX(f2.length) FROM film f2
    WHERE f2.film_id IN (
        SELECT DISTINCT i.film_id FROM inventory i
        JOIN rental r ON i.inventory_id = r.inventory_id
    )
)
ORDER BY f.title DESC;

#Task 36

SELECT c.customer_id, c.first_name, c.last_name FROM customer c
WHERE (
    SELECT COUNT(*) FROM rental r
    WHERE r.customer_id = c.customer_id
) > (
    SELECT AVG(rental_count)
    FROM (
        SELECT COUNT(*) AS rental_count FROM rental
        GROUP BY customer_id
    ) t
)

#Task 37

SELECT a.actor_id, a.first_name, a.last_name FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id FROM film_actor fa
    WHERE fa.film_id IN (
        SELECT fc.film_id FROM film_category fc
        JOIN film f ON f.film_id = fc.film_id
        GROUP BY fc.film_id
        HAVING AVG(f.rental_duration) > (
            SELECT AVG(rental_duration) FROM film
        )
    )
)
ORDER BY a.last_name, a.first_name;

#Task 38

SELECT c.name AS category_name, t.total_revenue
FROM category c
JOIN (
    SELECT fc.category_id, SUM(p.amount) AS total_revenue
    FROM payment p
    JOIN rental r ON p.rental_id = r.rental_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    GROUP BY fc.category_id
) t
    ON c.category_id = t.category_id
WHERE t.total_revenue = (
    SELECT MAX(total_revenue)
    FROM (
        SELECT SUM(p.amount) AS total_revenue FROM payment p
        JOIN rental r ON p.rental_id = r.rental_id
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film_category fc ON i.film_id = fc.film_id
        GROUP BY fc.category_id
    ) x
);

#Task 39

SELECT f.title, t.rental_count FROM film f
JOIN (
    SELECT i.film_id, COUNT(*) AS rental_count FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    GROUP BY i.film_id
) t
    ON f.film_id = t.film_id
WHERE t.rental_count = (
    SELECT MAX(rental_count) FROM (
        SELECT COUNT(*) AS rental_count FROM rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
        GROUP BY i.film_id
    ) x
);





