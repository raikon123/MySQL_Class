DROP DATABASE IF EXISTS class_data;

CREATE DATABASE IF NOT EXISTS class_data;

USE class_data;


-- A Simple Example 

CREATE TABLE IF NOT EXISTS students_simple
(
	id INT
	,first_name VARCHAR(25)
	,last_name VARCHAR(25)
	,gender CHAR(1)
	,date_of_birth DATE
);

INSERT INTO students_simple VALUES
(1, 'Linus', 'Torvalds', 'M', '1969-12-28');

SELECT * FROM students_simple;

-- A Simple Example with Constraints

CREATE TABLE IF NOT EXISTS students_constrained
(
	 id INT AUTO_INCREMENT PRIMARY KEY
	,first_name VARCHAR(25) NOT NULL 
	,last_name VARCHAR(25) NOT NULL 
	,gender CHAR(1)
	,date_of_birth DATE DEFAULT '1900-01-01'
);

INSERT INTO students_constrained (first_name, last_name, gender, date_of_birth) VALUES
( 'Linus', 'Torvalds', NULL ,'1969-12-28');

SELECT * FROM students_constrained;

INSERT INTO students_constrained (first_name, last_name, gender) VALUES
( 'Bill', 'Gates', 'M');

SELECT * FROM students_constrained;

INSERT INTO students_constrained (first_name, last_name) VALUES
('Steve', 'Jobs');

SELECT * FROM students_constrained;

-- can insert in any order if you specify, but it will take the last number and add to it.  1, 2, 3, 10, 11....it wont back fill
-- go to next slide

-- create a table data.pitchfork
DROP DATABASE IF EXISTS class_data;

CREATE DATABASE IF NOT EXISTS class_data;

USE class_data;

CREATE TABLE IF NOT EXISTS class_data.pitchfork(

ReviewID int(11),
artist varchar(100) not null,
title varchar(100) not null,
release_year int,
genre varchar(100),
record_label varchar(100),
score numeric not null);




 

-- Alernatively, the primary key could be written as a table constraint
-- I also added a unique constraint on first_name, last_name, and date of birth

DROP TABLE IF EXISTS students_constrained;

CREATE TABLE IF NOT EXISTS students_constrained
(
	 id INT AUTO_INCREMENT
	,first_name VARCHAR(25) NOT NULL 
	,last_name VARCHAR(25) NOT NULL 
	,gender CHAR(1)
	,date_of_birth DATE DEFAULT '1900-01-01'
    ,PRIMARY KEY pk_studentID(id)
    ,UNIQUE uk_fn_ln_dob (first_name, last_name, date_of_birth)
);

INSERT INTO students_constrained (first_name, last_name, gender, date_of_birth) VALUES
( 'Linus', 'Torvalds', NULL ,'1969-12-28');

INSERT INTO students_constrained (first_name, last_name, gender) VALUES
( 'Bill', 'Gates', 'M');

INSERT INTO students_constrained (first_name, last_name) VALUES
('Steve', 'Jobs');

SELECT * FROM students_constrained;

-- Let's try to add Steve Jobs again

INSERT INTO students_constrained (first_name, last_name) VALUES
('Steve', 'Jobs');


-- Gradebook table for mysql workbench
DROP TABLE IF EXISTS grades; -- Must be dropped first because it has all the foreign keys
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS assignments;


CREATE TABLE IF NOT EXISTS students
(
	 id INT AUTO_INCREMENT
	,first_name VARCHAR(25) NOT NULL 
	,last_name VARCHAR(25) NOT NULL 
	,gender CHAR(1)
	,date_of_birth DATE DEFAULT '1900-01-01'
    ,PRIMARY KEY pk_studentID(id)
    ,UNIQUE uk_fn_ln_dob (first_name, last_name, date_of_birth)
);

CREATE TABLE IF NOT EXISTS assignments
(
	id INT AUTO_INCREMENT PRIMARY KEY
   ,assignment_category VARCHAR(25) DEFAULT 'Homework'
   ,assignment_description VARCHAR(500) NOT NULL
   ,date_assigned DATE NOT NULL
   ,date_due DATE
   ,max_points INT 
   ,bonus_assignment CHAR(1) DEFAULT 'N'
   ,UNIQUE uk_desc_date (assignment_description, date_assigned)
);

CREATE TABLE IF NOT EXISTS grades
(
	 id INT AUTO_INCREMENT
	,student_id INT NOT NULL
    ,assignment_id INT NOT NULL
	,grade DOUBLE NULL
    ,date_graded DATE
    ,late CHAR(1) DEFAULT 'N'
    ,redo CHAR(1) DEFAULT 'N'
    ,PRIMARY KEY pk_gradeID(id)
    ,CONSTRAINT fk_assignmentID FOREIGN KEY(assignment_id) REFERENCES assignments(id)
    ,CONSTRAINT fk_studentID FOREIGN KEY (student_id) REFERENCES students(id)
    ,UNIQUE uk_student_assignment (student_id, assignment_id,date_graded)
);

-- Load some data

-- Students
INSERT INTO students(first_name, last_name, gender, date_of_birth) VALUES
( 'Linus', 'Torvalds', NULL ,'1969-12-28');
INSERT INTO students(first_name, last_name, gender) VALUES
( 'Bill', 'Gates', 'M');
INSERT INTO students(first_name, last_name) VALUES
('Steve', 'Jobs');

-- Assignments
INSERT INTO assignments (assignment_description,date_assigned,date_due,max_points)
VALUES ('HW #1', '1996-02-29', '1996-03-31' , 10)
,('HW #2', '1996-03-10', '1996-04-15' , 5)
,('HW #3', '1996-03-20', '1996-04-30' , 10)
,('HW #4', '1996-03-30', '1996-05-15' , 5);

-- Grades
INSERT INTO grades(student_id, assignment_id, grade, date_graded)
VALUES
(1, 1, 3, '1990-06-01')
,(1, 2, 3, '1990-06-04')
,(1, 3, 9, '1990-06-02')
,(1, 4, 1, '1990-06-01')
,(2, 1, 7, '1990-06-01')
,(2, 2, 2, '1990-06-04')
,(2, 3, 5, '1990-06-02')
,(2, 4, 5, '1990-06-01')
,(3, 1, 10, '1990-06-01')
,(3, 2, 5, '1990-06-04')
,(3, 3, 10, '1990-06-02')
,(3, 4, 5, '1990-06-01');

-- Putting it all together

SELECT s.first_name
	  ,s.last_name
      ,s.gender 
      ,s.date_of_birth
      ,a.assignment_category
      ,a.assignment_description
      ,a.date_assigned
      ,a.date_due
      ,a.max_points
      ,a.bonus_assignment
      ,g.grade
      ,g.date_graded
      ,g.late
      ,g.redo
FROM grades g
JOIN students s
ON g.student_id=s.id
JOIN assignment a
ON g.assignment_id=a.id;

-- What is the grade in the course?

SELECT s.first_name,
s.last_name,
CONCAT(ROUND(sum(g.grade)/sum(a.max_points)*100),'%') as final_grade
FROM grades g
JOIN students s
ON g.student_id=s.idstudents_constrained
JOIN assignment a
ON g.assignment_id=a.id
GROUP BY first_name, last_name
ORDER BY ROUND(sum(g.grade)/sum(a.max_points)*100) desc; -- order by the string otherwise it will order 100, 53, 63....should be 100, 63, 53

