SELECT 
    title, released_year, genre, rating, first_name, last_name
FROM
    reviews
        JOIN
    series ON series.id = reviews.series_id
        JOIN
    reviewers ON reviews.reviewer_id = reviewers.id
ORDER BY title;

-- CREATE VIEW
CREATE VIEW full_reviews AS
SELECT 
    title, released_year, genre, rating, first_name, last_name
FROM
    reviews
        JOIN
    series ON series.id = reviews.series_id
        JOIN
    reviewers ON reviews.reviewer_id = reviewers.id
ORDER BY title;

-- CREATE OR REPLACE VIEW
CREATE OR REPLACE VIEW ordered_series AS
    SELECT 
        *
    FROM
        series
    ORDER BY released_year DESC;
    
-- ALTER VIEW
ALTER VIEW ordered_series AS
SELECT 
        *
    FROM
        series
    ORDER BY released_year;

-- HAVING
SELECT 
    title, 
    AVG(rating),
    COUNT(rating) AS review_count
FROM full_reviews 
GROUP BY title HAVING COUNT(rating) > 1;

-- ROLLUP
SELECT 
    title, AVG(rating)
FROM
    full_reviews
GROUP BY title WITH ROLLUP;
 
 
SELECT 
    title, COUNT(rating)
FROM
    full_reviews
GROUP BY title WITH ROLLUP;
 
 
SELECT 
    first_name, released_year, genre, AVG(rating)
FROM
    full_reviews
GROUP BY released_year , genre , first_name WITH ROLLUP;
