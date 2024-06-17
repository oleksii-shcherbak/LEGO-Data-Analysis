-- Use the lego_db database
USE lego_db;

-- Count the number of different minifigures
SELECT 
	COUNT(DISTINCT fig_num) AS total_minifigures
FROM 
	minifigs;

-- Calculate set counts with and without minifigs 
SELECT
    set_type,
    set_count,
    ROUND(CAST(set_count AS FLOAT) / total_sets * 100.0, 1) AS percentage
FROM (
    SELECT
        CASE WHEN m.fig_num IS NULL THEN 'Without Minifigs' ELSE 'With Minifigs' END AS set_type,
        COUNT(DISTINCT s.set_num) AS set_count
    FROM 
        sets AS s
    LEFT JOIN 
        inventories AS i 
        ON s.set_num = i.set_num
    LEFT JOIN 
        inventory_minifigs AS im 
        ON i.id = im.inventory_id
    LEFT JOIN 
        minifigs AS m 
        ON im.fig_num = m.fig_num
    GROUP BY 
        CASE WHEN m.fig_num IS NULL THEN 'Without Minifigs' ELSE 'With Minifigs' END
) AS sets_summary
CROSS JOIN (
    SELECT COUNT(*) AS total_sets FROM sets
) AS total_sets_summary
ORDER BY 
    percentage DESC;    

-- Calculate the estimated number of unique minifig combinations possible
SELECT CAST((
  (SELECT CAST(COUNT(DISTINCT p.part_num) AS BIGINT)
   FROM	
		parts AS p
   INNER JOIN 
		part_categories AS pc 
		ON p.part_cat_id = pc.id
   WHERE 
		pc.name = 'Minifig Heads') *
  (SELECT CAST(COUNT(DISTINCT p.part_num) AS BIGINT)
   FROM 
		parts AS p
   INNER JOIN 
		part_categories AS pc 
		ON p.part_cat_id = pc.id
   WHERE 
		pc.name = 'Minifig Upper Body') *
  (SELECT CAST(COUNT(DISTINCT p.part_num) AS BIGINT)
   FROM 
		parts AS p
   INNER JOIN 
		part_categories AS pc 
		ON p.part_cat_id = pc.id
   WHERE 
		pc.name = 'Minifig Lower Body')
) AS BIGINT) AS possible_minifig_configs;   
