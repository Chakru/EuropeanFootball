import sqlite3
import pandas as pd
from sqlalchemy import create_engine
import pyodbc

# ------------------------------------------------------
# 1. Update these values before running
# ------------------------------------------------------

SQLITE_DB_PATH = r"PATH_TO_SQLITE_FILE/database.sqlite"
SERVER_NAME = r"YOUR_SERVER_NAME\SQLEXPRESS"
DATABASE_NAME = "YOUR_DATABASE_NAME"

# ------------------------------------------------------
# 2. Create SQL Server connection using SQLAlchemy
# ------------------------------------------------------

connection_string = f"mssql+pyodbc://{SERVER_NAME}/{DATABASE_NAME}?driver=ODBC+Driver+17+for+SQL+Server"
engine = create_engine(connection_string)

# ------------------------------------------------------
# 3. Connect to SQLite
# ------------------------------------------------------

sqlite_conn = sqlite3.connect(SQLITE_DB_PATH)

# Fetch all tables
tables_query = "SELECT name FROM sqlite_master WHERE type='table';"
tables = pd.read_sql_query(tables_query, sqlite_conn)

print("Found tables:", tables['name'].tolist())

# ------------------------------------------------------
# 4. Loop through each table and migrate
# ------------------------------------------------------

for table_name in tables['name']:
    print(f"Migrating table: {table_name}")

    # Read table from SQLite
    df = pd.read_sql_query(f"SELECT * FROM {table_name}", sqlite_conn)

    # Push to SQL Server
    df.to_sql(table_name, engine, if_exists='replace', index=False)

    print(f"Table '{table_name}' migrated successfully.")

sqlite_conn.close()
print("Migration completed!")
