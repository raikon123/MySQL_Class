-- Examples for subquery lecture #5

/*******
-- Categorical CASE statement example
*******/

SELECT CASE WHEN Score<1 THEN '[0-1)'
			WHEN Score<2 THEN '[1-2)'
            WHEN Score<3 THEN '[2-3)'
            WHEN Score<4 THEN '[3-4)'
            WHEN Score<5 THEN '[4-5)'
            WHEN Score<6 THEN '[5-6)'
            WHEN Score<7 THEN '[6-7)'
            WHEN Score<8 THEN '[7-8)'
            WHEN Score<9 THEN '[8-9)'
			ELSE '[9-10]' END as score_category
            ,count(*) as review_count
FROM Pitchfork.Reviews
GROUP BY score_category;

/*******
-- CASE statement for exception handling
*******/


SELECT CASE WHEN shape='' THEN 'unknown' ELSE shape END as new_shape
	  ,CASE WHEN duration_seconds > 36000 OR 
				 duration_seconds <= 0 
      THEN NULL ELSE duration_seconds/60.0 END as duration_minutes
FROM UFO.SIGHTINGS;

-- We can then get the average duration in minutes for each shape a bit more reliably.
-- Let's limit it to shapes with more than 10 sightings
SELECT CASE WHEN shape='' THEN 'unknown' ELSE shape END as new_shape
	  ,AVG(CASE WHEN duration_seconds > 36000 OR 
				 duration_seconds <= 0 
      THEN NULL ELSE duration_seconds/60.0 END) as avg_duration_minutes
FROM UFO.SIGHTINGS
GROUP BY new_shape
HAVING COUNT(*) > 10
ORDER BY avg_duration_minutes DESC
;

/*******
-- CASE statement that incorporates "business knowledge"
*******/

SELECT artist
      ,title
      ,score
      ,CASE WHEN year BETWEEN 1990 AND 1994
							AND genre = 'rock'
                            AND score > 7
                            THEN 'Probably grunge'
						   ELSE 'Probably not grunge' END as grunge_flag
FROM Pitchfork.reviews r
JOIN pitchfork.genres g
ON r.reviewid=g.reviewid
JOIN Pitchfork.years y
ON r.reviewid=y.reviewid
WHERE CASE WHEN year BETWEEN 1990 AND 1994
							AND genre = 'rock'
                            AND score > 7
                            THEN 'Probably grunge'
						   ELSE 'Probably not grunge' END ='Probably grunge';

-- CASE Statement for aggregation

SELECT COUNT(DISTINCT CASE WHEN g.genre='rock' THEN r.artist ELSE NULL END) as rock_artists
, AVG(CASE WHEN g.genre='rock' THEN r.score ELSE NULL END) as avg_rock_score
,COUNT(DISTINCT CASE WHEN g.genre='jazz' THEN r.artist ELSE NULL END) as jazz_artists
, AVG(CASE WHEN g.genre='jazz' THEN r.score ELSE NULL END) as avg_jazz_score
FROM pitchfork.reviews r
JOIN pitchfork.genres g
ON r.reviewid=g.reviewid;


-- Note this is not necessarily "good" business knowledge.
/*******
EXAMPLES
********/

-- Do Ex 1

SELECT CASE WHEN score >= 0 AND score < 4 THEN 'bad'
			WHEN score >= 4 AND score < 7 THEN 'ok' 
            ELSE 'good' END as score_category
, count(*) as category_count
FROM Pitchfork.reviews
GROUP BY score_category;


-- Do Ex 2
SELECT case when author_type IS NULL OR author_type like '%contributor%' then 'contributor'
when author_type like '%editor%' then 'editor'
when author_type like '%writer%' then 'writer'
when author_type like '%coordinator%' then 'coordinator'
when author_type like '%director%' then 'director' 
ELSE 'unknown' END as author_type_cat
,avg(score) as avg_score
from pitchfork.reviews
group by author_type_cat;


SELECT distinct author_type
from Pitchfork.reviews;

/********
-- Uncorrelated subquery in SELECT statement
********/

SELECT name
      ,num_parts
      ,(SELECT SUM(num_parts) FROM legos.sets) as total_parts
FROM legos.sets;

