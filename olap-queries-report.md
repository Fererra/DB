# Лабораторна робота №4 — Аналітичні SQL-запити (OLAP)

---

## 1. Агрегатні запити

### Підрахунок кількості фільмів для кожного вікового обмеження

```sql
SELECT age_limit, COUNT(*) AS movie_count
FROM movie
GROUP BY age_limit
ORDER BY movie_count DESC;
```

### Обчислення середньої тривалості фільмів для кожного вікового обмеження

```sql
SELECT age_limit, ROUND(AVG(duration_min)) AS avg_duration
FROM movie
GROUP BY age_limit
ORDER BY age_limit;
```

### Обчислення загальної суми бронювань для кожного статусу

```sql
SELECT status, SUM(total_price) AS total_revenue
FROM booking
GROUP BY status
ORDER BY total_revenue DESC;
```

### Обчислення середньої базової ціни квитків за типом місця

```sql
SELECT seat_type, ROUND(AVG(base_price), 2) AS avg_price
FROM seat
GROUP BY seat_type;
```

### Визначення середньої тривалості фільмів за роком випуску (понад 120 хв)

```sql
SELECT release_year, ROUND(AVG(duration_min)) AS avg_length
FROM movie
GROUP BY release_year
HAVING AVG(duration_min) > 120
ORDER BY avg_length DESC;
```

---

## 2. JOIN-запити

### Отримання інформації про бронювання разом із клієнтами та фільмами

```sql
SELECT b.booking_id, c.first_name, c.last_name, m.title, b.status, b.total_price
FROM booking b
JOIN customer c ON b.customer_id = c.customer_id
JOIN showtime s ON b.showtime_id = s.showtime_id
JOIN movie m ON s.movie_id = m.movie_id
ORDER BY b.booking_id;
```

### Отримання списку залів із місцями

```sql
SELECT ch.hall_number, s.seat_number, s.row_number, s.seat_type
FROM cinema_hall ch
LEFT JOIN seat s ON ch.hall_id = s.hall_id
ORDER BY ch.hall_number, s.row_number, s.seat_number;
```

### Відображення фільмів із відповідними жанрами

```sql
SELECT m.title, g.name AS genre
FROM movie m
INNER JOIN movie_genre mg ON m.movie_id = mg.movie_id
INNER JOIN genre g ON mg.genre_id = g.genre_id
ORDER BY m.title;
```

### Обчислення кількості використань кожного тарифу

```sql
SELECT t.name AS tariff, COUNT(bs.booking_id) AS used_count
FROM booking_seat bs
RIGHT JOIN tariff t ON bs.tariff_id = t.tariff_id
GROUP BY t.name;
```

### Обчислення прогнозованої ціни квитка для комбінації типу місця та тарифу

```sql
SELECT s.seat_type, t.name AS tariff, ROUND(s.base_price * t.price_multiplier, 2) AS projected_price
FROM seat s
CROSS JOIN tariff t
ORDER BY s.seat_type, t.name;
```

---

## 3. Підзапити

### Визначення фільмів, які мають хоча б один сеанс

```sql
SELECT title
FROM movie
WHERE movie_id IN (
    SELECT movie_id
    FROM showtime
);
```

### Визначення клієнтів із сумою бронювання більшою за середню

```sql
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM booking
    WHERE total_price > (SELECT AVG(total_price) FROM booking)
);
```

### Визначення фільмів із тривалістю, більшою за середню

```sql
SELECT title, duration_min
FROM movie
WHERE duration_min > (SELECT AVG(duration_min) FROM movie);
```

### Визначення клієнтів, які бронювали VIP-місця

```sql
SELECT DISTINCT c.first_name, c.last_name
FROM customer c
WHERE c.customer_id IN (
    SELECT b.customer_id
    FROM booking b
    JOIN booking_seat bs ON b.booking_id = bs.booking_id
    JOIN seat s ON bs.seat_id = s.seat_id
    WHERE s.seat_type = 'VIP'
);
```

### Визначення сеансу(-ів) з найвищою середньою ціною квитка

```sql
SELECT showtime_id, ROUND(AVG(final_price), 2) AS avg_price
FROM booking_seat
GROUP BY showtime_id
HAVING AVG(final_price) >= ALL (
    SELECT AVG(final_price) FROM booking_seat GROUP BY showtime_id
);
```
