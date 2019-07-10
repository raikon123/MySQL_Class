create database lecture9;

use lecture9;

drop table if exists painters;

create table painters
( 
	id int primary key,
    first_name varchar(25),
    last_name varchar(25));
    
load data local infile "C:/Users/njohnson1/Desktop/intro to SQL/painters.txt" 
	into table painters
    columns terminated by ',';

    
select * 
from painters;

drop table if exists paintings;

create table paintings
( 
	id int auto_increment primary key,
	painter_id int references painters(id),
    painting_name varchar(100));
    
load data local infile "C:/Users/njohnson1/Desktop/intro to SQL/paintings.txt" 
	into table paintings
    columns terminated by '|'
    enclosed by '"'
    (painter_id, painting_name);
    
select * 
from paintings;

drop table if exists people;


create table people
( 
	id int auto_increment primary key,
	first_name varchar(25),
    last_name varchar(25),
    date_of_birth date,
    gender char(1),
    insert_date timestamp);
    
load data local infile "C:/Users/njohnson1/Desktop/intro to SQL/people.txt" 
	into table people
    columns terminated by '\t'
    ignore 1 lines -- helps to ignore the worthless data
	(first_name, last_name, date_of_birth, gender);
    
select *
from people;



drop table if exists script;


create table script
(  
    id int auto_increment primary key,
	speaker varchar(25),
    script_line int,
    script_text varchar(500),
    insert_date timestamp);
    
load data local infile "C:/Users/njohnson1/Desktop/intro to SQL/script.txt" 
	into table script
    columns terminated by ';'
    enclosed by '"'
    escaped by '~'
    ignore 1 lines -- helps to ignore the worthless data
	(speaker, script_line, script_text);
    
select *
from script;








    
    
