# European Soccer Game Analysis

A structured, SQL analytical project built using Microsoft SQL Server. This repository documents an end-to-end journey: from dataset migration and validation to deep relational and analytical SQL.

---

## Table of Contents
- [Project Overview](#project-overview)
- [Objectives](#objectives)
- [Tech Stack](#tech-stack)
- [Project Roadmap](#project-roadmap)
- [Repository Structure](#repository-structure)
- [Current Status](#current-status)
- [Dataset](#dataset)
- [How to Use This Repository](#how-to-use-this-repository)

---

## Project Overview

This project is designed to build strong, production-ready SQL skills through a realistic analytics workflow. The focus is not just on writing queries, but on understanding data, validating it, structuring analysis, and gradually moving toward an analytical data model built entirely in SQL.

All work is executed inside Microsoft SQL Server using T-SQL.

---

## Objectives

- Develop a deep understanding of relational databases and SQL Server internals  
- Practise structured SQL analysis using real-world sports data  
- Progress from basic exploration to advanced analytical SQL  
- Build reusable, well-documented SQL scripts  
- Create a GitHub-ready SQL portfolio project  

---

## Tech Stack

- Microsoft SQL Server Express  
- SQL Server Management Studio (SSMS)  
- T-SQL  
- Python (for SQLite → SQL Server migration only)  

---

## Project Roadmap

### Phase 1: Exploration & Foundations ✅ **Completed**
- Database migration from SQLite  
- Schema inspection and relationship verification  
- Basic SELECT queries  
- Aggregation and summarisation  
- Data validation and integrity checks  

**Deliverable:**  
Complete exploration and validation SQL script collection

---

### Phase 2: Relational Mastery (Joins, CTEs, Subqueries)
- Multi-table joins (Match, Team, League, Country)  
- Reusable CTE libraries  
- Subquery-based comparisons  
- Set-based analysis  

---

### Phase 3: Analytical SQL (Advanced Concepts)
- Window functions  
- CASE-based classifications  
- Date and time analysis  
- Anomaly detection using SQL only  

---

### Phase 4: SQL Data Modelling
- Staging → Clean → Model schema design  
- Data cleaning and standardisation  
- Analytical SQL views  

---

### Phase 5: Optimisation & Production Readiness
- Indexing strategies  
- Query plan optimisation  
- Stored procedures  
- Final documentation  

---

## Repository Structure

The repository is organized into different phases, each corresponding to a key part of the project. Each folder contains SQL scripts that walk through that phase of the project.

| Folder Name                   | Description                                                      |
|-------------------------------|------------------------------------------------------------------|
| **/01_setup_and_migration**    | SQL scripts for environment setup and database import           |
| **/02_exploration**            | First-level queries to understand tables, schema, relationships |
| **/03_dimensional_breakdowns** | League-level, team-level, player-level, and seasonal analysis   |
| **/04_advanced_analysis**      | More complex joins, metrics, and performance insights           |
| **/05_documentation**          | Notes, diagrams, and supporting files   


---

## Current Status

- Phase 1 (Exploration & Foundations): **Completed**
- Phase 2 (Relational Mastery): **Up next**

All Phase 1 scripts have been validated and committed. The database is now fully understood, verified, and ready for relational analysis.

---

## Dataset

**European Soccer Database**  
Source: Kaggle  
Format: SQLite (`database.sqlite`)  

The dataset includes:
- Matches  
- Teams  
- Players  
- Team attributes  
- Player attributes  
- Leagues  
- Countries  

The raw dataset is not included in this repository due to size and licensing considerations.

---

## How to Use This Repository

1. Set up the database using scripts in `01_setup_and_migration`  
2. Review exploration and validation queries in `02_exploration`  
3. Follow the roadmap sequentially as new phases are added  
4. All scripts are written for Microsoft SQL Server (T-SQL)

Each folder contains focused SQL scripts and supporting documentation.

---

## Project Status

This repository will continue to evolve as the project progresses through advanced relational analysis, analytical SQL, and data modelling phases.