-- Let's find the % of total for each lego set 
SELECT name
      ,num_parts
      ,(SELECT SUM(num_parts) FROM legos.sets) as total_parts
      ,num_parts/(SELECT SUM(num_parts) FROM legos.sets)  as pct_of_total
FROM legos.sets
ORDER BY pct_of_total desc;

/********
-- Correlated subquery in SELECT statement
********/
SELECT name as set_name
      ,(SELECT name FROM legos.themes as t WHERE t.id=s.theme_id) as theme_name
FROM legos.sets  as s;

-- This is exactly the same as 
SELECT s.name as set_name
      ,t.name theme_name
FROM legos.sets  as s
JOIN legos.themes as t
on t.id=s.theme_id;


-- Do EX 1

SELECT name
      ,num_parts
      ,(SELECT AVG(num_parts) FROM legos.sets) as average_parts
FROM legos.sets;

-- Do EX 2
 -- Note that the limit 1 is needed because without it, the subquery
 -- returns more than 1 row. This is because there are numerous albums
 -- with more than one genre records in the pitchfork reviews table.
SELECT r.artist, r.title, (select genre from pitchfork.genres g 
							where g.reviewid=r.reviewid limit 1) as genre
FROM Pitchfork.reviews r;

select r.artist, r.title, count(distinct genre) genres, min(genre), max(genre)
FROM Pitchfork.reviews r
JOIN pitchfork.genres g
ON r.reviewid=g.reviewid
GROUP BY r.artist, r.title
HAVING count(distinct genre)>1;




/************
-- Subqueries in the FROM clause
************/

-- A simple example

SELECT S.name as set_name, T.name as theme_name
FROM legos.sets as S
JOIN (
		SELECT id, name 
		FROM legos.themes
	 ) AS T
ON S.theme_id=T.id;

-- Again, this is equivalent to a simple join 
SELECT S.name as set_name, T.name as theme_name
FROM legos.sets as S
JOIN legos.themes T
ON S.theme_id=T.id;

-- A more complex example
SELECT T.id as theme_id, T.name as theme_name, S.name as set_name, T.num_sets_in_theme
FROM legos.sets as S
JOIN (
		SELECT T.id, T.name, count(distinct S.Name) as num_sets_in_theme 
        FROM legos.themes as T
        JOIN legos.sets as S
        ON T.id=S.theme_id
        GROUP BY T.id, T.name
	 ) AS T
ON S.theme_id=T.id
ORDER By theme_name,theme_id, set_name;

-- This is what the subquery looks like
SELECT T.id, T.name, count(distinct S.Name) as num_sets_in_theme 
FROM legos.themes as T
JOIN legos.sets as S
ON T.id=S.theme_id
GROUP BY T.id, T.name;

-- Do EX 1
SELECT artist, title, genre
FROM pitchfork.reviews r
JOIN (
		SELECT reviewid, genre
        FROM pitchfork.genres
     ) g
ON r.reviewid=g.reviewid;

select artist, title, genre
from pitchfork.reviews r
join pitchfork.genres g
on r.reviewid=g.reviewid;

-- Do Ex 2
SELECT artist, title, g.genre, score, gsq.avg_score
FROM pitchfork.reviews r
JOIN pitchfork.genres g
ON g.reviewid=r.reviewid
JOIN (
		SELECT genre, avg(score) as avg_score
        FROM pitchfork.genres g
        JOIN pitchfork.reviews r
        ON g.reviewid=r.reviewid
        GROUP BY genre
     ) gsq
ON g.genre=gsq.genre
ORDER BY 1;



SELECT genre, avg(score) as avg_score
FROM pitchfork.genres g
JOIN pitchfork.reviews r
ON g.reviewid=r.reviewid
GROUP BY genre;
/************
-- Subqueries in the WHERE clause
************/

-- WHERE subquery with a single value

SELECT s.name as set_name, num_parts, t.name as theme_name
FROM legos.sets S
JOIN legos.themes T
ON S.theme_id=T.id
WHERE theme_id = (select id 
				  from legos.themes 
                  order by name desc 
                  limit 1);

select id, name
from legos.themes 
order by name desc 
limit 1;

-- WHERE subquery with a multiple values

