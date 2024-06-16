import pandas as pd
import os

# Directory path to the data
data_dir = r"C:\Users\oleks\Projects\LEGO-Data-Analysis\data\raw"

# List of files
files = [
    "elements.csv",
    "inventories.csv",
    "inventory_minifigs.csv",
    "inventory_parts.csv",
    "inventory_sets.csv",
    "minifigs.csv",
    "part_categories.csv",
    "part_relationships.csv",
    "parts.csv",
    "sets.csv",
    "themes.csv",
    "colors.csv"
]

# Load and check data
def load_and_check_data(file_name):
    file_path = os.path.join(data_dir, file_name)
    df = pd.read_csv(file_path)
    print(f"--- {file_name} ---")
    print("First 5 rows:")
    print(df.head())
    print("\nInfo:")
    print(df.info())
    print("\nDescription:")
    print(df.describe(include='all'))
    print("\nMissing values:")
    print(df.isnull().sum())
    print("="*75)

# Check all files
for file in files:
    load_and_check_data(file)
