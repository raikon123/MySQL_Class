
create database hw11;

Use hw11;

drop table avmaster;

CREATE TABLE avmaster

(playerID varchar(25) primary key,

birthYear int,

birthmonth int,

birthdat int,

birthcountry varchar(25),

Birthstate char(25),

birthcity char(25),

deathyear int,

deathmonth int,

deathday int,

deathcountry char(25),

deathstate char(25),

deathcity char(25),

nameFirst char(25),

nameLast char(25),

nameGiven varchar(25),

weight int,

height int,

bats char(5),

throws char(5),

debut date,

finalGame date,

retroID varchar (25),

bbrefID varchar(25));

Load data local infile 'C:/Users/saints/Downloads/master.csv'

Into table avmaster columns terminated by ',';

select * from avmaster;

drop table avbattings;

Create table avbattings

(playerID varchar (25), yearid int, stint varchar(25), teamID varchar(25),

IgID int, G int, AB int, R int, H int, 2B int, 3B INT, HR INT, RBI INT, SB INT, CS INT,

BB INT, SO INT, IBB INT, HBP INT, SH INT, SF INT,

GIDP INT, primary key(playerID, yearID, stint, teamID));

Load data local infile 'C:/Users/saints/Downloads/batting.csv'

Into table avbattings COLUMNS TERMINATED BY '\t'

ENCLOSED BY '"'

IGNORE 1 LINES;

select * from avbattings;

drop table avpitching;

Create table avpitching

(playerID varchar (25), yearid int, stint varchar(25), teamID varchar(25),

IgID int, W INT, L INT, G INT, GS INT, CG INT, SHO INT, SV INT, IPOUTS INT, H INT, ER INT,

HR INT, BB INT, SO INT, BAOpp DEC(8,4), ERA DEC(8,4), IBB INT, BK INT, BFP INT, GF INT, R INT, SH INT,

SF INT, GIDP INT,

primary key(playerID, yearID, stint, teamID));

Load data local infile 'C:/Users/saints/Downloads/pitching.csv'

Into table avpitching

Columns terminated by ';'

Lines terminated by '\r'

Ignore 1 lines ;

select * from avpitching;

Create table avfielding

(playerID varchar(25),

yearID int, stint int, teamID varchar(25),

IgID varchar(25), pos varchar(25), G varchar(25),

GS INT, INNOUTS INT, PO INT, A INT, E INT, DP INT,

PRIMARY KEY(playerID, yearID, stint, teamID, POS));



Load data local infile 'C:/Users/saints/Downloads/fielding.csv'

Into table avfielding Columns terminated by '|'

Lines terminated by '\r'

Ignore 1 lines ;

select * from avfielding;







select HR, playerID from avbattings where yearid=2010 order by HR desc;

-- Beutiio02

select ERA, playerID from avpitching
 where yearid=2002 and ERA not like '0.0000'
 order by ERA;
 -- whiteri01
 
 select playerID, GS from avfielding where yearid=2006 order by gs desc
 
 -- francie02

