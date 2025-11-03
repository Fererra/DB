-- ===== 1. Агрегатні запити =====
SELECT age_limit, COUNT(*) AS movie_count
FROM movie
GROUP BY age_limit
ORDER BY movie_count DESC;

SELECT age_limit, ROUND(AVG(duration_min)) AS avg_duration
FROM movie
GROUP BY age_limit
ORDER BY age_limit;

SELECT status, SUM(total_price) AS total_revenue
FROM booking
GROUP BY status
ORDER BY total_revenue DESC;

SELECT seat_type, ROUND(AVG(base_price), 2) AS avg_price
FROM seat
GROUP BY seat_type;

SELECT release_year, ROUND(AVG(duration_min)) AS avg_length
FROM movie
GROUP BY release_year
HAVING AVG(duration_min) > 120
ORDER BY avg_length DESC;

-- ===== 2. JOIN-запити =====
SELECT b.booking_id, c.first_name, c.last_name, m.title, b.status, b.total_price
FROM booking b
JOIN customer c ON b.customer_id = c.customer_id
JOIN showtime s ON b.showtime_id = s.showtime_id
JOIN movie m ON s.movie_id = m.movie_id
ORDER BY b.booking_id;

SELECT ch.hall_number, s.seat_number, s.row_number, s.seat_type
FROM cinema_hall ch
LEFT JOIN seat s ON ch.hall_id = s.hall_id
ORDER BY ch.hall_number, s.row_number, s.seat_number;

SELECT m.title, g.name AS genre
FROM movie m
INNER JOIN movie_genre mg ON m.movie_id = mg.movie_id
INNER JOIN genre g ON mg.genre_id = g.genre_id
ORDER BY m.title;

SELECT t.name AS tariff, COUNT(bs.booking_id) AS used_count
FROM booking_seat bs
RIGHT JOIN tariff t ON bs.tariff_id = t.tariff_id
GROUP BY t.name;

SELECT s.seat_type, t.name AS tariff, ROUND(s.base_price * t.price_multiplier, 2) AS projected_price
FROM seat s
CROSS JOIN tariff t
ORDER BY s.seat_type, t.name;

-- ===== 3. Підзапити =====
SELECT title
FROM movie
WHERE movie_id IN (
    SELECT movie_id
    FROM showtime
);

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM booking
    WHERE total_price > (SELECT AVG(total_price) FROM booking)
);

SELECT title, duration_min
FROM movie
WHERE duration_min > (SELECT AVG(duration_min) FROM movie);

SELECT DISTINCT c.first_name, c.last_name
FROM customer c
WHERE c.customer_id IN (
    SELECT b.customer_id
    FROM booking b
    JOIN booking_seat bs ON b.booking_id = bs.booking_id
    JOIN seat s ON bs.seat_id = s.seat_id
    WHERE s.seat_type = 'VIP'
);

SELECT showtime_id, ROUND(AVG(final_price), 2) AS avg_price
FROM booking_seat
GROUP BY showtime_id
HAVING AVG(final_price) >= ALL (
    SELECT AVG(final_price) FROM booking_seat GROUP BY showtime_id
);
