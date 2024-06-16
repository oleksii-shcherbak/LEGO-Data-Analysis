-- Create the database
CREATE DATABASE lego_db;

-- Use the created database
USE lego_db;

-- Create the elements table
CREATE TABLE elements (
    id INTEGER PRIMARY KEY, -- Primary key for elements
    part_num VARCHAR(40),
    color_id INTEGER 
);

-- Create the inventories table
CREATE TABLE inventories (
    id INTEGER PRIMARY KEY, -- Primary key for inventories
    version INTEGER,
    set_num VARCHAR(40)
);

-- Create the inventory_minifigures table
CREATE TABLE inventory_minifigures (
    inventory_id INTEGER,
    fig_num VARCHAR(40),
    quantity INTEGER
);

-- Create the inventory_parts table
CREATE TABLE inventory_parts (
    inventory_id INTEGER,
    part_num VARCHAR(40),
    color_id INTEGER,
    quantity INTEGER,
    is_spare BIT
);

-- Create the inventory_sets table
CREATE TABLE inventory_sets (
    inventory_id INTEGER,
    set_num VARCHAR(40),
    quantity INTEGER
);

-- Create the minifigures table
CREATE TABLE minifigures (
    fig_num VARCHAR(40) PRIMARY KEY, -- Primary key for minifigures
    name VARCHAR(256),
    parts_count INTEGER
);

-- Create the part_categories table
CREATE TABLE part_categories (
    id INTEGER PRIMARY KEY,
    name VARCHAR(256)
);

-- Create the part_relationships table
CREATE TABLE part_relationships (
    rel_type VARCHAR(1),
    child_part_num VARCHAR(40),
    parent_part_num VARCHAR(40)
);

-- Create the parts table
CREATE TABLE parts (
    part_num VARCHAR(40) PRIMARY KEY, -- Primary key for parts
    name VARCHAR(256),
    part_cat_id INTEGER,
    part_material VARCHAR(40)
);

-- Create the sets table
CREATE TABLE sets (
    set_num VARCHAR(40) PRIMARY KEY, -- Primary key for sets
    name VARCHAR(256),
    year INTEGER,
    theme_id INTEGER,
    parts_count INTEGER
);

-- Create the themes table
CREATE TABLE themes (
    id INTEGER PRIMARY KEY, -- Primary key for themes
    name VARCHAR(256),
    parent_id INTEGER
);

-- Create the colors table
CREATE TABLE colors (
    id INTEGER PRIMARY KEY, -- Primary key for colors
    name VARCHAR(256),
    rgb VARCHAR(6),
    is_trans BIT
);
