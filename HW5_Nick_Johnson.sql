

-- HOMEWORK 5: JOIN AND GROUP BY-- Please write all queries BELOW the numbers questions.-- Please answer any additional questions as comments after your query.
/* 1.  Using the Pitchfork.Reviews table, write a query that ranks the author types by greatest average score. This should return 16 rows and two columns.Which author_type has the greatest average?*/
select author_type, avg(score) as Avg_Score
from pitchfork.reviews
    group by author_type
    order by Avg_Score desc;
    
    
/*2.  Add the count of reviews to the query above.You can see some of these author_types onlyhave a handful of reviews. Filter out author_typeswith fewer than 25 reviews. 
Also filter outthe NULL author_type. Sort by descendingreview count.This should return 11 rows and 3 columns.*/
select author_type, avg(score) as Avg_Score, count(reviewid) as count_review
from pitchfork.reviews
where author_type is not null
    group by author_type
    having count_review >= 25
    order by count_review desc;
    
/*3.  You should be able to see that most of the reviewsare written by the author_type 'contributor'. Let'sfocus on these. Wrtie query that returns all the authorsthat are contributors. 
Display the average score and totalnumber of reviews again. Sort by total number of reviews descending.This should return 220 rows and 3 columns.*/
select author, avg(score) as Avg_Score, count(reviewid) as Count_Review
from pitchfork.reviews
	where author_type = 'contributor'
	group by author
	order by Count_Review desc;


/*4.  Let's see what we can learn about these authors.The first thing to note is that there are a bunch of authors with only a handful of reviews. 
Averages aren't verygood measures for small sample sizes. Let's throw outanyone who doesn't have at least 50 reviews. 
Let's also add the min, max, and standard deviation STD() of thereview scores.Order by the standard deviation descending.Who are the most and least consistent reviewers?Your table should now have 56 rows and 6 columns*/
select author, author_type, avg(score) as Avg_Score, count(reviewid) as Count_Review, min(score) as Min_Score, max(score) as Max_Score, std(score) as St_Dev_Score
from pitchfork.reviews
	where author_type = 'contributor'
	group by author
    having Count_Review >= 50
	order by St_Dev_Score desc;
    
    -- Brent Dicrescenzo highest st. dev


/*5.  Let's pick on 'brent dicrescenzo' since he had thelargest standard deviation. Does he favor one genreover another? The pitchfork.reviews table can bejoined to the pitchfork.genres table on the reviewidcolumn.
Write a query that replaces the author in the queryfrom #4 with the genre. Sort by ave score descending.Limit this to genres with more than 5 reviews.You will need to join to the genres table, 
change theGROUP BY, HAVING and WHERE clauses.This should return 4 rows and have 6 colums.You should see that Brent like eletronic music slightlymore than rock and isn't really a fan of metal orexperimental music.*/
select pg.genre, avg(pr.score) as Avg_Score, count(pr.reviewid) as Count_Review, min(pr.score) as Min_Score, max(pr.score) as Max_Score, std(pr.score) as St_Dev_Score
from pitchfork.reviews as pr
inner join pitchfork.genres as pg
on pg.reviewid = pr.reviewid
	where author = 'brent dicrescenzo'
    group by genre
    having Count_Review > 5
	order by Avg_Score desc;

/*6.  What does this look like for the most "stable"(lowest standard deviation) reviewer from #4'andy o''connor'? Not you need the second apostropheby the o to get the where clause to work.
Repeat step 5 with the Andy replacing Brent. Ignorecolumns without a genre (i.e. change the whereclause to filter out null genres).Your query should return 2 rows and 6 columns.
How do Andy's preferences differ from Bents?*/
select pg.genre, avg(pr.score) as Avg_Score, count(pr.reviewid) as Count_Review, min(pr.score) as Min_Score, max(pr.score) as Max_Score, std(pr.score) as St_Dev_Score
from pitchfork.reviews as pr
inner join pitchfork.genres as pg
on pg.reviewid = pr.reviewid
	where author = 'andy o''connor'
    and genre is not null
    group by genre
    having Count_Review > 5
	order by Avg_Score desc;

/*7.  Let's spend some more time looking at the genres.Write a query that returns the min, max, avg, andstd score as well as the count of reviews by genre.ALTEROrder by the count of reviews desc. 
Nremove the NULL genre.Notice how this takes some time to run. We're working with a largetable this time. (30+ sec)This should return 9 rows and 6 columsn.Which genres are Pitchfork's favotires?*/
select pg.genre, avg(pr.score) as Avg_Score, count(pr.reviewid) as Count_Review, min(pr.score) as Min_Score, max(pr.score) as Max_Score, std(pr.score) as St_Dev_Score
from pitchfork.reviews as pr
inner join pitchfork.genres as pg
on pg.reviewid = pr.reviewid
    and genre is not null
    group by genre
	order by Count_Review desc;

/*8.  Let's repeat the analysis from #7 with the musiclabel instead of genre. This is located in the ALTERPitchfork.labels table and can also be joined on thereviewid.
Limit your query to labels with more than 100 reviews.This query takes a while to run and should return 25 rows. (30+ sec)Which label is the favorite (highest avg score)?Which label is the most consistent (lowest std)?*/
select pl.label, avg(pr.score) as Avg_Score, count(pr.reviewid) as Count_Review, min(pr.score) as Min_Score, max(pr.score) as Max_Score, std(pr.score) as St_Dev_Score
from pitchfork.reviews as pr
inner join pitchfork.labels as pl
on pl.reviewid = pr.reviewid
    and label is not null
    group by label
    having Count_Review > 100
	order by Count_Review desc;

-- 4ad
-- jagjaguwar

/*9.  Let's look at the label and genre together. Thiswill require two joins, one to the labels tableand one to the genres table. Group by both genreand label. 
Return the min, max, avg, std and count.Limit to count(*) > 25. This should return 134 rows.
Note each of these queries may take 1-2 min to run.What is the best combination of genre and recordlabel (highest avg_score)? What is the most consitent?*/
select pg.genre, pl.label, avg(pr.score) as Avg_Score, count(pr.reviewid) as Count_Review, min(pr.score) as Min_Score, max(pr.score) as Max_Score, std(pr.score) as St_Dev_Score
from pitchfork.reviews as pr
inner join pitchfork.labels as pl
on pl.reviewid = pr.reviewid
left outer join pitchfork.genres as pg
on pg.reviewid = pl.reviewid
	where genre is not null
    and label is not null
    group by genre, label
    having Count_Review > 25
	order by Count_Review desc;

 -- rock and rhino
 -- rock and slumberland



/*10.  Repeat the analysis above for the artists with more than 5 reviewed albums.You will only need the reviews table.You should get 461 rows.Who is the worst reviewed artist?Who is the least consistent?*/
select pr.artist, pg.genre, pl.label, avg(pr.score) as Avg_Score, count(pr.reviewid) as Count_Review, min(pr.score) as Min_Score, max(pr.score) as Max_Score, std(pr.score) as St_Dev_Score
from pitchfork.reviews as pr
inner join pitchfork.labels as pl
on pl.reviewid = pr.reviewid
left outer join pitchfork.genres as pg
on pg.reviewid = pl.reviewid
    where genre is not null
    and label is not null
    group by artist
    having Count_Review > 5
	order by Count_Review desc;

-- chiddy bang
-- nina simone