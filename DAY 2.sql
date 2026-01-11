use himesh; 
select * from teachers;

-- Write Queries using SELECT, Where and many more 

Select name , email from teachers;

SELECT * FROM teachers WHERE date_of_birth IS not NULL;

select * from teachers where gender = 'male' ;

--  here <> means not equal to 
select * from teachers where gender <> 'male' ;

-- IN BELOW query we use some basic things like limit , orderby and more 

Select * from teachers where salary >= 70000 and gender <> 'male' order by id Asc;
Select * from teachers where salary >= 70000 and gender <> 'male' order by id Desc limit 4;
Select name, salary  from teachers where date_of_birth between '1995-05-14' and '2000-05-14' and gender<> 'female';

-- try to find the highest salary among them 

SELECT * FROM teachers WHERE salary = (SELECT MAX(salary) FROM teachers);

-- try to find eldest person in Tabel , MIN(date_of_birth) → earliest date → eldest person

SELECT * FROM teachers WHERE date_of_birth = (SELECT Min(date_of_birth) FROM teachers);

Select * from teachers where gender in('other','female');


-- Update the table, here in this query change the gender of name aisha by the help of SET Clause

update teachers set gender = 'other' where name = 'aisha';

update teachers set salary = 95000 where name ='Sneha' ;

UPDATE teachers SET name = 'Aisha Khan' WHERE email = 'aisha@example.com';
select * from teachers;

-- if execute the query then This query will overwrite salary for every user
-- UPDATE teachers SET salary = 88000;

-- The DELETE statement removes rows from a table. 
delete from teachers where id =7;  -- in this query id =7 is deleted 

-- DELETE FROM teachers; if execute this query then delete all rows from table , so whn u use delete statemet , use carefully orr kept the backup of your data

-- SQL Functions
-- 1.Aggregate Functions  
--  COUNT(), min() , max(), sum(), avg(), group by()
Select count(*) from teachers ;
Select count(*) As No_of_male from teachers where gender = 'male'    ;

Select gender ,max(salary) as Max_salary ,min(salary) as Min_salary, sum(salary) as total_amount , Avg(salary) as Average_package  from teachers  group by gender;

-- 2.String functions 
-- length(), upper(),lower(), concat()

Select length(name) as count_words ,lower(name) as LN, upper(name) as UN , concat(name ,'-', year(date_of_birth)) as User_name from teachers limit 10;


-- 3. Mathematical Functions -> ROUND(), FLOOR(), CEIL()

SELECT salary,
       ROUND(salary) AS rounded,
       FLOOR(salary) AS floored,
       CEIL(salary) AS ceiled FROM teachers;

-- 5.. Conditional Function -> IF()
SELECT name, gender,
       IF(gender = 'Female', 'Yes', 'No') AS is_female FROM teachers;

 




