CREATE TYPE seat_type AS ENUM ('standard', 'VIP');
CREATE TYPE booking_status AS ENUM ('Pending', 'Confirmed', 'Cancelled');

CREATE TABLE IF NOT EXISTS movie (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL UNIQUE,
    age_limit INT NOT NULL CHECK (age_limit > 0),
    duration_min INT NOT NULL CHECK (duration_min > 0),
    release_year INT NOT NULL CHECK (release_year > 0),
    description TEXT
);

CREATE TABLE IF NOT EXISTS genre (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS movie_genre (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

CREATE TABLE IF NOT EXISTS cinema_hall (
    hall_id SERIAL PRIMARY KEY,
    hall_number INT NOT NULL UNIQUE CHECK (hall_number > 0),
    capacity INT NOT NULL CHECK (capacity > 0)
);


CREATE TABLE IF NOT EXISTS seat (
    seat_id SERIAL PRIMARY KEY,
    row_number INT NOT NULL CHECK (row_number > 0),
    seat_number INT NOT NULL CHECK (seat_number > 0),
    seat_type seat_type NOT NULL,
    base_price DECIMAL(6,2) NOT NULL CHECK (base_price > 0),
    hall_id INT,
    UNIQUE (hall_id, row_number, seat_number),
    FOREIGN KEY (hall_id) REFERENCES cinema_hall(hall_id)
);

CREATE TABLE IF NOT EXISTS customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS showtime (
    showtime_id SERIAL PRIMARY KEY,
    show_date DATE NOT NULL,
    show_time TIME NOT NULL,
    movie_id INT,
    hall_id INT,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (hall_id) REFERENCES cinema_hall(hall_id)
);

CREATE TABLE IF NOT EXISTS booking (
    booking_id SERIAL PRIMARY KEY,
    total_price DECIMAL(8,2) NOT NULL CHECK (total_price >= 0),
    status booking_status DEFAULT 'Pending',
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    customer_id INT,
    showtime_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (showtime_id) REFERENCES showtime(showtime_id)
);

CREATE TABLE IF NOT EXISTS tariff (
    tariff_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    price_multiplier DECIMAL(3,2) NOT NULL CHECK (price_multiplier > 0),
    CONSTRAINT valid_time_range CHECK (start_time < end_time)
);

CREATE TABLE IF NOT EXISTS booking_seat (
    showtime_id INT,
    seat_id INT,
    booking_id INT,
    tariff_id INT,
    final_price DECIMAL(7,2),
    PRIMARY KEY (showtime_id, seat_id),
    FOREIGN KEY (showtime_id) REFERENCES showtime(showtime_id),
    FOREIGN KEY (seat_id) REFERENCES seat(seat_id),
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    FOREIGN KEY (tariff_id) REFERENCES tariff(tariff_id)
);
