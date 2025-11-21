# European Soccer Game Analysis

A structured SQL Server project built to explore and analyse the European Soccer Database. This repository documents the full journey: from data migration to deep analytical queries, all inside Microsoft SQL Server.

---

## Table of Contents
- [Project Overview](#project-overview)
- [Objectives](#objectives)
- [Tech Stack](#tech-stack)
- [Repository Structure](#repository-structure)
- [Current Progress](#current-progress)
- [Dataset](#dataset)
- [How to Use This Repository](#how-to-use-this-repository)

---

## Project Overview

This project is designed to sharpen SQL expertise using a complete end-to-end workflow. You’ll find scripts that walk through environment setup, database migration, exploratory queries, and progressively complex analysis. The focus is on clarity, structure, and real analytical thinking.

---

## Objectives

- Build a strong command of Microsoft SQL Server through hands-on work.  
- Explore league, team, match, and player data using targeted queries.  
- Develop reusable SQL scripts for exploration and analysis.  
- Document the process with clear, organised folders.  
- Apply database analysis to replicate real-world analytics workflows.

---

## Tech Stack

- Microsoft SQL Server Express  
- T-SQL  
- SQLite (original Kaggle dataset)  
- SQL Server Management Studio (SSMS)

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

## Current Progress

- Database migration from SQLite to Microsoft SQL Server: **Completed**  
- Data verification against Kaggle row counts: **Completed**  
- Phase 2 (Exploration) starting next: writing and documenting exploratory SQL scripts  

---

## Dataset

**Source:** European Soccer Database (Kaggle)  
Includes:  
- Matches  
- Teams  
- Players  
- Team attributes  
- Player attributes  
- Leagues  
- Countries  

This dataset is widely used for learning relational analysis and multi-table SQL querying.

---

## How to Use This Repository

1. Open the folder that corresponds to the phase you want to explore.  
2. Each SQL file includes a short description of what the query does.  
3. Scripts are written for SQL Server, so they use T-SQL syntax.  
4. New folders and scripts will be added as the project progresses.

---

## Project Status

This repo will evolve alongside the project. Each phase will include well-structured scripts, detailed comments, and documented insights.

Stay tuned for updates in the exploration folder.
