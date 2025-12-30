# Phase 1: Exploration & Foundations (Completed)

This folder contains all SQL scripts for **Phase 1** of the European Soccer Game Analysis project.  
Phase 1 focuses on understanding the dataset, validating the migrated data, and building strong foundational SQL skills before moving into relational and analytical queries.

All scripts in this folder were executed against Microsoft SQL Server after migrating the dataset from SQLite.

---

## Phase Objectives

The goals of Phase 1 were to:

- Understand database structure and table relationships  
- Explore core tables using basic SELECT queries  
- Perform foundational aggregations and summaries  
- Validate data integrity after migration  
- Detect early anomalies or inconsistencies  
- Establish clean SQL scripting and documentation habits  

These objectives have now been fully achieved.

---

## Contents

### 1. `Basic_Select_Query.sql`  
**Phase 1.2: Basic SELECT Queries**

Covers introductory exploration tasks such as:
- Listing leagues and countries  
- Identifying available seasons  
- Filtering and ordering match data  
- Exploring team identifiers  
- Counting total matches  
- Detecting high-scoring matches  

This script builds familiarity with the core dimensions of the dataset and confirms that the base tables behave as expected.

---

### 2. `Basic_Aggregation.sql`  
**Phase 1.3: Basic Aggregation Work**

Includes foundational aggregation and analytical queries such as:
- Match counts per season  
- Match counts per country  
- Season-level total goals  
- Average goals per match  
- Highest scoring matches per season  
- Goal-scoring frequency distributions  
- Home vs away participation balance  
- Goal margin extremes  
- Season-level scoring rankings  

These queries introduce GROUP BY, CASE expressions, subqueries, and aggregation logic.

---

### 3. `Data Validation Queries`  
**Phase 1.4: Data Validation**

Phase 1.4 focuses on validating the integrity of the migrated dataset.  
Validation logic in this folder includes checks for:

- Missing or null values in key match fields  
- Invalid or missing team, league, or country IDs  
- Season and date consistency  
- Goal range sanity checks  
- Participation balance between home and away teams  

This step ensures the dataset is reliable before moving into multi-table joins and advanced analysis.

---

## How to Use This Folder

Run the scripts using SQL Server Management Studio (SSMS) with the database context set to:


```
USE EuropeanSoccer;
GO
```


Scripts can be run independently, but the recommended order is:
1. `Basic_Select_Query.sql`  
2. `Basic_Aggregation.sql`  
3. `Data_Validation_Query.sql`

Each script includes clear problem statements, purposes, and expected outputs to support learning and reproducibility.

---

## Phase Status

✅ **Phase 1 Completed**

- Dataset successfully migrated  
- Schema and relationships validated  
- Exploration and aggregation completed  
- Data quality verified  

The database is now fully understood and ready for relational analysis.

---

## Next Phase

**Phase 2 Relational Mastery (Joins, CTEs, Subqueries)**

The next phase will focus on:
- Multi-table joins across Match, Team, League, and Country  
- Reusable CTE patterns  
- Subquery-based comparisons  
- Set-based relational analysis  

All Phase 2 work will be placed in the `03_dimensional_breakdowns` folder.

---

Phase 1 is now sealed and will not be modified further.
