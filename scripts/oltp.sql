SELECT * FROM movie;

SELECT * FROM customer;

SELECT title, release_year
FROM movie
WHERE release_year > 2010;

SELECT seat_id, row_number, seat_number, base_price
FROM seat
WHERE hall_id = 2 AND seat_type = 'VIP';

SELECT booking_id, total_price, status
FROM booking
WHERE status = 'Confirmed';

SELECT title, duration_min
FROM movie
ORDER BY duration_min ASC;

SELECT name, price_multiplier
FROM tariff
WHERE price_multiplier > 1.0;

SELECT booking_id, total_price, booking_date
FROM booking
WHERE booking_date > '2025-10-01';

SELECT seat_id, row_number, seat_number, seat_type, base_price
FROM seat
WHERE hall_id = 1
ORDER BY row_number, seat_number ASC;

UPDATE booking
SET status = 'Cancelled'
WHERE booking_id = 2;

UPDATE seat
SET base_price = base_price * 1.1
WHERE hall_id = 1 AND seat_type = 'standard';

UPDATE customer
SET phone = '+380501234000'
WHERE email = 'alice.johnson@example.com';

UPDATE movie
SET age_limit = 18
WHERE title = 'The Dark Knight';

UPDATE tariff
SET price_multiplier = 1.3
WHERE name = 'Evening';

DELETE FROM booking_seat
WHERE booking_id = 6;

DELETE FROM booking
WHERE booking_id = 6;

DELETE FROM booking_seat
WHERE booking_id IN (
  SELECT booking_id FROM booking WHERE customer_id = 2
);

DELETE FROM booking
WHERE customer_id = 2;

DELETE FROM customer
WHERE customer_id = 2;

DELETE FROM booking_seat
WHERE seat_id IN (
	SELECT seat_id FROM seat WHERE hall_id = 1 AND seat_type = 'VIP'
);

DELETE FROM seat
WHERE hall_id = 1 AND seat_type = 'VIP';

DELETE FROM tariff
WHERE price_multiplier < 1.0;

DELETE FROM booking
WHERE booking_date < '2025-10-01';
