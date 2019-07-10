-- HW #10
-- Nick Johnson
-- Ch. 11 1-5

-- 1.
create index zip_code
on ap.vendors (vendor_zip_code);
 
-- 2.  
use ex;

drop table if exists members; 
drop table if exists members_groups;
drop table if exists groups;

create table if not exists members (
	member_id int primary key auto_increment,
	first_name varchar(25) not null,
    last_name varchar(25) not null,
    address varchar(255) not null,
    city varchar(255) not null,
    state char(2) not null,
    phone varchar(25) not null);
   
    
create table if not exists groups (
	group_id int primary key auto_increment,
    group_name varchar(255) not null);
     
    
create table if not exists members_groups (
	member_id int not null,
    group_id int not null,
    constraint members_group_fk_members foreign key (member_id) references members (member_id),
     constraint members_group_fk_groups foreign key (group_id) references groups (group_id));


-- 3. 
use ex;

insert into members
values (default, 'John', 'Smith', '334 Valencia St.', 'San Francisco', 'CA', '415-942-1901');
insert into members
values (default, 'Jane', 'Doe', '872 Chetwood St.', 'Oakland', 'CA', '510-123-4567');

insert into groups
values (default, 'Book Club');
insert into groups
values (default, 'Bicycle Coalition');
insert into members_groups
values (1, 2);
insert into members_groups
values (2, 1);
insert into members_groups
values (2, 2);

select g.group_name, m.last_name, m.first_name
from groups g
	join members_groups mg
on g.group_id = mg.group_id
	join members m
on mg.member_id = m.member_id
order by g.group_name, m.last_name, m.first_name;


-- 4
alter table members
add annual_dues decimal(5,2) default 52.50;

alter table members
add payment_date  date;

-- 5
alter table groups
modify group_name varchar(50) not null unique;

insert into groups (group_name)
values ('Book Club');



