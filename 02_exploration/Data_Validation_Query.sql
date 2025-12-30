/* 
Project: European Soccer Game Analysis
Phase: 1.4 Data Validation
Author: Abhishek Chakravarty
Description: Validation checks to confirm integrity, completeness, and correctness of the imported dataset.
*/

-- Problem:
-- Identify whether any match rows are missing a match ID or have duplicates.
-- Purpose:
-- Validate row uniqueness and identify corrupted or malformed rows.
-- Expected Output:
-- Count of null IDs, count of duplicate IDs.

-- Check for NULL match IDs
SELECT 
    COUNT(*) AS [Null Match ID Count]
FROM Match
WHERE id IS NULL;
GO

-- Check for duplicate match IDs
SELECT 
    id AS [Duplicate Match ID],
    COUNT(*) AS [Occurrence Count]
FROM Match
GROUP BY id
HAVING COUNT(*) > 1;
GO


-- Problem:
-- Validate that match dates fall within realistic football season years.
-- Purpose:
-- Identify outliers such as invalid dates, shifted decades, or nulls.
-- Expected Output:
-- Min date, max date, count of null dates.
 
SELECT 
	MIN(CAST(date AS date)) AS [Min Date],
	MAX(CAST(date AS date)) AS [Max Date],
	SUM(
		CASE
			WHEN date IS NULL THEN 1
			ELSE 0
		END
	) AS [Null Date Count]
FROM Match;
GO


-- Problem:
-- Ensure season values follow the expected 'YYYY/YYYY' or 'YYYY' pattern.
-- Purpose:
-- Detect malformed season entries and confirm dataset consistency.
-- Expected Output:
-- List of distinct season values that do NOT match expected format.
-- Note: Format validation is deferred to later phases; this step is for visibility only.

SELECT 
	DISTINCT season AS Season
FROM Match
ORDER BY season;
GO


-- Problem:
-- Identify matches where goals are negative or exceed realistic thresholds.
-- Purpose:
-- Detect corrupted data before modelling.
-- Expected Output:
-- Match ID, home_goals, away_goals for suspicious rows.

SELECT 
	id AS [Match ID],
	home_team_goal AS [Home Team Goal],
	away_team_goal AS [Away Team Goal]
FROM Match 
WHERE 
	home_team_goal < 0 
	OR 
	away_team_goal < 0 
	OR 
	home_team_goal > 15 
	OR 
	away_team_goal > 15;
GO


-- Problem:
-- Identify matches where home_team_api_id or away_team_api_id does not exist in the Team table.
-- Purpose:
-- Validate relationship integrity between Match and Team before joins.
-- Expected Output:
-- Count of invalid references, list of invalid IDs.

SELECT 
	DISTINCT home_team_api_id AS [Invalid Team ID]
FROM Match 
WHERE home_team_api_id NOT IN (SELECT team_api_id FROM Team)

UNION

SELECT 
	away_team_api_id AS [Invalid Team ID]
FROM Match 
WHERE away_team_api_id NOT IN (SELECT team_api_id FROM Team);
GO


-- Problem:
-- Detect match rows referencing non-existent leagues.
-- Purpose:
-- Ensure referential correctness ahead of Phase 2 join operations.
-- Expected Output:
-- Invalid league IDs and their occurrence counts.

SELECT 
	M.league_id AS [Invalid league ID], 
	COUNT(*) AS [Occurrence Counts] 
FROM Match M LEFT JOIN League L ON M.league_id = L.id 
WHERE L.id IS NULL 
GROUP BY M.league_id 
ORDER BY [Occurrence Counts] DESC;
GO


-- Problem:
-- Confirm that every league has a country and every country maps to at least one league.
-- Purpose:
-- Ensure the core geography hierarchy is intact.
-- Expected Output:
-- Countries with no leagues, leagues with no countries.

SELECT 
	C.id AS [Country ID], 
	L.ID AS [League ID],
	'Country without League' AS Issue
FROM Country C LEFT JOIN League L 
ON C.id = L.country_id 
WHERE L.id IS NULL

UNION 

SELECT 
	C.id AS [Country ID], 
	L.ID AS [League ID],
	'League without Country'
FROM League L LEFT JOIN Country C 
ON L.country_id = C.id 
WHERE C.id IS NULL;
GO


-- Problem:
-- Validate existence of corresponding attribute records for teams and players.
-- Purpose:
-- Estimate attribute table completeness for later advanced analysis.
-- Expected Output:
-- Count of teams without attributes, players without attributes.

SELECT 
	COUNT(*) AS [Missing Team Attributes]
FROM Team T LEFT JOIN Team_Attributes TA 
ON T.team_api_id = TA.team_api_id 
WHERE TA.team_api_id IS NULL;
GO


-- Problem:
-- Compare the imported row counts for Match, Team, Player, League, and Country with reference counts from Kaggle.
-- Purpose:
-- Final confirmation that migration was successful and complete.
-- Expected Output:
-- Table name, imported row count, expected row count, match/mismatch flag.

SELECT 
	'Country' AS table_name, 
	COUNT(*) AS imported_count, 
	11 AS expected_count,
	CASE 
		WHEN COUNT(*) = 11 THEN 'Match' 
		ELSE 'Mismatch' 
	END AS status
FROM Country

UNION ALL

SELECT 
	'League', 
	COUNT(*), 
	11,
    CASE 
		WHEN COUNT(*) = 11 THEN 'Match' 
		ELSE 'Mismatch' 
	END
FROM League

UNION ALL

SELECT 
	'Match',
	COUNT(*), 
	25979,
    CASE 
		WHEN COUNT(*) = 25979 THEN 'Match' 
		ELSE 'Mismatch' 
	END
FROM Match

UNION ALL

SELECT 
	'Player', 
	COUNT(*), 
	11060,
    CASE 
		WHEN COUNT(*) = 11060 THEN 'Match' 
		ELSE 'Mismatch' 
	END
FROM Player

UNION ALL

SELECT 
	'Player_Attributes', 
	COUNT(*), 
	183978,
    CASE 
		WHEN COUNT(*) = 183978 THEN 'Match' 
		ELSE 'Mismatch' 
	END
FROM Player_Attributes

UNION ALL

SELECT 
	'Team', 
	COUNT(*), 
	299,
    CASE 
		WHEN COUNT(*) = 299 THEN 'Match'
		ELSE 'Mismatch' 
	END
FROM Team

UNION ALL

SELECT 
	'Team_Attributes',
	COUNT(*), 
	1458,
    CASE 
		WHEN COUNT(*) = 1458 THEN 'Match' 
		ELSE 'Mismatch' 
	END
FROM Team_Attributes;
GO


-- Problem:
-- Identify rows that represent duplicate match entries.
-- Purpose:
-- Ensure integrity before creating analytical features in later phases.
-- Expected Output:
-- Duplicate match combinations with occurrence count.

SELECT
	date AS [Match Date],
	league_id AS [League id],
	season AS [Season],
	home_team_api_id AS [Home Team],
	away_team_api_id AS [Away Team],
	COUNT(*) AS [Occurrence Count]
FROM Match
GROUP BY date, league_id, season, home_team_api_id, away_team_api_id
HAVING COUNT(*) > 1;
GO