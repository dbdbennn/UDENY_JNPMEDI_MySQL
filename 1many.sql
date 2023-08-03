use book_shop;
CREATE TABLE contacts (
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);

INSERT into contacts (name, phone)
values ('billybob', '6761213455');

INSERT into contacts (name, phone)
values ('billybob', '676121345566');

CREATE TABLE users (
    username VARCHAR(20) NOT NULL,
    age INT CHECK (age > 0)
);

CREATE TABLE users2 (
    username VARCHAR(20) NOT NULL,
    age INT,
    CONSTRAINT age_not_negative CHECK (age >= 0)
);

INSERT INTO users (username, age) values('bluethecat',50);
INSERT INTO users (username, age) values('coltsteele',-3);

CREATE TABLE palindromes (
    word VARCHAR(100) CHECK (REVERSE(word) = word)
);

CREATE TABLE palindromes2 (
    word VARCHAR(100), 
    constraint word_is_palidnrome check(reverse(word) = (word))
);

INSERT INTO palindromes (word) values('baba');

SELECT 
    *
FROM
    users;

SELECT 
    *
FROM
    contacts;
    
    
CREATE TABLE companies (
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT name_address UNIQUE (name , address)
);

CREATE TABLE houses (
    purchase_price INT NOT NULL,
    sale_price INT NOT NULL,
    CONSTRAINT sprice_gt_pprice CHECK (sale_price >= purchase_price)
);

-- INSERT houses 
INSERT INTO houses (purchase_price, sale_price) values (100,200);
INSERT INTO houses (purchase_price, sale_price) values (300,250);


INSERT INTO companies (name, address) values('luigis pies', '123 spruce');
SELECT * FROM companies;

ALTER TABLE companies
ADD COLUMN phone varchar(15);

ALTER TABLE companies
ADD COLUMN employee_count INT NOT NULL DEFAULT 1;

ALTER TABLE companies
DROP COLUMN employee_count;

alter table houses add constraint positive_pprice CHECK (purchase_price >= 0);

insert into houses (purchase_price, sale_price) values (-1,4);

alter table houses drop constraint positive_pprice;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8 , 2 ),
    customer_id INT
);

use shop;

SELECT first_name, last_name, SUM(amount) as total FROM customers
JOIN orders
    ON customers.id = orders.customer_id
GROUP BY first_name, last_name
ORDER BY total;

SELECT 
    first_name, last_name, order_date, amount
FROM
    customers
        LEFT JOIN
    orders ON customers.id = orders.customer_id;
    
SELECT 
    first_name, last_name, order_date, amount
FROM
    orders
        LEFT JOIN
    customers ON customers.id = orders.customer_id;
    
SELECT 
    first_name, last_name, IFNULL(SUM(amount), 0) AS moeny_spent
FROM
    customers
        LEFT JOIN
    orders ON customers.id = orders.customer_id
GROUP BY first_name , last_name;

-- RIGTH JOIN
-- ===========
SELECT 
    first_name, last_name, order_date, amount
FROM
    customers
        RIGHT JOIN
    orders ON customers.id = orders.customer_id;
    
-- TEST
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50)
);

create table papers(
	title varchar(50),
	grade int,
	student_id int,
    foreign key (student_id) references students(id)
);
    
SELECT 
    first_name, title, grade
FROM
    students
        JOIN
    papers ON papers.student_id = students.id
ORDER BY grade DESC;    
    
SELECT 
    first_name, IFNULL(title, 'MISSING'), IFNULL(grade, 0)
FROM
    students
        LEFT JOIN
    papers ON papers.student_id = students.id;
    
SELECT 
    first_name, IFNULL(AVG(grade), 0) AS average
FROM
    students
        LEFT JOIN
    papers ON students.id = papers.student_id
GROUP BY first_name
ORDER BY average DESC; 
    
 
SELECT 
    first_name,
    IFNULL(AVG(grade), 0) AS average,
    CASE
        WHEN IFNULL(AVG(grade), 0) >= 75 THEN 'passing'
        ELSE 'failing'
    END AS passing_status
FROM
    students
        LEFT JOIN
    papers ON students.id = papers.student_id
GROUP BY first_name
ORDER BY average DESC;