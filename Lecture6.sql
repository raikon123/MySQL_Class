
/****************CHAR AND VARCHAR*****************/
select
length('Dog') as Dog,
length('σκύλος') as `Dog in Greek`,
length('Dog the bo') as `Dog the bounty hunter`;

SELECT'❌❌❌❌',
length('❌❌❌❌'),
'我爱你',
length('我爱你'),
'❌',
length('❌');

/*******************GUESS THE CONVERSION********************/

-- 1.
SELECT invoice_total, CONCAT('$', invoice_total) as invoice_dollars
FROM ap.invoices;

-- 2.
SELECT invoice_number, 989319/invoice_number as what_does_this_even_mean
FROM ap.invoices;

-- 3.
SELECT invoice_date, invoice_date + 1 as one_more_day
FROM ap.invoices;

-- 4.
SELECT YEAR(20150417) as check_this_out;

-- 5.
SELECT '2'/'5' as fractions;

-- 6.
SELECT '2' + 'Cat' - 1 as huh;

-- 7
SELECT '2' + '2Cat4' - 1 as huh_the_sequel;

/*******************EXPLICIT CONVERSION*******************/

-- to char
SELECT CAST(12345 AS CHAR) AS num_to_char
,CAST(12345 AS CHAR(2)) AS num_to_char_short;

-- to date
SELECT CAST(20150101 as DATE) AS int_to_date,
CAST(20150101 as DATETIME) AS int_to_datetime,
CAST('20150101' as DATETIME) AS char_to_datetime,
CAST(20150101182132 as DATETIME) AS int_to_datetime_with_minutes,
CAST(1214 as TIME) as int_to_time;

-- to INT and DECIMAL
SELECT CAST('CAT' as SIGNED) cat_to_signed_int,
CAST('CAT' as UNSIGNED) cat_to_unsigned_int,
CAST('123.32' as SIGNED) string_to_signed_int,
CAST('-123,32' as SIGNED) string_to_signed,
CAST('-123,32' as UNSIGNED) string_to_unsigned

 -- Note this is bonkers
 ,CAST('23453,23423' as DECIMAL(9,2)) as string_to_decimal; 
 
 -- Note this one isn't so hot either.
 -- Bottom line is be careful
 /***************************FORMAT and CHAR***************************/
 -- Format
 
 SELECT FORMAT(2143124512.21341,3) as formatted_int,
 FORMAT('214312.21341',3) as formatted_int_implicit,
 FORMAT('214312.21341',0) as formatted_int_implicit_no_decimal;
 
 -- CHAR
 SELECT CONCAT(vendor_name, CHAR(13,10), vendor_address1, 
 CHAR(13,10),vendor_city, ', ', vendor_state, ' ', vendor_zip_code)
 
 FROM ap.vendorsWHERE vendor_id = 1;
 
 -- The query above returns this
 -- 'US Postal Service\r\nAttn:  Supt. Window Services\r\nMadison, WI 53707'
 -- or you can get a BLOB
 
 SELECT CONCAT('The big dog', CHAR(13,10), 'is over there.') as sentence;
 
 -- taming the blob
 SELECT CONCAT(CAST('The big dog' as CHAR), CHAR(13,10), 
 CAST('is over there.' AS CHAR)) as sentence;

/*******************NUMERIC FUNCTIONS*******************/
-- ROUNDING
SELECT ROUND(12.59, 0) as round_0,
ROUND(12.59, 1) as round_1,
TRUNCATE(12.59, 0) as truncate_0,
TRUNCATE(12.59,1) as truncate_1,
CEILING(12.1) as ceiling,
CEILING(-12.9) as neg_celing,
FLOOR(12.9) as floor,
FLOOR(-12.1) as neg_floor;

-- OTHER MATH FUNCTIONS
SELECT
SIGN(-213432.323) as neg_sign,
SIGN(2342343.234) as pos_sign,
POWER(2,4) as power,
RAND() as random,
RAND(5) as random_seed,
RAND(5) as random_seed2;

-- Special trick to get a random number between 0 and 9
SELECT FLOOR(RAND()*10) as rand_int,
FLOOR(RAND()*10) as rand_int2,
FLOOR(RAND()*10) as rand_int3,
FLOOR(RAND()*10) as rand_int4,
FLOOR(RAND()*10) as rand_int5;

