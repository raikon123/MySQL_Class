CREATE DATABASE IF NOT EXISTS homework11;

USE homework11;

DROP TABLE IF EXISTS batting;

create table batting
(
	playerID varchar(25),
    yearID int,
    stint varchar(25),
    teamID varchar(25),
    IgID int,
    G int,
    AB int,
    R int,
    H int,
    2B int,
    3B int,
    HR int,
    RBI int,
    SB int,
    CS int,
    BB int,
    SO int,
    IBB int,
    HBP int,
    SH int,
    SF int,
    GIDP int,
    primary key(playerID, yearID, stint, teamID));


load data local infile 'C:/Users/njohnson1/Desktop/intro to SQL/batting.csv'
	into table batting
	columns terminated by '\t'
    enclosed by '"'
    ignore 1 lines;



select * from batting;


-- Qa: Which baseball player(s) had the most home runs (HR) in 2010 according to the batting table
select nameGiven, max(HR)
from batting as b
join master_data as md
on b.playerID = md.playerID
where yearID = 2010;

-- David Allan	54


drop table if exists master_data;

create table master_data
(
	playerID varchar(50) primary key,
    birthYear char(4),
    birthMonth char(2),
    birthDay char(2),
    birthCountry varchar(50),
    birthState varchar(50),
    birthCity varchar(50),
    deathYear char(4),
    deathMonth char(2),
    deathDay char(2),
	deathCountry varchar(50),
    deathState varchar(50),
    deathCity varchar(50),
    nameFirst varchar(50),
    nameLast varchar(50),
    nameGiven varchar(50),
    weight varchar(50),
    height varchar(50),
    bats char(2),
    throws char(1),
    debut date,
    finalGame date,
    retroID varchar(50),
    bbrefID varchar(50)
);

load data local infile 'C:/Users/njohnson1/Desktop/intro to SQL/master.csv'
	into table master_data
    fields terminated by ','
    ignore 1 lines;

select * from master_data;    


drop table if exists fielding ;

create table fielding
(
	playerID varchar(25) primary key,
    yearID int,
    stint varchar(3),
    teamID char(2),
    IgID int,
    pos varchar(2),
    g int,
    gs int,
    InnOuts int,
    PO int,
    A int,
    E int,
    DP int
);
    
load data local infile 'C:/Users/njohnson1/Desktop/intro to SQL/fielding.csv'
	into table fielding
    fields terminated by '|'
    lines terminated by '\r'
    ignore 1 lines;
    
select * from fielding;

-- Qc:Which fielder(s) started the most games (GS) in 2006? 
select nameGiven, max(GS)
from fielding as f
join master_data as md
on f.playerID = md.playerID
where yearID =2006;

-- Reginald Damascus	150


drop table if exists pitching; 

create table pitching
(
	playerID varchar(50) primary key,
    yearID varchar(50),
    stint varchar(3),
    teamID char(2),
    IgID varchar(50),
    W varchar(50),
    L varchar(50),
    G varchar(50),
    GS varchar(50),
    CG varchar(50),
    SHO varchar(50),
    SV varchar(50),
    IPouts varchar(50),
    H varchar(50),
    ER varchar(50),
    HR varchar(50),
    SO varchar(50),
    BAOpp decimal(5,3),
    ERA decimal(5,3),
    IBB varchar(50),
    WP varchar(50),
    HBP varchar(50),
    BB varchar(50),
    BFP varchar(50),
    GF varchar(50),
    R varchar(50),
    SH varchar(50),
    SF varchar(50),
    GIDP varchar(50)
    );

load data local infile 'C:/Users/njohnson1/Desktop/intro to SQL/pitching.csv'
	 into table pitching
     fields terminated by ';'
     lines terminated by '\r' 
     ignore 1 lines;
    
select * from pitching;


-- Qb:Which pitcher(s) had the lowest non-zero ERA in 2002?
select nameGiven, min(ERA) 
from pitching as p
join master_data as md
on p.playerID = md.playerID
where yearID = 2002 AND ERA <> 0;

-- Jeremy David	0.150


