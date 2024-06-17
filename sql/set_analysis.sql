-- Use the lego_db database
USE lego_db;

-- Find the total number of LEGO sets
SELECT COUNT(*) AS total_sets
FROM 
	sets;

-- Find the total amount of unique LEGO pieces
SELECT COUNT(DISTINCT part_num) AS total_unique_pieces
FROM 
	inventory_parts;

-- Find the set with the largest quantity of pieces
SELECT TOP 1
    name,
    parts_count 
FROM
    sets 
ORDER BY
    parts_count DESC;

-- Find the top 10 biggest LEGO sets
SELECT TOP 10
    name,
    parts_count 
FROM
    sets 
ORDER BY
    parts_count DESC;

-- Count number of sets produced every year
SELECT TOP(50)
	year,
	COUNT(set_num) AS set_count
FROM sets
GROUP BY year
ORDER BY year DESC;

-- Count distribution of sets by theme
SELECT 
	t.name AS theme,
	COUNT(s.set_num) AS total_sets
FROM themes AS t
INNER JOIN 
	sets AS s
	ON s.theme_id = t.id
GROUP BY t.name
ORDER BY COUNT(s.set_num) DESC;

-- Count the number of sets released each year
SELECT TOP(50)
	year, 
	COUNT(set_num) AS set_count
FROM 
	sets
GROUP BY 
	year
ORDER BY 
	year DESC;

-- Compare the quantity of sets for each 5-year period
SELECT TOP(10)
    CONCAT((s.year / 5) * 5, ' - ', ((s.year / 5) * 5) + 4) AS year_range,
    COUNT(*) AS num_sets
FROM 
	sets AS s
GROUP BY 
	(s.year / 5) * 5
ORDER BY 
	MIN(s.year) DESC;

-- Count the number of LEGO sets by piece count groups
SELECT
	CASE
		WHEN parts_count >= 1 AND parts_count <= 249 THEN '1-249'
		WHEN parts_count >= 250 AND parts_count <= 499 THEN '250-499'
		WHEN parts_count >= 500 AND parts_count <= 999 THEN '500-999'
		WHEN parts_count >= 1000 AND parts_count <= 1999 THEN '1000-1999'
		ELSE '>=2000'
	END AS piece_count_group,
    COUNT(*) AS set_count
FROM
    sets
GROUP BY
    CASE
        WHEN parts_count >= 1 AND parts_count <= 249 THEN '1-249'
        WHEN parts_count >= 250 AND parts_count <= 499 THEN '250-499'
        WHEN parts_count >= 500 AND parts_count <= 999 THEN '500-999'
        WHEN parts_count >= 1000 AND parts_count <= 1999 THEN '1000-1999'
        ELSE '>=2000'
    END
ORDER BY
    MIN(parts_count);
