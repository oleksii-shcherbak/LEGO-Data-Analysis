import pandas as pd
import os

# Directory path to the data
data_dir = r'C:\Users\oleks\Projects\LEGO-Data-Analysis\data\raw'
processed_data_dir = r'C:\Users\oleks\Projects\LEGO-Data-Analysis\data\processed'

# List of files to process and their specific operations
files_operations = {
    "elements.csv": {"drop_columns": ["design_id"], "rename_columns": {"element_id": "id"}},
    "inventory_parts.csv": {"drop_columns": ["img_url"], "boolean_columns": {"is_spare": {'t': 1, 'f': 0}}},
    "colors.csv": {"boolean_columns": {"is_trans": {'t': 1, 'f': 0}}},
    "sets.csv": {"drop_columns": ["img_url"], "rename_columns": {"num_parts": "parts_count"}},
    "minifigs.csv": {"drop_columns": ["img_url"], "rename_columns": {"num_parts": "parts_count"}, "new_name": "minifigures.csv"},
    "inventory_minifigs.csv": {"new_name": "inventory_minifigures.csv"},
    "inventories.csv": {},
    "inventory_sets.csv": {},
    "part_categories.csv": {},
    "part_relationships.csv": {},
    "parts.csv": {},
    "themes.csv": {}
}

def load_and_process_data(file_name, operations):
    file_path = os.path.join(data_dir, file_name)
    df = pd.read_csv(file_path)
    
    # Drop specified columns
    if "drop_columns" in operations:
        df.drop(columns=operations["drop_columns"], inplace=True)
    
    # Convert specified columns to boolean
    if "boolean_columns" in operations:
        for col, mapping in operations["boolean_columns"].items():
            df[col] = df[col].map(mapping)
    
    # Rename specified columns
    if "rename_columns" in operations:
        df.rename(columns=operations["rename_columns"], inplace=True)
    
    # Save processed data
    processed_file_name = operations.get("new_name", file_name)
    processed_file_path = os.path.join(processed_data_dir, processed_file_name)
    df.to_csv(processed_file_path, index=False)
    
    return df

def check_data(df, file_name):
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

# Process and check all files
for file_name, operations in files_operations.items():
    processed_df = load_and_process_data(file_name, operations)
    check_data(processed_df, file_name)
    