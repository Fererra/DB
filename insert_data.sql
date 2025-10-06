INSERT INTO movie (title, age_limit, duration_min, release_year, description)
VALUES
('Inception', 16, 148, 2010, 'A skilled thief leads a team into people’s dreams to steal secrets.'),
('Interstellar', 12, 169, 2014, 'A group of astronauts travel through a wormhole to save humanity.'),
('The Dark Knight', 16, 152, 2008, 'Batman faces the Joker in a battle for Gotham.'),
('Inside Out', 6, 95, 2015, 'Animated story showing the emotions inside a young girl’s mind.');

INSERT INTO genre (name)
VALUES
('Sci-Fi'),
('Action'),
('Drama'),
('Animation');

INSERT INTO movie_genre (movie_id, genre_id)
VALUES
(1, 1), (1, 3),
(2, 1), (2, 3),
(3, 2), (3, 3),
(4, 4), (4, 3);

INSERT INTO cinema_hall (hall_number, capacity)
VALUES
(1, 50),
(2, 100);

INSERT INTO seat (row_number, seat_number, seat_type, base_price, hall_id)
VALUES
(1, 1, 'standard', 100.00, 1),
(1, 2, 'standard', 100.00, 1),
(1, 3, 'standard', 100.00, 1),
(1, 4, 'VIP', 150.00, 1),
(1, 5, 'VIP', 150.00, 1),
(2, 1, 'standard', 90.00, 1),
(2, 2, 'standard', 90.00, 1),
(2, 3, 'standard', 90.00, 1),
(3, 1, 'standard', 80.00, 1),
(3, 2, 'standard', 80.00, 1);

INSERT INTO seat (row_number, seat_number, seat_type, base_price, hall_id)
VALUES
(1, 1, 'standard', 120.00, 2),
(1, 2, 'standard', 120.00, 2),
(1, 3, 'VIP', 180.00, 2),
(1, 4, 'VIP', 180.00, 2),
(2, 1, 'standard', 110.00, 2),
(2, 2, 'standard', 110.00, 2),
(2, 3, 'standard', 110.00, 2),
(2, 4, 'VIP', 160.00, 2);

INSERT INTO customer (first_name, last_name, email, phone)
VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', '+380501112233'),
('Bob', 'Smith', 'bob.smith@example.com', '+380671234567'),
('Charlie', 'Brown', 'charlie.brown@example.com', '+380931112244');

INSERT INTO showtime (show_date, show_time, movie_id, hall_id)
VALUES
('2025-10-06', '18:00', 1, 1),
('2025-10-06', '20:30', 2, 2),
('2025-10-07', '16:00', 4, 1),
('2025-10-07', '19:00', 3, 2);

INSERT INTO tariff (name, start_time, end_time, price_multiplier)
VALUES
('Morning', '08:00', '12:00', 0.8),
('Daytime', '12:00', '18:00', 1.0),
('Evening', '18:00', '23:59', 1.2);

INSERT INTO booking (total_price, status, customer_id, showtime_id)
VALUES
(270.00, 'Confirmed', 1, 1),
(180.00, 'Pending', 2, 2),
(150.00, 'Confirmed', 3, 3);

INSERT INTO booking_seat (showtime_id, seat_id, booking_id, tariff_id, final_price)
VALUES
(1, 4, 1, 3, 180.00),
(1, 2, 1, 3, 90.00);

INSERT INTO booking_seat (showtime_id, seat_id, booking_id, tariff_id, final_price)
VALUES
(2, 14, 2, 3, 180.00);

INSERT INTO booking_seat (showtime_id, seat_id, booking_id, tariff_id, final_price)
VALUES
(3, 6, 3, 2, 150.00);