-- randomize the order of a table

select *, rand() -- shows the random number
from ap.invoices
order by rand();

select 
round(12.5, 1);

-- YOU DO SOME
-- 1. What is 5^8?
select
Power(5,8) as power;

-- 2. What is the square root of 123456789?
select 
SQRT(123456798) as sqrt;

-- 3. What is the random number that comes up with the seed 1776?
select
rand(1776) as seed;

/*******************WORKING WITH FLOATS******************/

DROP TABLE IF EXISTS ap.floats;
CREATE TEMPORARY TABLE IF NOT EXISTS ap.floats (
float_id INT NOT NULL AUTO_INCREMENT,
float_value DOUBLE NOT NULL,
PRIMARY KEY (float_id));

INSERT INTO ap.floats (float_value) VALUES
(0.999999999999),
(1),
(1.000000000001),
(1234.56779023456),
(999.0002345),
(24.346234);

SELECT *
 FROM ap.floats 
 WHERE float_value = 1;
 
 SELECT * 
 FROM ap.floats 
 WHERE float_value between 0.99 and 1.01;
 
 SELECT * FROM ap.floats WHERE round(float_value,2) = 1.00;
 
 /**************************STRING FUNCTIONS**************************/
 -- STRING TRANSFORMATIONS
 SELECT
 UPPER('uppercase') as get_on_up,
 LOWER('LOWERCASE') as get_low,
 REVERSE('SDRAWKCAB') as back_it_up;
 
 -- CONCAT
 SELECT
 CONCAT('CAT', 'DOG', 'MOUSE') as concat,
 CONCAT_WS(' ', 'CAT', 'DOG', 'MOUSE') as concat_space,
 CONCAT_WS('❌', 'CAT', 'DOG', 'MOUSE') as concat_wink;
 
 -- TRIM
 SELECT
 LTRIM('     Yo   ') as ltrim,
 TRIM(LEADING FROM'     Yo   ') as ltrim_alt,
 RTRIM('     Yo   ') as rtrim,
 TRIM(TRAILING FROM'     Yo   ') as rtrim_alt,
 TRIM('     Yo   ') as trim_both,
 TRIM(BOTH FROM'     Yo   ') as trim_both_alt,
 TRIM(BOTH '❌' FROM '❌❌❌❌Yo❌❌❌') as trim_char;
 
 -- PADS
 SELECT
 LPAD('AA',10,'B') as pad_to_the_left,
 RPAD('AA',10,'B') as pad_to_the_right,
 CONCAT(SPACE(8),'AA') as give_me_space,
 REPEAT('HA',10) as why_so_serious;
 
 -- LENGTHS and LOCATIONS
 SELECT LENGTH('ABC') as len_abc,
 LENGTH('❌') as len_blah,
 LEFT('abc123',3) as to_the_left,
 RIGHT('abc123',3) as to_the_right;
 
-- SOME MORE COMPLICATED STRING FUNCTIONS
SELECT  LOCATE('waldo','abcdewaldofg') as wheres_waldo,
SUBSTRING('abcdewaldofg', 6, 5) as heres_waldo,
SUBSTRING_INDEX('aaaaabbbbb','b',2) before_second_b,
SUBSTRING_INDEX('aaaaabbbbb','a',-2) before_second_a_backwards,
REPLACE('I LOVE MONEY!', 'MONEY', 'NOTHING') as money_for_nothing,
INSERT('I LOVE MONEY!', 8,0, 'GIVING AWAY ') as altruism,
INSERT('I LOVE MONEY!', 8,5, 'DOGS') as k9_lvr;

-- HOW TO USE SUBSTRING, LOCATE, and SUBSTRING_INDEX TO PARSE A STRING
SELECT SUBSTRING_INDEX('JOHN L DOE', ' ', 1) as first_name,
SUBSTRING_INDEX('JOHN L DOE', ' ', -1) as last_name,
SUBSTRING('JOHN L DOE', 6, 1) as middle_initial_specific,
SUBSTRING('JOHN L DOE', 
LOCATE(' ', 'JOHN L DOE')+1, 1) as middle_initial_general,
LEFT(SUBSTRING_INDEX('JOHN L M DOE', ' ', -2),1) as second_middle_initial;

