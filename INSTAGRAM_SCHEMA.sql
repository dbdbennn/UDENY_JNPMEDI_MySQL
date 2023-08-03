-- get start
CREATE DATABASE ig_clone;
USE ig_clone;

-- users schema
CREATE TABLE users (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (username) VALUES
('BlueTheCat'),
('CharlieBrown'),
('ColtSteele');

-- photo schema
CREATE TABLE photos (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO photos (image_url, user_id) VALUES
('/alskjd76', 1),
('/asdfasdf', 2),
('/jfdgsffg', 3);

-- SELECT JOIN
SELECT 
    photos.image_url, users.username
FROM
    photos
        JOIN
    users ON photos.user_id = users.id;

-- comment schema
CREATE TABLE comments (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    photo_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO comments(comment_text, user_id, photo_id) values
('Mewo!',1,2),
('Amazing Shot!',3,2),
('I <3 This',2,2);

SELECT * FROM comments;

-- like schema
CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);

INSERT INTO likes (user_id, photo_id) VALUES
(1,1),
(2,1),
(1,2),
(1,3),
(3,3);

-- primary key이기 때문에 삽입되지 않음.
-- INSERT INTO likes (user_id, photo_id) VALUES (1,1);

SELECT * FROM likes;

-- follows schema
CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (follower_id)
        REFERENCES users (id),
    FOREIGN KEY (followee_id)
        REFERENCES users (id),
    PRIMARY KEY (follower_id , followee_id)
);

INSERT INTO follows(follower_id, followee_id) VALUES 
(1,2),
(1,3),
(3,1),
(2,3);

SELECT * FROM follows;

-- tag schema
CREATE TABLE tags (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY (photo_id)
        REFERENCES photos (id),
    FOREIGN KEY (tag_id)
        REFERENCES tags (id),
    PRIMARY KEY (photo_id , tag_id)
);

INSERT INTO tags (tag_name) VALUES
('adorable'),
('cute'),
('sunrise');

INSERT INTO photo_tags(photo_id, tag_id) VALUES
(1,1),
(1,2),
(2,3),
(3,2);

SELECT * FROM tags;
SELECT * FROM photo_tags;