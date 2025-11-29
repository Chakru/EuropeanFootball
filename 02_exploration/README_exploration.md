# Phase 1 — Exploration & Foundations  
This folder contains all SQL scripts for Phase 1.2 and Phase 1.3 of the European Soccer Game Analysis project. The goal of this phase is to understand the dataset through basic SELECT operations, filtering, ordering, and foundational aggregation work.

---

## Contents

### 1. `Basic_Select_Query.sql`  
Covers Phase 1.2  
Includes introductory SQL tasks such as:
- Retrieving leagues, countries, seasons  
- Exploring matches with filters and ordering  
- Inspecting team identifiers  
- Counting matches  
- Detecting high-scoring matches  
- Understanding early dataset structure  

These queries help build familiarity with core tables before moving into deeper analysis.

---

### 2. `Basic_Aggregation.sql`  
Covers Phase 1.3  
Includes foundational aggregation logic such as:
- Match counts per season  
- Match counts per country  
- Season-level goal totals  
- Average goal scoring patterns  
- Highest scoring matches per season  
- Scoring frequency distributions  
- Null-checks for key match fields  
- Home vs away participation balance  
- Goal margin extremes per season  
- Ranking seasons by total goals  

This file strengthens analytical fluency by using GROUP BY, HAVING, aggregation functions, subqueries, and CASE expressions.

---

## Purpose of This Phase  
Phase 1 establishes a strong foundation for the rest of the project. It ensures:
- Full understanding of table relationships  
- Confidence in reading and exploring base tables  
- Early detection of anomalies or missing values  
- Development of clean and structured SQL habits  

These scripts prepare the ground for Phase 2, where multi-table joins and CTEs will be introduced.

---

## How to Use This Folder
Run the scripts in order, starting from:
1. `Basic_Select_Query.sql`  
2. `Basic_Aggregation.sql`

Use SQL Server Management Studio (SSMS) with the database:
```
USE EuropeanSoccer;
GO
```

Each script includes descriptions, problems, purposes, and expected outputs for self-guided learning and portfolio documentation.

---

## Next Steps  
Proceed to **Phase 1.4 — Data Validation** where we will:
- Check missing IDs  
- Validate date ranges  
- Validate season formats  
- Test numerical ranges  
- Confirm consistency between Country → League → Match  

Once Phase 1 is fully complete, we will move to Phase 2 for join-based relational analysis.
