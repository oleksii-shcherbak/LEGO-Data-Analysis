-- Use the lego_db database
USE lego_db;

-- Add foreign key constraint to elements referencing colors
ALTER TABLE elements
ADD CONSTRAINT FK_elements_colors
FOREIGN KEY (color_id)
REFERENCES colors(id);

-- Add foreign key constraint to elements referencing parts
ALTER TABLE elements
ADD CONSTRAINT FK_elements_parts
FOREIGN KEY (part_num)
REFERENCES parts(part_num);

-- Add foreign key constraint to inventory_minifigures referencing inventories
ALTER TABLE inventory_minifigures
ADD CONSTRAINT FK_inventory_minifigures_inventories
FOREIGN KEY (inventory_id)
REFERENCES inventories(id);

-- Add foreign key constraint to inventory_minifigures referencing minifigures
ALTER TABLE inventory_minifigures
ADD CONSTRAINT FK_inventory_minifigures_minifigures
FOREIGN KEY (fig_num)
REFERENCES minifigures(fig_num);

-- Add foreign key constraint to inventory_parts referencing inventories
ALTER TABLE inventory_parts
ADD CONSTRAINT FK_inventory_parts_inventories
FOREIGN KEY (inventory_id)
REFERENCES inventories(id);

-- Add foreign key constraint to inventory_parts referencing parts
ALTER TABLE inventory_parts
ADD CONSTRAINT FK_inventory_parts_parts
FOREIGN KEY (part_num)
REFERENCES parts(part_num);

-- Add foreign key constraint to inventory_parts referencing colors
ALTER TABLE inventory_parts
ADD CONSTRAINT FK_inventory_parts_colors
FOREIGN KEY (color_id)
REFERENCES colors(id);

-- Add foreign key constraint to inventory_sets referencing inventories
ALTER TABLE inventory_sets
ADD CONSTRAINT FK_inventory_sets_inventories
FOREIGN KEY (inventory_id)
REFERENCES inventories(id);

-- Add foreign key constraint to inventory_sets referencing sets
ALTER TABLE inventory_sets
ADD CONSTRAINT FK_inventory_sets_sets
FOREIGN KEY (set_num)
REFERENCES sets(set_num);

-- Add foreign key constraint to part_relationships referencing parts for child_part_num
ALTER TABLE part_relationships
ADD CONSTRAINT FK_part_relationships_child_parts
FOREIGN KEY (child_part_num)
REFERENCES parts(part_num);

-- Add foreign key constraint to part_relationships referencing parts for parent_part_num
ALTER TABLE part_relationships
ADD CONSTRAINT FK_part_relationships_parent_parts
FOREIGN KEY (parent_part_num)
REFERENCES parts(part_num);

-- Add foreign key constraint to parts referencing part_categories
ALTER TABLE parts
ADD CONSTRAINT FK_parts_part_categories
FOREIGN KEY (part_cat_id)
REFERENCES part_categories(id);

-- Add foreign key constraint to sets referencing themes
ALTER TABLE sets
ADD CONSTRAINT FK_sets_themes
FOREIGN KEY (theme_id)
REFERENCES themes(id);

-- Add foreign key constraint to themes referencing themes for parent_id
ALTER TABLE themes
ADD CONSTRAINT FK_themes_parent_themes
FOREIGN KEY (parent_id)
REFERENCES themes(id);
