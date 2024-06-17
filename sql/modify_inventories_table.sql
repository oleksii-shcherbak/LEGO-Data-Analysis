-- Use the lego_db database
USE lego_db;

-- Add a new column 'fig_num' to the 'inventories' table
ALTER TABLE 
	inventories
ADD 
	fig_num VARCHAR(40);

-- Update the 'fig_num' column with records containing 'fig-' in the beginning
UPDATE 
	inventories
SET 
	fig_num = set_num
WHERE 
	LEFT(set_num, 4) = 'fig-';

-- Delete data containing 'fig-' in the beginning from the 'set_num' column
UPDATE 
	inventories
SET 
	set_num = NULL
WHERE 
	LEFT(set_num, 4) = 'fig-';

-- Add foreign key constraint to inventories referencing minifigures
ALTER TABLE 
    inventories
ADD CONSTRAINT 
    FK_inventories_minifigures
FOREIGN KEY 
    (fig_num)
REFERENCES 
    minifigures(fig_num);