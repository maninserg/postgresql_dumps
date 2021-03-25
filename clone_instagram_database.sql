--
-- PostgreSQL database dump
--


-- 
-- drop all tables
-- 
DROP TABLE IF EXISTS photo_tags;
DROP TABLE IF EXISTS follows;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS photos;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS tags;


-- 
-- create table
-- 

CREATE TABLE users (
	id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
	username VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
	id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
	image_url VARCHAR(255) NOT NULL,
	user_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	CONSTRAINT FK_photos_user_id FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE comments (
	id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INTEGER NOT NULL,
	photo_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	CONSTRAINT FK_comments_user_id FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT FK_comments_photo_id FOREIGN KEY (photo_id) REFERENCES photos(id)
);

CREATE TABLE likes (
	user_id INTEGER NOT NULL,
	photo_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	CONSTRAINT FK_likes_user_id FOREIGN KEY (user_id) REFERENCES users(id),
	CONSTRAINT FK_likes_photo_id FOREIGN KEY (photo_id) REFERENCES photos(id)
);

CREATE TABLE follows (
	follower_id INTEGER NOT NULL,
	followee_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	CONSTRAINT FK_follewer_id FOREIGN KEY (follower_id) REFERENCES users(id),
    CONSTRAINT FK_followee_id FOREIGN KEY (followee_id) REFERENCES users(id),
	CONSTRAINT PK_follows PRIMARY KEY (follower_id, followee_id)
);

CREATE TABLE tags (
	id INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
	tag_name VARCHAR(255) UNIQUE,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
	photo_id INTEGER NOT NULL,
	tag_id INTEGER NOT NULL,
	CONSTRAINT FK_photo_tags_photo_id FOREIGN KEY (photo_id) REFERENCES photos(id),
	CONSTRAINT FK_photo_tags_tag_id FOREIGN KEY (tag_id) REFERENCES tags(id),
	CONSTRAINT PK_photo_tags PRIMARY KEY (photo_id, tag_id)
);
