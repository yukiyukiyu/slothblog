SET foreign_key_checks = 0;

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    id int NOT NULL AUTO_INCREMENT,
    username varchar(64) NOT NULL UNIQUE,
    password varchar(255) NOT NULL,
    salt varchar(255) NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS user_info;
CREATE TABLE user_info (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL UNIQUE,
    email varchar(255),
    gender tinyint(1),
    nickname varchar(255),
    intro text,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);

DROP TABLE IF EXISTS articles;
CREATE TABLE articles (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    title varchar(100) NOT NULL,
    content text NOT NULL,
    created_at timestamp NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);
CREATE INDEX articles_index ON articles (title);

DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
    id int NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);
CREATE UNIQUE INDEX tags_index ON tags (name);

DROP TABLE IF EXISTS users_tags;
CREATE TABLE users_tags (
    id int NOT NULL AUTO_INCREMENT,
    user_id int,
    tag_id int,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (tag_id) REFERENCES tags (id)
);

DROP TABLE IF EXISTS articles_tags;
CREATE TABLE articles_tags (
    id int NOT NULL AUTO_INCREMENT,
    article_id int,
    tag_id int,
    PRIMARY KEY (id),
    FOREIGN KEY (article_id) REFERENCES articles (id),
    FOREIGN KEY (tag_id) REFERENCES tags (id)
);

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
    id int NOT NULL AUTO_INCREMENT,
    content text NOT NULL,
    created_at timestamp NOT NULL,
    article_id int NOT NULL,
    user_id int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (article_id) REFERENCES articles (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);
CREATE INDEX comments_index ON comments (article_id);

SET foreign_key_checks = 1;
