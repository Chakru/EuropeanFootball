/* 
Project: European Soccer Game Analysis
Phase: 1.3 Basic Aggregation Work
Author: Abhishek Chakravarty
Description: Foundational aggregation queries to understand match distributions, scoring patterns and seasonal coverage.
*/

USE EuropeanSoccer
GO

-- Problem:
-- Count the number of matches played in each season.
-- Purpose:
-- Understand match volume trends over time.
-- Expected Output:
-- Season, match count sorted chronologically.

SELECT season AS [Season], COUNT(*) AS [Match Count] FROM Match GROUP BY season ORDER BY season ASC;
GO


-- Problem:
-- Count how many matches belong to each country by linking Match → League → Country.
-- Purpose:
-- Understand geographic distribution of the dataset and prepare for later multi-table joins.
-- Expected Output:
-- Country name, total matches sorted from highest to lowest.

SELECT C.name AS [Country Name], count(*) AS [Total Matches] FROM Country C INNER JOIN Match M ON C.id = M.country_id GROUP BY name ORDER BY [Total Matches] DESC;
GO


-- Problem:
-- Compute total goals scored per season combining home and away goals.
-- Purpose:
-- Explore scoring trends and variability across seasons.
-- Expected Output:
-- Season, total goals sorted chronologically.

SELECT season AS [Season], SUM(home_team_goal + away_team_goal) AS [Total Goals] FROM Match GROUP BY [Season] Order By [Season] desc;
GO

-- Problem:
-- Calculate the average number of goals per match for each season.
-- Purpose:
-- Establish season-level scoring intensity and identify high/low scoring years.
-- Expected Output:
-- Season, average total goals (rounded to 2 decimals).

SELECT season AS [Season], ROUND(AVG(CAST(home_team_goal + away_team_goal AS FLOAT)),2) AS [Avg Goals Per Match] FROM Match GROUP BY [Season] ORDER BY [Season];
GO

-- Problem:
-- Identify the single match with the highest total goals for each season.
-- Purpose:
-- Understand extreme scoring events and validate goal data integrity.
-- Expected Output:
-- Season, match ID, total goals sorted by season.

SELECT 
	season AS [Season], id AS [Id], 
	(HOME_TEAM_GOAL + AWAY_TEAM_GOAL) AS [Total Goals] 
	FROM Match WHERE (HOME_TEAM_GOAL + AWAY_TEAM_GOAL) = 
		(SELECT MAX(home_team_goal + away_team_goal) 
			FROM Match M1 WHERE m1.season = Match.season) 
ORDER BY season ASC;
GO


-- Problem:
-- Produce a distribution of home-team scoring frequencies.
-- Purpose:
-- Establish descriptive statistics for home-team performance.
-- Expected Output:
-- Goal bucket (0,1,2,3,4,5+), match count.

SELECT CASE
	WHEN home_team_goal = 0 THEN '0'
	WHEN home_team_goal = 1 THEN '1'
	WHEN home_team_goal = 2 THEN '2'
	WHEN home_team_goal = 3 THEN '3'
	WHEN home_team_goal = 4 THEN '4'
	ELSE '5+'
	END AS [Goal Bucket],
	COUNT(*) AS [Match Count]
	
	FROM Match 
	GROUP BY CASE 
		WHEN home_team_goal = 0 THEN '0'
		WHEN home_team_goal = 1 THEN '1'
		WHEN home_team_goal = 2 THEN '2'
		WHEN home_team_goal = 3 THEN '3'
		WHEN home_team_goal = 4 THEN '4'
		ELSE '5+'
		END
	ORDER BY CASE 
		WHEN home_team_goal = 0 THEN '0'
		WHEN home_team_goal = 1 THEN '1'
		WHEN home_team_goal = 2 THEN '2'
		WHEN home_team_goal = 3 THEN '3'
		WHEN home_team_goal = 4 THEN '4'
		ELSE '5+'
		END
GO
	
-- Problem:
-- Detect matches with null values in key columns (date, season, home goals, away goals).
-- Purpose:
-- Early-stage data quality assessment before data modelling.
-- Expected Output:
-- Match ID, missing column info.

-- Rows where any critical column is NULL, with list of missing columns per row
SELECT id AS [Match ID],
       season,
       date,
       home_team_api_id,
       away_team_api_id,
       home_team_goal,
       away_team_goal,
       league_id,
       -- build a short comma-separated list of missing columns
       LTRIM(
         RTRIM(
           COALESCE(NULLIF(CASE WHEN season IS NULL THEN 'season, ' ELSE '' END, ''),'') +
           COALESCE(NULLIF(CASE WHEN date IS NULL THEN 'date, ' ELSE '' END, ''),'') +
           COALESCE(NULLIF(CASE WHEN home_team_api_id IS NULL THEN 'home_team_api_id, ' ELSE '' END, ''),'') +
           COALESCE(NULLIF(CASE WHEN away_team_api_id IS NULL THEN 'away_team_api_id, ' ELSE '' END, ''),'') +
           COALESCE(NULLIF(CASE WHEN home_team_goal IS NULL THEN 'home_team_goal, ' ELSE '' END, ''),'') +
           COALESCE(NULLIF(CASE WHEN away_team_goal IS NULL THEN 'away_team_goal, ' ELSE '' END, ''),'') +
           COALESCE(NULLIF(CASE WHEN league_id IS NULL THEN 'league_id, ' ELSE '' END, ''),'')
         )
       ) AS [Missing Columns]
FROM Match
WHERE season IS NULL
   OR date IS NULL
   OR home_team_api_id IS NULL
   OR away_team_api_id IS NULL
   OR home_team_goal IS NULL
   OR away_team_goal IS NULL
   OR league_id IS NULL;
GO


-- Problem:
-- Compare home vs away appearances per team for each season.
-- Purpose:
-- Validate team participation balance and detect outliers.
-- Expected Output:
-- Season, team_id, home_count, away_count.

SELECT season,
       team_id,
       SUM(CASE WHEN team_role = 'home' THEN 1 ELSE 0 END) AS home_count,
       SUM(CASE WHEN team_role = 'away' THEN 1 ELSE 0 END) AS away_count
FROM (
    SELECT season, home_team_api_id AS team_id, 'home' AS team_role
    FROM Match
    UNION ALL
    SELECT season, away_team_api_id AS team_id, 'away' AS team_role
    FROM Match
) t
GROUP BY season, team_id
ORDER BY season, team_id;
GO


-- Problem:
-- Determine the match in each season with the largest goal margin.
-- Purpose:
-- Begin identifying extreme competitive imbalances.
-- Expected Output:
-- Season, match ID, goal difference.

SELECT season, id, ABS(home_team_goal - away_team_goal) AS [Goal Difference] FROM Match 
	WHERE ABS(home_team_goal - away_team_goal) = (SELECT MAX(ABS(home_team_goal - away_team_goal) )
	FROM Match M1 WHERE M1.season = MATCH.season) ORDER BY season ASC;
GO


-- Problem:
-- Rank seasons by total goals scored across all matches.
-- Purpose:
-- Produce a simple scoring leaderboard across years.
-- Expected Output:
-- Season, total goals ordered from highest to lowest, top 10 only.

SELECT TOP 10 season, SUM(home_team_goal + away_team_goal) AS [Total Goals] FROM Match GROUP BY season ORDER BY [Total Goals] DESC;
GO
