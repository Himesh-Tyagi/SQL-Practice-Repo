-- Autocommits
-- Primary And foreign key, auto increment ,unique ,
use himesh; 

-- create another table for foreign key

CREATE TABLE address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    pincode VARCHAR(10),
    FOREIGN KEY (user_id) REFERENCES teachers(id)
);

INSERT INTO address (user_id, street, city, state, pincode)
VALUES
(1, '221B MG Road', 'Mumbai', 'Maharashtra', '400001'),
(22, '14 Park Street', 'Kolkata', 'West Bengal', '700016'),
(3, '32 Residency Road', 'Bengaluru', 'Karnataka', '560025'),
(24, '5 North Usman Road', 'Chennai', 'Tamil Nadu', '600017'),
(5, '17 Hazratganj', 'Lucknow', 'Uttar Pradesh', '226001'),
(6, '55 Banjara Hills', 'Hyderabad', 'Telangana', '500034'),
(7, '88 Connaught Place', 'Delhi', 'Delhi', '110001'),
(8, '10 MG Marg', 'Dehradun', 'Uttarakhand', '248001'),
(9, '23 Brigade Road', 'Bengaluru', 'Karnataka', '560025'),
(10, '45 Marine Drive', 'Mumbai', 'Maharashtra', '400020'),
(11, '67 Ashoka Road', 'Delhi', 'Delhi', '110001'),
(12, '89 MG Road', 'Pune', 'Maharashtra', '411001'),
(13, '12 Brigade Road', 'Bengaluru', 'Karnataka', '560025'),
(14, '34 Park Street', 'Kolkata', 'West Bengal', '700016'),
(15, '56 Connaught Place', 'Delhi', 'Delhi', '110001'),
(16, '78 Marine Drive', 'Mumbai', 'Maharashtra', '400020'),
(17, '90 MG Marg', 'Dehradun', 'Uttarakhand', '248001'),
(18, '11 North Usman Road', 'Chennai', 'Tamil Nadu', '600017'),
(19, '33 Residency Road', 'Bengaluru', 'Karnataka', '560025'),
(20, '22 Hazratganj', 'Lucknow', 'Uttar Pradesh', '226001');

-- we can see clearly that both the tables teachers and address connect now with the help of FK

select * from teachers;
select * from address;

-- Joins 
-- Use of inner join 
select teachers.name , address.city  from  teachers inner join  address on teachers.id=address.id ;

select teachers.email, teachers.name , address.state, address.pincode from teachers inner join address on teachers.id=address.id;

--  use left join

select teachers.name, teachers.salary,teachers.gender , address.city ,address.pincode from  teachers left join  address on teachers.id=address.id ;



-- right join
select teachers.name, teachers.salary,teachers.gender , address.city ,address.pincode from  teachers right join  address on teachers.id=address.id ;

select teachers.name, teachers.salary,teachers.gender , address.city ,address.pincode from  address right join  teachers on address.id= teachers.id ;