/**************************DATE and TIME Functions**************************/
-- What time is it?
SELECT
NOW() as now_is_the_time,
SYSDATE() as sys_date,
CURRENT_TIMESTAMP() as cur_timestamp,
CURDATE() as cur_date,
CURTIME() as cur_time,
UTC_DATE() as gmt_date,
UTC_TIME() as gmt_time;

select
sign(-234);

-- These don't seem to work on the MAC
SELECT CURRENT_DATE() as current_date,
CURRENT_TIME() as current_time;

-- DATE PARTS
SELECT
YEAR(NOW()) as year_num,
MONTH(NOW()) as month_num,
DAYOFMONTH(NOW()) as day_of_month,
DAYOFWEEK(NOW()) as week_day,
DAYOFYEAR(NOW()) as year_day,
QUARTER(NOW()) as year_quarter,
WEEK(NOW()) as week_sun_start,
WEEK(NOW(),1) as week_mon_start,
LAST_DAY(NOW()) as last_day_of_month 

-- DOES NOT AGREE WITH BOOK
,DAYNAME(NOW()) as name_of_day,
MONTHNAME(NOW()) as name_of_month;

-- TIME PARTS
SELECT
HOUR(NOW()) as hr,MINUTE(NOW()) as `min`,
SECOND(NOW()) as sec;

-- Let's put it together
SELECT
CONCAT('Today is ',DAYNAME(NOW()), ', ', MONTHNAME(NOW()), ' ', DAYOFMONTH(NOW()),', ',YEAR(NOW()),'. The current time is ', CURTIME(), '.') as today;

-- The EXTRACT function. All you'd ever want to parse
SELECT NOW() as `now`,EXTRACT(SECOND FROM NOW()) as sec,
EXTRACT(MINUTE FROM NOW()) as `min`,
EXTRACT(HOUR FROM NOW()) as hr,
EXTRACT(DAY FROM NOW()) as `day`,
EXTRACT(MONTH FROM NOW()) as `month`,
EXTRACT(YEAR FROM NOW()) as `year`,
EXTRACT(MINUTE_SECOND FROM NOW()) as min_sec,
EXTRACT(HOUR_MINUTE FROM NOW()) as hr_min,
EXTRACT(DAY_HOUR FROM NOW()) as day_hr 

-- this guy doesn't seem to work on the max
,EXTRACT(YEAR_MONTH FROM NOW()) as yr_month,
EXTRACT(HOUR_SECOND FROM NOW()) as hr_sec,
EXTRACT(DAY_MINUTE FROM NOW()) as day_min
 -- this guy doesn't seem to work on the mac
 
 ,EXTRACT(DAY_SECOND FROM NOW()) as day_sec;
 
 -- DATE MATH
 SELECT TIME_TO_SEC(curtime()) as sec_since_midnight,
 TO_DAYS(curdate()) as days_this_millenium;
 
 SELECT DATEDIFF(CURDATE(),'2018-01-01') as days_this_year,
 DATEDIFF('2018-01-01', CURDATE()) as neg_days_this_year,
 DATE_ADD(NOW(), INTERVAL 2 DAY) as spring_break_start,
 DATE_ADD(NOW(), INTERVAL -2 DAY) as tuesday
,DATE_SUB(NOW(), INTERVAL 2 DAY) as tuesday_again,
DATE_SUB(NOW(), INTERVAL -2 DAY) as spring_break_start_again;

/*Also available
INTERVAL x MONTHI
NTERVAL x YEAR
INTERVAL x HOUR
INTERVAL x MINUTE
INTERVAL x SECOND*/

-- DATE FORMATTING
SELECT DATE_FORMAT(NOW(), '%W, %M %D, %Y') as verbose;

SELECT DATE_FORMAT(NOW(), '%b %d, %Y') as abbrev;
SELECT DATE_FORMAT(NOW(), '%m/%d/%y') as short;

-- see book for more
-- TIME FORMATTING
SELECT TIME_FORMAT(CURTIME(), '%H:%i') as military_time,
TIME_FORMAT(CURTIME(), '%H:%i:%S') as military_time_sec,
TIME_FORMAT(CURTIME(), '%h:%i %p') as `12hr_time`,
TIME_FORMAT(CURTIME(), '%h:%i:%S %p') as `12hr_time_sec`;

-- again see book for more options
