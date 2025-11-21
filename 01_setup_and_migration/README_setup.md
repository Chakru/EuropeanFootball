# Setup and Migration Guide

This folder documents the initial setup and data migration process for the European Soccer Game Analysis project. The original dataset is provided as a SQLite file from Kaggle, and this guide explains how it was imported into Microsoft SQL Server for analysis.

---

## 1. Dataset Source

**Dataset:** European Soccer Database  
**Platform:** Kaggle  
**Format:** `database.sqlite`  
**Source URL:** https://www.kaggle.com/code/dimarudov/data-analysis-using-sql/data 

The dataset contains relational tables covering matches, teams, players, leagues, team and player attributes, and metadata.

This repository does not include the SQLite file due to size and licensing constraints.  
Users must download it from Kaggle before running the migration script.

---

## 2. Environment Setup

Before running any scripts, ensure the following tools are installed:

### Required Tools
- **Microsoft SQL Server Express**
- **SQL Server Management Studio (SSMS)**
- **Python 3.10+**
- Python packages:
  - `sqlite3` (built-in)
  - `pyodbc`

### Database Setup
Create a blank SQL Server database to receive the imported tables.

Example:

- **Database name:** EuropeanSoccer
- **Server:** <Your_SQL_Server_Instance>

---

## 3. Migration Workflow

The dataset was originally stored in SQLite format.  
To use it in SQL Server, a custom migration script was written.

### Migration Script
File: `sqlite_to_sqlserver_migration.py`

**Responsibilities:**
- Connect to the SQLite file
- Extract table schema and data
- Create equivalent tables in SQL Server
- Insert data in batches to avoid memory issues
- Handle data type conversions where needed

This script is the single source of truth for how the database was migrated.

### How to Run the Script
Update the following three values inside the script:

- SQLITE_DB_PATH = r"path_to_database.sqlite"
- SERVER_NAME = r"your_sql_server_instance"
- DATABASE_NAME = "EuropeanSoccer"

Then run: `python sqlite_to_sqlserver_migration.py`


---

## 4. Validation Steps

After migration, validation was performed to ensure data integrity.

### 4.1 Row Count Verification
File: `01_row_count_validation.sql`  
This query checks table-level row counts in SQL Server and compares them to the expected counts from the Kaggle dataset.

Use this script to ensure:
- No rows are missing
- No duplicates were introduced
- No tables failed during migration

### 4.2 Schema Verification
File: `02_schema_overview.sql`  
Includes:
- Table and column listings
- Primary key inspection
- Foreign key relationships
- Preview queries for Match, Team, and League tables

This confirms the schema structure matches the original SQLite version.

---

## 5. Reproduction Steps

Anyone recreating the setup should follow this sequence:

1. Install SQL Server and SSMS  
2. Download `database.sqlite` from Kaggle  
3. Create the `EuropeanSoccer` database in SQL Server  
4. Update and run `sqlite_to_sqlserver_migration.py`  
5. Run:
   - `01_row_count_validation.sql`
   - `02_schema_overview.sql`
6. Confirm:
   - Row counts match Kaggle  
   - Keys and relationships look correct  
   - Data loads cleanly

Once these steps pass, the environment is ready for exploration.

---

## 6. Notes

- Large datasets should not be committed to GitHub.  
- All SQL scripts in this folder are focused on setup only.  
- Analysis and exploration queries belong in the next project phase.  
- If the Kaggle dataset updates in the future, the migration script may need adjustments.

---

This completes the setup documentation. The next stage is data exploration in the `02_exploration` folder.
