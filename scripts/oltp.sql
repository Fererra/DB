-- Отримати всі фільми
SELECT * FROM movie;

-- Отримати всіх клієнтів
SELECT * FROM customer;

-- Вибрати фільми, випущені після 2010 року
SELECT title, release_year
FROM movie
WHERE release_year > 2010;

-- Усі VIP-місця в залі №2
SELECT seat_id, row_number, seat_number, base_price
FROM seat
WHERE hall_id = 2 AND seat_type = 'VIP';

-- Усі підтверджені бронювання
SELECT booking_id, total_price, status
FROM booking
WHERE status = 'Confirmed';

-- Відсортувати фільми за тривалістю (від найкоротшого до найдовшого)
SELECT title, duration_min
FROM movie
ORDER BY duration_min;

-- Вибрати тарифи, у яких коефіцієнт ціни більше 1
SELECT name, price_multiplier
FROM tariff
WHERE price_multiplier > 1.0;

-- Вибрати усі бронювання, зроблені після певної дати
SELECT booking_id, total_price, booking_date
FROM booking
WHERE booking_date > '2025-10-01';

-- Вибрати всі місця у залі №1, відсортовані за номером ряду і місця
SELECT seat_id, row_number, seat_number, seat_type, base_price
FROM seat
WHERE hall_id = 1
ORDER BY row_number, seat_number;

-- Змінити статус конкретного бронювання
UPDATE booking
SET status = 'Cancelled'
WHERE booking_id = 2;

-- Підвищити ціну базових місць у залі №1 на 10%
UPDATE seat
SET base_price = base_price * 1.1
WHERE hall_id = 1 AND seat_type = 'standard';

-- Оновити номер телефону клієнта
UPDATE customer
SET phone = '+380501234000'
WHERE email = 'alice.johnson@example.com';

-- Змінити вік обмеження для певного фільму
UPDATE movie
SET age_limit = 18
WHERE title = 'The Dark Knight';

-- Оновити коефіцієнт для вечірнього тарифу
UPDATE tariff
SET price_multiplier = 1.3
WHERE name = 'Evening';

-- Видалити всі бронювання зі статусом "Cancelled"
DELETE FROM booking_seat
WHERE booking_id IN (
  SELECT booking_id FROM booking WHERE status = 'Cancelled'
);

-- Видалити самі бронювання зі статусом "Cancelled"
DELETE FROM booking
WHERE status = 'Cancelled';

-- Видалити всі бронювання місць, пов’язані з клієнтом №2
DELETE FROM booking_seat
WHERE booking_id IN (
  SELECT booking_id FROM booking WHERE customer_id = 2
);

-- Видалити всі бронювання клієнта №2
DELETE FROM booking
WHERE customer_id = 2;

-- Видалити клієнта №2
DELETE FROM customer
WHERE customer_id = 2;

-- Видалити всі бронювання місць для VIP у залі №1
DELETE FROM booking_seat
WHERE seat_id IN (
    SELECT seat_id FROM seat WHERE hall_id = 1 AND seat_type = 'VIP'
);

-- Видалити самі VIP-місця у залі №1
DELETE FROM seat
WHERE hall_id = 1 AND seat_type = 'VIP';

-- Видалити тарифи з коефіцієнтом ціни менше 1.0
DELETE FROM tariff
WHERE price_multiplier < 1.0;

-- Видалити бронювання, зроблені до 1 жовтня 2025 року
DELETE FROM booking
WHERE booking_date < '2025-10-01';
