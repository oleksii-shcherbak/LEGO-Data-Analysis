import pandas as pd
from sqlalchemy import create_engine
import os

# Directory path to the processed data
processed_data_dir = r'C:\Users\oleks\Projects\LEGO-Data-Analysis\data\processed'

# List of processed files and their corresponding table names
files_tables = [
    ("colors.csv", "colors"),
    ("themes.csv", "themes"),
    ("part_categories.csv", "part_categories"),
    ("parts.csv", "parts"),
    ("elements.csv", "elements"),
    ("sets.csv", "sets"),
    ("inventories.csv", "inventories"),
    ("minifigures.csv", "minifigures"),
    ("inventory_minifigures.csv", "inventory_minifigures"),
    ("inventory_parts.csv", "inventory_parts"),
    ("inventory_sets.csv", "inventory_sets"),
    ("part_relationships.csv", "part_relationships")
]

# Database connection parameters
server = 'localhost'
database = 'lego_db'
username = 'sa'
password = 'Shcherbak16021998'
driver = 'ODBC Driver 17 for SQL Server'

# Create database connection string
connection_string = f'mssql+pyodbc://{username}:{password}@{server}/{database}?driver={driver}'
engine = create_engine(connection_string)

def load_data_to_sql(file_name, table_name):
    file_path = os.path.join(processed_data_dir, file_name)
    df = pd.read_csv(file_path)
    df.to_sql(table_name, engine, if_exists='append', index=False)
    print(f"Data loaded into {table_name} table successfully.")

# Load all files into the corresponding tables
for file_name, table_name in files_tables:
    load_data_to_sql(file_name, table_name)

print("All data loaded successfully.")