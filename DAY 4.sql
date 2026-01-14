use himesh; 
select * from teachers;
select * from address;

-- THis table creates for Union and union all purpose only

CREATE TABLE admin (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    salary INT
);

INSERT INTO admin (id, name, email, gender, date_of_birth, salary) VALUES
(101, 'Anil Kumar', 'anil@example.com', 'Male', '1985-04-12', 60000),
(102, 'Pooja Sharma', 'pooja@example.com', 'Female', '1992-09-20', 58000),
(103, 'Rakesh Yadav', 'rakesh@example.com', 'Male', '1989-11-05', 54000),
(104, 'Fatima Begum', 'fatima@example.com', 'Female', '1990-06-30', 62000);

INSERT INTO admin (id, name, email, gender, date_of_birth, salary) VALUES
(105,'Aarav','aarav@example.com','Male','1995-05-14','65000.00');


Select * from admin ;

-- UNION and UNION ALL
-- Here we use union :-The UNION operator in SQL is used to combine the result sets of two or more SELECT statements. 
--   It removes duplicates by default. and As result name Aarav in both table and remove the duplicates.

Select name, email, id from teachers Union select name , email, id  from admin ;

Select name, email, id,gender from teachers where gender= 'male' Union select name , email, id,gender  from admin where gender ='male';

-- Union ALL :-UNION ALL is used to combine the result sets of two or more SELECT queries and keeps all rows, including duplicates.
-- It does NOT remove duplicates.  As shown in query name Aarav comes two times 

Select name, email, id from teachers Union All select name , email, id  from admin ;

-- VIEWS:- A VIEW is a virtual table created using a SQL SELECT query.


create view Highs as select * from teachers where salary >50000 and  gender = 'male';
select * from highs;


create view Hig as select * from teachers where salary >70000 and  gender = 'male';
select * from hig;

create view FH as select * from teachers where salary >70000 and  gender = 'female';
select * from FH;

create view FHD as select * from teachers where salary >70000 and  gender = 'female'  order by date_of_birth;
select * from FHD;

-- MySQL Indexes

show indexes from teachers;

-- create indexes 
CREATE INDEX idx_himesh ON teachers(gender);
CREATE INDEX idx_SAL ON teachers(salary);

-- usage , its work fast as per normal query 
SELECT * FROM teachers WHERE gender = 'Female' AND salary > 70000;
SELECT * FROM teachers WHERE gender = 'male' AND salary > 70000;

-- Drop

DROP INDEX idx_himesh ON teachers;
DROP INDEX idx_SAL ON teachers;

-- Subqueries in MySQL :-A subquery is a query nested inside another query.

select avg(salary) AS Average_salary from teachers;

select name, id , email , salary  from teachers where salary < (select avg(salary) from teachers);

SELECT name ,salary FROM teachers
WHERE date_of_birth = (SELECT MIN(date_of_birth) FROM teachers);

SELECT name, salary, date_of_birth, TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS current_age FROM teachers WHERE date_of_birth = (SELECT MIN(date_of_birth) FROM teachers);






