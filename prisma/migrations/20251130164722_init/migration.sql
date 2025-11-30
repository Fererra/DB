-- CreateEnum
CREATE TYPE "booking_status" AS ENUM ('Pending', 'Confirmed', 'Cancelled');

-- CreateEnum
CREATE TYPE "seat_type" AS ENUM ('standard', 'VIP');

-- CreateTable
CREATE TABLE "booking" (
    "booking_id" SERIAL NOT NULL,
    "total_price" DECIMAL(8,2) NOT NULL,
    "status" "booking_status" DEFAULT 'Pending',
    "booking_date" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "customer_id" INTEGER,
    "showtime_id" INTEGER,

    CONSTRAINT "booking_pkey" PRIMARY KEY ("booking_id")
);

-- CreateTable
CREATE TABLE "booking_seat" (
    "showtime_id" INTEGER NOT NULL,
    "seat_id" INTEGER NOT NULL,
    "booking_id" INTEGER,
    "tariff_id" INTEGER,
    "final_price" DECIMAL(7,2),

    CONSTRAINT "booking_seat_pkey" PRIMARY KEY ("showtime_id","seat_id")
);

-- CreateTable
CREATE TABLE "cinema_hall" (
    "hall_id" SERIAL NOT NULL,
    "hall_number" INTEGER NOT NULL,
    "capacity" INTEGER NOT NULL,

    CONSTRAINT "cinema_hall_pkey" PRIMARY KEY ("hall_id")
);

-- CreateTable
CREATE TABLE "customer" (
    "customer_id" SERIAL NOT NULL,
    "first_name" VARCHAR(100) NOT NULL,
    "last_name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(20),

    CONSTRAINT "customer_pkey" PRIMARY KEY ("customer_id")
);

-- CreateTable
CREATE TABLE "genre" (
    "genre_id" SERIAL NOT NULL,
    "name" VARCHAR(30) NOT NULL,

    CONSTRAINT "genre_pkey" PRIMARY KEY ("genre_id")
);

-- CreateTable
CREATE TABLE "movie" (
    "movie_id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "age_limit" INTEGER NOT NULL,
    "duration_min" INTEGER NOT NULL,
    "release_year" INTEGER NOT NULL,
    "description" TEXT,

    CONSTRAINT "movie_pkey" PRIMARY KEY ("movie_id")
);

-- CreateTable
CREATE TABLE "movie_genre" (
    "movie_id" INTEGER NOT NULL,
    "genre_id" INTEGER NOT NULL,

    CONSTRAINT "movie_genre_pkey" PRIMARY KEY ("movie_id","genre_id")
);

-- CreateTable
CREATE TABLE "seat" (
    "seat_id" SERIAL NOT NULL,
    "row_number" INTEGER NOT NULL,
    "seat_number" INTEGER NOT NULL,
    "seat_type" "seat_type" NOT NULL,
    "base_price" DECIMAL(6,2) NOT NULL,
    "hall_id" INTEGER,

    CONSTRAINT "seat_pkey" PRIMARY KEY ("seat_id")
);

-- CreateTable
CREATE TABLE "showtime" (
    "showtime_id" SERIAL NOT NULL,
    "show_date" DATE NOT NULL,
    "show_time" TIME(6) NOT NULL,
    "movie_id" INTEGER,
    "hall_id" INTEGER,

    CONSTRAINT "showtime_pkey" PRIMARY KEY ("showtime_id")
);

-- CreateTable
CREATE TABLE "tariff" (
    "tariff_id" SERIAL NOT NULL,
    "name" VARCHAR(30) NOT NULL,
    "start_time" TIME(6) NOT NULL,
    "end_time" TIME(6) NOT NULL,
    "price_multiplier" DECIMAL(3,2) NOT NULL,

    CONSTRAINT "tariff_pkey" PRIMARY KEY ("tariff_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "cinema_hall_hall_number_key" ON "cinema_hall"("hall_number");

-- CreateIndex
CREATE UNIQUE INDEX "customer_email_key" ON "customer"("email");

-- CreateIndex
CREATE UNIQUE INDEX "genre_name_key" ON "genre"("name");

-- CreateIndex
CREATE UNIQUE INDEX "movie_title_key" ON "movie"("title");

-- CreateIndex
CREATE UNIQUE INDEX "seat_hall_id_row_number_seat_number_key" ON "seat"("hall_id", "row_number", "seat_number");

-- AddForeignKey
ALTER TABLE "booking" ADD CONSTRAINT "booking_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("customer_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "booking" ADD CONSTRAINT "booking_showtime_id_fkey" FOREIGN KEY ("showtime_id") REFERENCES "showtime"("showtime_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "booking_seat" ADD CONSTRAINT "booking_seat_booking_id_fkey" FOREIGN KEY ("booking_id") REFERENCES "booking"("booking_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "booking_seat" ADD CONSTRAINT "booking_seat_seat_id_fkey" FOREIGN KEY ("seat_id") REFERENCES "seat"("seat_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "booking_seat" ADD CONSTRAINT "booking_seat_showtime_id_fkey" FOREIGN KEY ("showtime_id") REFERENCES "showtime"("showtime_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "booking_seat" ADD CONSTRAINT "booking_seat_tariff_id_fkey" FOREIGN KEY ("tariff_id") REFERENCES "tariff"("tariff_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "movie_genre" ADD CONSTRAINT "movie_genre_genre_id_fkey" FOREIGN KEY ("genre_id") REFERENCES "genre"("genre_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "movie_genre" ADD CONSTRAINT "movie_genre_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "movie"("movie_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "seat" ADD CONSTRAINT "seat_hall_id_fkey" FOREIGN KEY ("hall_id") REFERENCES "cinema_hall"("hall_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "showtime" ADD CONSTRAINT "showtime_hall_id_fkey" FOREIGN KEY ("hall_id") REFERENCES "cinema_hall"("hall_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "showtime" ADD CONSTRAINT "showtime_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "movie"("movie_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
