-- Use the lego_db database
USE lego_db;

-- Count the number of distinct colors
SELECT 
	COUNT(DISTINCT name) AS total_colors
FROM 
	colors;

-- Update the rgb column to uppercase
UPDATE 
	colors
SET 
	rgb = UPPER(rgb);

-- Top 10 most popular colors in parts
SELECT TOP 10
    c.name,
	c.rgb,
    COUNT(*) AS part_count
FROM
    parts AS p
INNER JOIN
    inventory_parts AS ip 
    ON p.part_num = ip.part_num
INNER JOIN
    colors AS c 
    ON ip.color_id = c.id
GROUP BY
    c.name, c.rgb
ORDER BY
    COUNT(*) DESC;

-- Count the number of transparent and opaque colors and calculate their percentages
SELECT
    SUM(CASE WHEN is_trans = 1 THEN 1 ELSE 0 END) AS transparent_count,
    SUM(CASE WHEN is_trans = 0 THEN 1 ELSE 0 END) AS opaque_count,
    COUNT(*) AS total_count,
    FORMAT((SUM(CASE WHEN is_trans = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 'N2') AS 'transparent_%',
    FORMAT((SUM(CASE WHEN is_trans = 0 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 'N2') AS 'opaque_%'
FROM
    colors;

-- Count the number of colors used in sets for each year
SELECT TOP(50)
    s.year,
    COUNT(DISTINCT c.id) AS num_colors
FROM 
    sets AS s
INNER JOIN 
    inventories AS i 
	ON s.set_num = i.set_num
INNER JOIN 
    inventory_parts AS ip 
	ON i.id = ip.inventory_id
INNER JOIN 
    colors AS c 
	ON ip.color_id = c.id
GROUP BY 
    s.year
ORDER BY 
    s.year DESC;

-- Find the most used color for every year
SELECT TOP(50)
    s.year,
    c.name,
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
    colors AS c 
	ON ip.color_id = c.id
WHERE 
    ip.is_spare = 0 
GROUP BY 
    s.year,
    c.name
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
            colors AS c2 
			ON ip2.color_id = c2.id
        WHERE 
            ip2.is_spare = 0 
            AND s2.year = s.year
        GROUP BY 
            c2.name
        ORDER BY 
            COUNT(*) DESC
    )
ORDER BY 
    s.year DESC;
