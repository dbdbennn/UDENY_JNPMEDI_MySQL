-- 1. Finding 5 oldest users
SELECT 
    *
FROM
    users
ORDER BY created_at
LIMIT 5;

-- 2. Most Popular Registration Date
SELECT 
    DAYNAME(created_at) AS day, COUNT(*) AS total
FROM
    users
GROUP BY day
ORDER BY total DESC
LIMIT 2;

-- 3. Identify Inactice Users (users with no photos)
SELECT * FROM users;
SELECT * FROM photos;

SELECT 
    username
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
WHERE
    photos.id IS NULL;
    
-- 4. Identify most popular photo (and user who created it)
SELECT 
    username, photos.id, image_url, COUNT(*) total
FROM
    photos
        INNER JOIN
    likes ON photos.id = likes.photo_id
        INNER JOIN
    users ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- 5. 평균적인 post 횟수?
SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg; 













