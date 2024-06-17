-- Use the lego_db database
USE lego_db;

-- Count the average quantity of pieces in sets grouped by theme
SELECT TOP(10)
    t.name AS theme,
    AVG(s.parts_count) AS avg_pieces
FROM 
    themes AS t
INNER JOIN 
    sets AS s
    ON s.theme_id = t.id
GROUP BY 
    t.name
ORDER BY 
    avg_pieces DESC;

-- Quantity of all parts grouped by category
SELECT 
    pc.name AS category_name, 
    SUM(ip.quantity) AS total_quantity 
FROM 
    parts AS p
INNER JOIN
    inventory_parts AS ip 
	ON p.part_num = ip.part_num 
INNER JOIN
    part_categories AS pc 
	ON p.part_cat_id = pc.id 
WHERE
    ip.is_spare = 0
GROUP BY 
    pc.name 
ORDER BY 
    total_quantity DESC;


-- Calculate the total quantity of parts 
SELECT 
	SUM(ip.quantity) AS total_pieces
FROM 
	parts AS p
INNER JOIN 
	inventory_parts AS ip 
	ON p.part_num = ip.part_num;


-- Find parts with the highest quantity in a specific color 
SELECT TOP(50) 
	p.name AS part_name,
	SUM(ip.quantity) AS total_quantity
FROM 
	parts AS p
INNER JOIN 
	inventory_parts AS ip 
	ON p.part_num = ip.part_num
INNER JOIN 
	colors AS c 
	ON ip.color_id = c.id
WHERE 
	c.name = 'color' -- Specify the desired color here
GROUP BY 
	p.name, c.name
ORDER BY 
	total_quantity DESC;

-- Find the top 50 most used spare parts
SELECT TOP 50
    ip.part_num,
    p.name AS part_name,
    SUM(ip.quantity) AS total_quantity
FROM 
    inventory_parts AS ip
INNER JOIN
    parts AS p 
	ON ip.part_num = p.part_num
WHERE 
    ip.is_spare = 1 
GROUP BY 
    ip.part_num, p.name
ORDER BY 
    total_quantity DESC; 

-- Calculate the percentage of part categories containing 'Minifig' 
SELECT 
    FORMAT(
        ROUND(
            COUNT(CASE WHEN pc.name LIKE '%Minifig%' THEN 1 END) * 100.0 / COUNT(*), 
        2), 
    'N2') AS '%_of_minifigs'
FROM 
    part_categories AS pc;

-- Calculate the percentage of each part material
SELECT 
    part_material,
    COUNT(*) AS material_count,
    ROUND(
        CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM parts) AS DECIMAL(5, 2)), 
    2) AS percentage
FROM 
    parts 
GROUP BY 
    part_material;  

-- Find the earliest year with spare parts
SELECT 
    MIN(s.year) AS first_year_with_spare_part
FROM 
    sets AS s
INNER JOIN 
    inventories AS i 
	ON s.set_num = i.set_num
INNER JOIN 
    inventory_parts AS ip 
	ON i.id = ip.inventory_id
WHERE 
    ip.is_spare = 1; 

-- Distribution of unique parts grouped by theme, with percentage
WITH ThemeParts AS (
  SELECT 
	t.name AS theme_name, 
	COUNT(DISTINCT p.part_num) AS unique_part_count
  FROM 
	themes AS t
  INNER JOIN 
	sets AS s 
	ON t.id = s.theme_id
  INNER JOIN 
	inventories AS i 
	ON s.set_num = i.set_num
  INNER JOIN 
	inventory_parts AS ip 
	ON i.id = ip.inventory_id
  INNER JOIN 
	parts AS p 
	ON ip.part_num = p.part_num
  GROUP BY 
	t.name
)
SELECT 
  theme_name,
  unique_part_count,
  ROUND(CAST(unique_part_count AS FLOAT) / (
    SELECT SUM(unique_part_count) FROM ThemeParts
  ) * 100.0, 2) AS '%_of_all_parts'
FROM 
	ThemeParts
ORDER BY 
	unique_part_count DESC;

-- Find the most used part category for each year
SELECT TOP(50)
    s.year,
    pc.name AS part_category,
    COUNT(*) AS total_sets
FROM 
	sets AS s
INNER JOIN
    inventories AS i 
	ON s.set_num = i.set_num
INNER JOIN
    inventory_parts AS ip 
	ON i.id = ip.inventory_id
INNER JOIN
    parts AS p 
	ON ip.part_num = p.part_num
INNER JOIN 
    part_categories AS pc 
	ON p.part_cat_id = pc.id
GROUP BY 
    s.year,
    pc.name
HAVING 
    COUNT(*) = (
        SELECT 
            TOP 1 COUNT(*)
        FROM 
            sets AS s2
        INNER JOIN 
            inventories AS i2 
			ON s2.set_num = i2.set_num
        INNER JOIN 
            inventory_parts AS ip2 
			ON i2.id = ip2.inventory_id
        INNER JOIN 
            parts AS p2 
			ON ip2.part_num = p2.part_num
        INNER JOIN 
            part_categories AS pc2 
			ON p2.part_cat_id = pc2.id
        WHERE 
            s2.year = s.year
        GROUP BY 
            pc2.name
        ORDER BY 
            COUNT(*) DESC
    )
ORDER BY 
    s.year DESC;            