create database lesson3;
use lesson3;

create table pitchfor_reviews_copy as
select *
from pitchfork.reviews;

select *
from lesson3.pitchfork_reviews_copy;

create table pitchfork_perfect_albums as
select *
from pitchfork.reviews
where score = 10;

select max(score)
from pitchfork_perfect_albums;

use pets;

alter table pets modify column OwnerID integer;
alter table owners modify column OwnerID integer;

create table pets.old_animals as
select pets.name as pet_name
,concat(owners.name, " ",owners.surname) as owner_name
,pets.Kind as pet_type
,pets.Age as pet_age
,case when pets.age < 5 then  "young"
	when pets.age < 10 then "middle aged"
	else "old" end as pet_age_category
,upper(left(pets.gender,1)) as pet_gender
from pets.pets
join pets.owners
on pets.OwnerID = owners.ownerID
where pets.age > 10; 

-- An even more complicated example
CREATE TABLE pets.pet_narrative AS
SELECT pets.name AS 'pet_name'
,CONCAT(owners.name,' ',owners.surname) AS owner_name
,pets.Kind AS pet_type,pets.Age AS pet_age
,CASE WHEN pets.Age < 5 THEN 'young'  
	WHEN pets.Age < 10 THEN 'middle aged'
    ELSE 'old' 
    END as pet_age_category
    ,UPPER(LEFT(pets.Gender,1)) AS pet_gender
    ,CONCAT(pets.name,' (',UPPER(LEFT(pets.Gender,1)),') is a '
    ,CASE WHEN pets.Age < 5 THEN 'young'
    WHEN pets.Age < 10 THEN 'middle aged'
    ELSE 'old' 
    END
,' ',pets.Kind,', owned by '
,CONCAT(owners.name,' ',owners.surname)
,' who lives in ',owners.City,', ',StateFull,'.')


use lesson3;

-- Create some empty tables for insert and delete examples
CREATE TABLE students
(
id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL
,student_first_name VARCHAR(50) NULL
,student_middle_name VARCHAR(50) NULL
,student_last_name VARCHAR(50) NOT NULL);

CREATE TABLE assignments
(
id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL
,assignment VARCHAR(100) NOT NULL
,date_assigned DATETIME NOT NULL
,date_due DATETIME NOT NULL);

CREATE TABLE grades
(
id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL
,student_id INTEGER NOT NULL
,assignment_id INTEGER NOT NULL
,grade VARCHAR(1) NULL
,date_graded DATETIME NULL);

-- Insert with nulls
INSERT INTO students (student_first_name, student_middle_name, student_last_name) 
VALUES('Bob', NULL , 'Ross')
,('Bob', NULL , 'Dylan')
,('Larry', 'The', 'Cableguy')
,('Homer', 'Jay', 'Simpson')
,('Lightning', NULL, 'McQueen')
,('Maxwell', 'House', 'Coffee')

-- Add 3 more with a new insert statement
,("A", "B", "C")
,("X", "Y", "Z")
,("1", "2", "3");

INSERT INTO assignments (assignment, date_assigned, date_due) 
VALUES ('Catch an orange cat', '2018-02-22', '2018-02-24')
,('Ride an ostrich', '2018-02-27', '2018-03-11')
,('Teach a monkey to drive', '2018-03-30','2018-05-11')

-- Add 2 more with new insert statement
,("Blah Blah Blah", "2018-06-12", "2018-07-12")
,("Why", "2018-08-12", "2018-09-12");

-- Insert from select statement
-- Give give every student a 'C' for every assignment and set the date graded to '2018-02-12'
INSERT INTO grades (student_id, assignment_id, grade, date_graded)
SELECT s.Id, a.id, 'C', '2018-02-12'
FROM students s
CROSS JOIN assignments a;
select * from grades;
-- Insert from join
-- Insert some more rows into students from the pets table with their pets at the middle name
INSERT INTO students (student_first_name, student_middle_name, student_last_name)
SELECT o.Name, p.name, Surname
FROM pets.owners o
JOIN pets.pets p
on o.ownerID=p.OwnerID;

-- DELETE STATEMENTS
-- Disable safe mode. Hold onto your hats. Preferences -> SQL Editor-- delete everyone with no middle name
DELETE FROM students
WHERE student_middle_name IS NULL;

-- delete everyone by last name who owns a cat
DELETE FROM students
WHERE student_last_name IN
(
SELECT Surname
FROM pets.owners o
JOIN pets.pets p
on o.ownerID=p.OwnerID
WHERE p.kind='cat'
);
-- UPDATE statements-- Set all grades to 'F'UPDATE grades
SET grade='F';

-- Give 'Homer Jay Simpson' straight A's and assigned the graded date to today
UPDATE gradesSET grade='A',date_graded = current_date()
WHERE student_id= ?;

-- Throw it all in the trash
TRUNCATE TABLE students;

-- or
DELETE FROM students;



    