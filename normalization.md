# Нормалізація (Лаб 5)

## Таблиця movie

### 1. Оригінальний дизайн
```sql
CREATE TABLE IF NOT EXISTS movie (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL UNIQUE,
    age_limit INT NOT NULL CHECK (age_limit > 0),
    duration_min INT NOT NULL CHECK (duration_min > 0),
    release_year INT NOT NULL CHECK (release_year > 0),
    description TEXT
); 
```

### 2. Функціональні залежності
**Основна залежність (за первинним ключем):** movie_id → title, age_limit, duration_min, release_year, description
**Залежнсть від Кандидата в Ключі (через UNIQUE):** title → movie_id, age_limit, duration_min, release_year, description, оскільки title має UNIQUE.


### 3. Перевірка нормальних форм

- **1NF:** Усі атрибути є атомариними, немає повторюваних груп. Таблиця знаходиться в 1NF.
- **2NF:** Первиний ключ – простий, часткові залежності неможливі. Таблиця знаходиться в 2NF.
- **3NF:** У таблиці немає транзитивних залежностей. Жоден неключовий атрибут не визначає інший неключовий атрибут. Поле title є Кандидатом у ключі, тому залежність не порушує 3NF. Усі вони залежать виключно від первинного ключа.Таблиця знаходиться в 3NF.

## Таблиця genre

### 1. Оригінальний дизайн
```sql
CREATE TABLE IF NOT EXISTS genre (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL
);
```

### 2. Функціональні залежності
**Основна залежність (за первинним ключем):** genre_id → name
**Залежнсть від Кандидата в Ключі (через UNIQUE):** name → genre_id, оскільки name має UNIQUE.


### 3. Перевірка нормальних форм

- **1NF:** Усі атрибути є атомариними, немає повторюваних груп. Таблиця знаходиться в 1NF.
- **2NF:** Первиний ключ – простий, часткові залежності неможливі. Таблиця знаходиться в 2NF.
- **3NF:** У таблиці немає транзитивних залежностей. Жоден неключовий атрибут не визначає інший неключовий атрибут. Поле name є Кандидатом у Ключі, тому залежність не порушує 3NF. Усі вони залежать виключно від первинного ключа.Таблиця знаходиться в 3NF.

## Таблиця movie_genre

### 1. Оригінальний дизайн
```sql
CREATE TABLE IF NOT EXISTS movie_genre (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);
```



### 2. Функціональні залежності
**Основна залежність (за первинним ключем):** відсутня, оскільки немає неключових атрибутів.
> movie_id сам по собі не визначає genre_id, i genre_id сам по собі не визначає movie_id. Це зв'язка many-to-many між movie та genre.

### 3. Перевірка нормальних форм

- **1NF:** Усі атрибути є атомариними, немає повторюваних груп. Таблиця знаходиться в 1NF.
- **2NF:** Немає часткових залежностей, оскільки в таблиці немає неключових атрибутів. Таблиця знаходиться в 2NF.
- **3NF:** Немає транзитивних залежностей, бо немає неключових атрибутів. Таблиця знаходиться в 3NF.

## Таблиця cinema_hall

### 1. Оригінальний дизайн
```sql
CREATE TABLE IF NOT EXISTS cinema_hall (
    hall_id SERIAL PRIMARY KEY,
    hall_number INT NOT NULL UNIQUE CHECK (hall_number > 0),
    capacity INT NOT NULL CHECK (capacity > 0)
);
```

### 2. Функціональні залежності
**Основна залежність (за первинним ключем):** hall_id → hall_number, capacity
**Залежнсть від Кандидата в Ключі (через UNIQUE):** hall_number → hall_id, capacity оскільки hall_number має UNIQUE.

### 3. Перевірка нормальних форм

- **1NF:** Усі атрибути є атомариними, немає повторюваних груп. Таблиця знаходиться в 1NF.
- **2NF:** Первиний ключ – простий, часткові залежності неможливі. Таблиця знаходиться в 2NF.
- **3NF:** У таблиці немає транзитивних залежностей. Жоден неключовий атрибут не визначає інший неключовий атрибут. Усі вони залежать виключно від первинного ключа. Таблиця знаходиться в 3NF.

## Таблиця seat

### 1. Оригінальний дизайн
```sql
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
```

### 2. Функціональні залежності
**Основна залежність (за первинним ключем):** seat_id → row_number, seat_number, seat_type, base_price, hall_id
**Залежнсть від Кандидата в Ключі (через UNIQUE):** (hall_id, row_number, seat_number) → seat_id, seat_type, base_price, оскільки це унікальна комбінація місця в конкретному залі.

### 3. Перевірка нормальних форм

- **1NF:** Усі атрибути є атомариними, немає повторюваних груп. Таблиця знаходиться в 1NF.
- **2NF:** Первиний ключ – простий, часткові залежності неможливі. Таблиця знаходиться в 2NF.
- **3NF:** У таблиці немає транзитивних залежностей. Жоден неключовий атрибут не визначає інший неключовий атрибут. Усі вони залежать виключно від первинного ключа. Таблиця знаходиться в 3NF.

