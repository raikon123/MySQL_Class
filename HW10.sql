    
-- 1
CREATE UNIQUE INDEX index_vendor_zip_code ON ap.vendors(vendor_zip_code); 

-- 2 create table statements
USE ex;
DROP TABLE IF EXISTS members;
CREATE TABLE IF NOT EXISTS members
(
	member_id INT PRIMARY KEY
	,first_name VARCHAR(35)
	,last_name VARCHAR(35)
    ,address VARCHAR(35)
    ,city VARCHAR(35)
    ,state CHAR(2)
    ,phone varchar(25)
);

DROP TABLE IF EXISTS groups;
CREATE TABLE IF NOT EXISTS groups
(
	group_id INT PRIMARY KEY
    ,group_name VARCHAR(35)
);

DROP TABLE IF EXISTS members_groups;
CREATE TABLE members_groups
(
	member_id INT REFERENCES members
    ,group_id INT REFERENCES groups
);



-- 3 insert statement
INSERT INTO members(member_id) VALUES(1);
INSERT INTO members(member_id) VALUES(2);
INSERT INTO groups(group_id) VALUES(1);
INSERT INTO groups(group_id) VALUES(2);

-- SELECT STATEMENTS
SELECT distinct g.group_name, m.last_name, m.first_name
FROM members m
inner JOIN groups g
ON m.member_id = g.group_id
inner JOIN members_groups as mg
ON m.member_id = mg.member_id
group by g.group_name,m.last_name, m.first_name
ORDER BY g.group_name,m.last_name, m.first_name ;




-- 4 alter table statement
ALTER TABLE ex.members
ADD annual_dues varchar(50) NOT NULL DEFAULT '52.50';

ALTER TABLE ex.members
ADD  payment_date DATE NOT NULL;


-- 5 alter table statement
ALTER TABLE ex.groups
MODIFY group_id INT NOT NULL UNIQUE;

ALTER TABLE ex.groups
MODIFY group_name VARCHAR(50) NOT NULL UNIQUE; 




