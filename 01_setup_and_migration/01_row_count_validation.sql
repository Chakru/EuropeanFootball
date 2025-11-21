-- File: 01_row_count_validation.sql
-- Purpose:
-- Validate that all tables were migrated correctly from SQLite to SQL Server.
-- Compares row counts to expected numbers based on the Kaggle dataset.

------------------------------------------------------------
-- Row count for all tables in the database
------------------------------------------------------------

USE EuropeanSoccer;

GO


SELECT 
    t.NAME AS [Table Name], 
    p.rows AS [Row Count]
FROM 
    sys.tables t
INNER JOIN      
    sys.partitions p ON t.object_id = p.object_id
WHERE 
    p.index_id IN (0,1)
ORDER BY 
    [Row Count] DESC;

GO

------------------------------------------------------------
-- Individual table row checks (Optional, add/update as needed)
------------------------------------------------------------

SELECT COUNT(*) AS [Match Rows] FROM Match;
SELECT COUNT(*) AS [Team Rows] FROM Team;
SELECT COUNT(*) AS [Player Rows] FROM Player;
SELECT COUNT(*) AS [League Rows] FROM League;
SELECT COUNT(*) AS [Country Rows] FROM Country;
SELECT COUNT(*) AS [Team Attributes Rows] FROM Team_Attributes;
SELECT COUNT(*) AS [Player Attributes Rows] FROM Player_Attributes;

GO