-- All the casles
SELECT s.name as set_name, num_parts, t.name as theme_name
FROM legos.sets S
JOIN legos.themes T
ON S.theme_id=T.id
WHERE theme_id IN (
					select id 
					from legos.themes 
					WHERE name='castle'
                  );
                  
select id 
from legos.themes 
WHERE name='castle';
-- Everything that's not a castle
SELECT s.name as set_name, num_parts, t.name as theme_name
FROM legos.sets S
JOIN legos.themes T
ON S.theme_id=T.id
WHERE theme_id NOT IN (
						SELECT id  
						FROM legos.themes 
						WHERE name='castle'
                      );

-- A more complex example 
SELECT t.name as theme_name, s.name as set_name, num_parts
FROM legos.sets S
JOIN legos.themes T
ON S.theme_id=T.id
WHERE theme_id IN (
					SELECT T.id 
					FROM legos.themes T
					JOIN legos.sets S
					ON T.id=S.theme_id
					GROUP BY T.id
					HAVING AVG(num_parts)>2000
                  )
ORDER BY theme_name, set_name;


SELECT theme_id 
FROM legos.sets S
GROUP BY theme_id
HAVING AVG(num_parts)>2000;

-- The example above written as a join to a subquery
SELECT t.name as theme_name, s.name as set_name, num_parts
FROM legos.sets S
JOIN legos.themes T
ON S.theme_id=T.id
JOIN (
		SELECT T.id 
		FROM legos.themes T
		JOIN legos.sets S
		ON T.id=S.theme_id
		GROUP BY T.id
		HAVING AVG(num_parts)>2000
	  ) lrg
on T.id=lrg.id
ORDER BY theme_name, set_name;

-- Example 
SELECT t.name as theme_name, s.name as set_name, num_parts
FROM legos.sets S
JOIN legos.themes T
ON S.theme_id=T.id
WHERE theme_id IN (
					SELECT T.id 
					FROM legos.themes T
					JOIN legos.sets S
					ON T.id=S.theme_id
					GROUP BY T.id
					HAVING MIN(num_parts)>=500
                  )
ORDER BY theme_name, set_name;


-- WHERE subquery with inequality
SELECT t.name as theme_name, s.name as set_name, num_parts
FROM legos.sets S
JOIN legos.themes T
ON S.theme_id=T.id
WHERE num_parts >= (
					SELECT avg(num_parts)
					FROM legos.sets S
                   )
ORDER BY num_parts;

SELECT avg(num_parts)
FROM legos.sets S;

-- Correlated subquery in WHERE clause
SELECT t.name as theme_name, s.name as set_name
FROM legos.sets S
JOIN legos.themes T
ON S.theme_id=T.id
WHERE num_parts >= (
					SELECT avg(num_parts)
					FROM legos.sets 
                    WHERE theme_id=s.theme_id
                   )
ORDER BY theme_name, set_name;

-- The previous query but much faster
SELECT t.name as theme_name, s.name as set_name
FROM legos.sets S
JOIN legos.themes T
ON S.theme_id=T.id
JOIN  (
		SELECT theme_id, avg(num_parts) avg_parts
		FROM legos.sets 
        GROUP BY theme_id
) av
on av.theme_id=S.theme_id
WHERE num_parts >= avg_parts
ORDER BY theme_name, set_name;

-- subquery in the HAVING clause

SELECT T.name as theme_name
      ,count(distinct S.set_num) as distinct_sets
      ,avg(num_parts) as avg_pieces
FROM legos.sets S
JOIN legos.themes T
ON S.theme_id=T.id
GROUP BY T.name
HAVING avg_pieces <= (
						SELECT avg(num_parts)
						FROM legos.sets s
						JOIN legos.themes t
						on s.theme_id=t.id
						WHERE t.name like '%friends%'			  
					);

SELECT avg(num_parts)
FROM legos.sets s
JOIN legos.themes t
on s.theme_id=t.id
WHERE t.name like '%friends%';	
/************

EXISTS example

*************/

SELECT s.name as set_name
FROM legos.sets S
WHERE EXISTS (
				SELECT *
				FROM legos.themes
                WHERE id=theme_id
                AND name LIKE '%Star Wars%'
			  );

-- This is the same as writing

SELECT s.name as set_name
FROM legos.sets S
JOIN legos.themes T
ON S.theme_id=T.id
WHERE T.name like '%Star Wars%';





