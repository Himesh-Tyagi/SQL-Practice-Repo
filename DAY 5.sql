-- Stored Procedures in MySQL :-A stored procedure is a saved SQL block that can be executed later.
--  It's useful when you want to encapsulate logic that can be reused multiple times — like queries, updates, or conditional operations.
--  Simple words: Ek baar likho, baar-baar use karo\
use himesh; 

DELIMITER $$

CREATE PROCEDURE tech()
BEGIN
    Select * from teachers;
END$$

DELIMITER ;
call tech();

DELIMITER $$

CREATE PROCEDURE sl()
BEGIN
    Select name, gender from teachers where salary > 50000 order by salary;
END$$

DELIMITER ;
call sl();

drop procedure sl;


-- triggers in sql:-A trigger is a database object that is automatically executed (or “fired”) by the database in response to specific 
-- events—such as INSERT, UPDATE, or DELETE—occurring on a particular table.










