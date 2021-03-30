--
-- Postgres dump
--

--
-- drop all tables
--

DROP TABLE IF EXISTS book_author;
DROP TABLE IF EXISTS book_category;
DROP TABLE IF EXISTS carts;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS publishers;
DROP TABLE IF EXISTS customers;


--
-- create all tables
--


CREATE TABLE publishers (
	id serial PRIMARY KEY,
	publisher_name varchar(255) NOT NULL,
	CONSTRAINT unique_publisher_name UNIQUE(publisher_name)
);

CREATE TABLE books (
	id serial PRIMARY KEY,
	book_name varchar(255) NOT NULL,
	description text NOT NULL,
	publisher_id int NOT NULL,
	year_publishing int NOT NULL,
	isbn varchar(13) NOT NULL,
    unit_price numeric(6,2) NOT NULL,
    units_in_stock int NOT NULL,
	discontinued boolean NOT NULL,
    	created_at TIMESTAMP DEFAULT NOW(),
	CONSTRAINT fk_books_publisher_id FOREIGN KEY(publisher_id) REFERENCES publishers(id),
	CONSTRAINT check_books_year_publishing CHECK(year_publishing BETWEEN 2000 AND date_part('year', created_at)),
	CONSTRAINT check_books_isbn CHECK(isbn LIKE '__________' OR isbn LIKE '_____________'),
	CONSTRAINT unique_book_name UNIQUE(book_name),
    CONSTRAINT unique_isbn UNIQUE(isbn)
);

CREATE TABLE authors (
	id serial PRIMARY KEY,
	author_name varchar(255) NOT NULL,
	CONSTRAINT unique_author_name UNIQUE(author_name)
);

CREATE TABLE categories (
	id serial PRIMARY KEY,
	category_name varchar(255) NOT NULL,
	CONSTRAINT unique_category_name UNIQUE(category_name)
);

CREATE TABLE book_author (
	book_id int NOT NULL,
	author_id int NOT NULL,
	CONSTRAINT fk_book_author_book_id FOREIGN KEY(book_id) REFERENCES books(id),
	CONSTRAINT fk_book_author_author_id FOREIGN KEY(author_id) REFERENCES authors(id),
	CONSTRAINT pk_book_author PRIMARY KEY(book_id, author_id)
);

CREATE TABLE book_category (
	book_id int NOT NULL,
	category_id int NOT NULL,
	CONSTRAINT fk_book_author_book_id FOREIGN KEY(book_id) REFERENCES books(id),
	CONSTRAINT fk_book_author_category_id FOREIGN KEY(category_id) REFERENCES categories(id),
	CONSTRAINT pk_book_category PRIMARY KEY(book_id, category_id)
);

CREATE TABLE customers (
	id serial PRIMARY KEY,
	user_name varchar(255),
	created_at TIMESTAMP DEFAULT NOW(),
	CONSTRAINT unique_user_name UNIQUE(user_name)
);

CREATE TABLE reviews (
	id serial PRIMARY KEY,
	reviews_text text NOT NULL,
	customer_id int NOT NULL,
	book_id int NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	CONSTRAINT fk_reviews_customer_id FOREIGN KEY(customer_id) REFERENCES customers(id),
	CONSTRAINT fk_reviews_book_id FOREIGN KEY(book_id) REFERENCES books(id),
	CONSTRAINT unique_customer_book UNIQUE(customer_id, book_id)
);

CREATE TABLE carts (
	customer_id int NOT NULL,
	book_id int NOT NULL,
	CONSTRAINT fk_carts_customer_id FOREIGN KEY(customer_id) REFERENCES customers(id),
	CONSTRAINT fk_carts_book_id FOREIGN KEY(book_id) REFERENCES books(id),
	CONSTRAINT pk_customer_cart PRIMARY KEY(customer_id, book_id)
);
