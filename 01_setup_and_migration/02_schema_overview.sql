-- File: 02_schema_overview.sql
-- Purpose:
-- Understand database structure after migration: tables, columns, keys, relationships, and sample data.

------------------------------------------------------------
-- Retrieve all tables and their columns
------------------------------------------------------------

USE EuropeanSoccer;

GO

SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_NAME, ORDINAL_POSITION;

GO

------------------------------------------------------------
-- Identify primary keys across all tables
------------------------------------------------------------

SELECT 
    ku.TABLE_NAME,
    ku.COLUMN_NAME AS PRIMARY_KEY
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE ku
    ON tc.CONSTRAINT_NAME = ku.CONSTRAINT_NAME
WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
ORDER BY ku.TABLE_NAME;

GO

------------------------------------------------------------
-- Retrieve all foreign key relationships
------------------------------------------------------------

SELECT 
    fk.name AS FK_Name,
    tp.name AS Parent_Table,
    cp.name AS Parent_Column,
    tr.name AS Referencing_Table,
    cr.name AS Referencing_Column
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc 
    ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.tables tp 
    ON fkc.referenced_object_id = tp.object_id
INNER JOIN sys.columns cp 
    ON fkc.referenced_object_id = cp.object_id 
    AND fkc.referenced_column_id = cp.column_id
INNER JOIN sys.tables tr 
    ON fkc.parent_object_id = tr.object_id
INNER JOIN sys.columns cr 
    ON fkc.parent_object_id = cr.object_id 
    AND fkc.parent_column_id = cr.column_id
ORDER BY Parent_Table;

GO

------------------------------------------------------------
-- Preview Match table
------------------------------------------------------------

SELECT TOP 50 *
FROM Match
ORDER BY date;

GO

------------------------------------------------------------
-- Preview Team table
------------------------------------------------------------

SELECT *
FROM Team
ORDER BY team_api_id;

GO

------------------------------------------------------------
-- Preview League table
------------------------------------------------------------

SELECT *
FROM League
ORDER BY id;

GO
