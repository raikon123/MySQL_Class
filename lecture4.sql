

-- Simple GROUP BY with HAVING clause
-- Which characters have the most lines,
-- limiting to characters with more than 1000 lines
SELECT raw_character_text  
,
COUNT(*) as line_count
FROM SIMPSONS.SCRIPT_LINES
GROUP BY raw_character_text
HAVING COUNT(*) > 1000;

-- GROUP BY WITH ROLLUP example
-- What is the number of lines per character for every episode
-- Maybe we'd want to save this in a new table?
SELECT episode_id, raw_character_text, 
COUNT(*) as line_count
FROM SIMPSONS.SCRIPT_LINES
GROUP BY episode_id, raw_character_text WITH ROLLUP;

-- Example with where and having
-- What is the average word count for the top 5 characters
-- who have spoken more than 100 lines.
-- Filter out the blank characters.
SELECT raw_character_text, AVG(word_count) as average_words_per_line
FROM SIMPSONS.SCRIPT_LINES
WHERE raw_character_text <> ''
GROUP BY raw_character_text
HAVING COUNT(*) > 100
ORDER BY average_words_per_line DESC
LIMIT 5;

-- Let's look at distinct UFO shapes by State and compare to number of sightings
SELECT state, COUNT(DISTINCT shape) as shape_count, COUNT(*) as sightings_count
FROM UFO.SIGHTINGS
GROUP BY state
ORDER BY 3 DESC;

-- Let's look at minimum duration by shape and compare to the average.
-- Make sure there are at least 10 sightings per shape

SELECT shape, MIN(duration_seconds) min_duration, AVG(duration_seconds) avg_duration
FROM UFO.SIGHTINGS
GROUP BY shape
HAVING COUNT(*) >= 10
ORDER by min_duration;