## Таблиця customer

### 1. Оригінальний дизайн
```sql
CREATE TABLE IF NOT EXISTS customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20)
);
```

### 2. Функціональні залежності
**Основна залежність (за первинним ключем):** customer_id → first_name, last_name, email, phone
**Залежнсть від Кандидата в Ключі (через UNIQUE):** email → customer_id, first_name, last_name, phone оскільки email має UNIQUE.

### 3. Перевірка нормальних форм

- **1NF:** Усі атрибути є атомариними, немає повторюваних груп. Таблиця знаходиться в 1NF.
- **2NF:** Первиний ключ – простий, часткові залежності неможливі. Таблиця знаходиться в 2NF.
- **3NF:** У таблиці немає транзитивних залежностей. Жоден неключовий атрибут не визначає інший неключовий атрибут. Поле email є Кандидатом у ключі, тому залежність не порушує 3NF. Усі вони залежать виключно від первинного ключа.Таблиця знаходиться в 3NF.

## Таблиця showtime

### 1. Оригінальний дизайн
```sql
CREATE TABLE IF NOT EXISTS showtime (
    showtime_id SERIAL PRIMARY KEY,
    show_date DATE NOT NULL,
    show_time TIME NOT NULL,
    movie_id INT,
    hall_id INT,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (hall_id) REFERENCES cinema_hall(hall_id)
);
```

### 2. Функціональні залежності
**Основна залежність (за первинним ключем):** showtime_id → show_date, show_time, movie_id, hall_id
**Залежнсть від можливого Кандидата в Ключі:** (show_date, show_time, hall_id) → showtime_id, movie_id, при додаванні UNIQUE, оскільки в конкретному залі в конкретний час йде лише один сеанс.

### 3. Перевірка нормальних форм

- **1NF:** Усі атрибути є атомариними, немає повторюваних груп. Таблиця знаходиться в 1NF.
- **2NF:** Первиний ключ – простий, часткові залежності неможливі. Таблиця знаходиться в 2NF.
- **3NF:** У таблиці немає транзитивних залежностей. Жоден неключовий атрибут не визначає інший неключовий атрибут. Усі вони залежать виключно від первинного ключа. Таблиця знаходиться в 3NF.

## Таблиця Booking

### 1. Оригінальний дизайн
```sql
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
```

### 2. Функціональні залежності
**Основна залежність (за первинним ключем):** booking_id → total_price, status, booking_date, customer_id, showtime_id

### 3. Перевірка нормальних форм

- **1NF:** Усі атрибути є атомариними, немає повторюваних груп. Таблиця знаходиться в 1NF.
- **2NF:** Первиний ключ – простий, часткові залежності неможливі. Таблиця знаходиться в 2NF.
- **3NF:** У таблиці немає транзитивних залежностей. Жоден неключовий атрибут не визначає інший неключовий атрибут. Усі вони залежать виключно від первинного ключа. Таблиця знаходиться в 3NF.

## Таблиця tariff

### 1. Оригінальний дизайн
```sql
CREATE TABLE IF NOT EXISTS tariff (
    tariff_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    price_multiplier DECIMAL(3,2) NOT NULL CHECK (price_multiplier > 0),
    CONSTRAINT valid_time_range CHECK (start_time < end_time)
);
```

### 2. Функціональні залежності
**Основна залежність (за первинним ключем):** tariff_id → name, start_time, end_time, price_multiplier

### 3. Перевірка нормальних форм

- **1NF:** Усі атрибути є атомариними, немає повторюваних груп. Таблиця знаходиться в 1NF.
- **2NF:** Первиний ключ – простий, часткові залежності неможливі. Таблиця знаходиться в 2NF.
- **3NF:** У таблиці немає транзитивних залежностей. Жоден неключовий атрибут не визначає інший неключовий атрибут. Усі вони залежать виключно від первинного ключа. Таблиця знаходиться в 3NF.

## Таблиця booking_seat

### 1. Оригінальний дизайн
```sql
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
```

### 2. Функціональні залежності
**Основна залежність (за первинним ключем):** (showtime_id, seat_id) → booking_id, tariff_id, final_price
**Залежнсть від Кандидата в Ключі (через UNIQUE):** (hall_id, row_number, seat_number) → seat_id, seat_type, base_price, оскільки це унікальна комбінація місця в конкретному залі.

### 3. Перевірка нормальних форм

- **1NF:** Усі атрибути є атомариними, немає повторюваних груп. Таблиця знаходиться в 1NF.
- **2NF:** Усі неключові атрибути залежать від усього складеного ключа, тому немає часткових залежностей. Таблиця знаходиться в 2NF.
- **3NF:** У таблиці немає транзитивних залежностей. Жоден неключовий атрибут не визначає інший неключовий атрибут. Усі вони залежать виключно від первинного ключа. Таблиця знаходиться в 3NF.