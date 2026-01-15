/* 
Project: European Soccer Game Analysis (SQL Only)
Phase: 2.1 Join-Based Queries
Author: Abhishek Chakravarty
Description: Multi-table queries using joins to enrich match data with team, league, and country context.
*/

USE EuropeanSoccer
GO

-- Problem:
-- Retrieve match-level data with home team names.
-- Purpose:
-- Practice basic join between Match and Team.
-- Expected Output:
-- Match ID, season, date, home team name, home goals.

SELECT 
	M.id AS [Match ID],
	M.season AS [Season],
	CAST(M.date AS date) AS [Date],
	T.team_long_name AS [Team Name],
	M.home_team_goal AS [Goals]
FROM Match M INNER JOIN Team T 
ON M.home_team_api_id = T.team_api_id;
GO


-- Problem:
-- Retrieve match-level data with away team names.
-- Purpose:
-- Practice basic join between Match and Team.
-- Expected Output:
-- Match ID, season, date, away team name, away goals.

SELECT 
	M.id AS [Match ID],
	M.season AS [Season],
	CAST(M.date AS date) AS [Date],
	T.team_long_name AS [Team Name],
	M.away_team_goal AS [Goals]
FROM Match M INNER JOIN Team T 
ON M.away_team_api_id = T.team_api_id;
GO 


-- Problem:
-- Retrieve match data with both home and away team names.
-- Purpose:
-- Practice joining the same dimension table twice.
-- Expected Output:
-- Match ID, season, home team name, away team name, goals.

SELECT
	M.id AS [Match ID],
	M.season AS [Season],
	HomeTeam.team_long_name AS [Home Team],
	M.home_team_goal AS [Home Team Goals],
	AwayTeam.team_long_name AS [Away Team],
	M.away_team_goal AS[Away Team Goals]
FROM MATCH M 
INNER JOIN TEAM HomeTeam ON M.home_team_api_id = HomeTeam.team_api_id 
INNER JOIN TEAM AwayTeam ON M.away_team_api_id = AwayTeam.team_api_id;
GO


-- Problem:
-- Retrieve match details along with league names.
-- Purpose:
-- Add competition context to match data.
-- Expected Output:
-- Match ID, season, league name, date.

SELECT 
	M.id AS [Match ID],
	M.season AS [Season],
	L.name AS [League Name],
	CAST(M.date AS date) AS [Date]
FROM Match M INNER JOIN League L
ON M.league_id = L.id;
GO


-- Problem:
-- Retrieve match data with associated country names.
-- Purpose:
-- Practice multi-hop joins.
-- Expected Output:
-- Match ID, season, league name, country name.

SELECT
	M.id AS [Match ID],
	M.season AS [Season],
	L.name AS [League Name],
	C.name AS [Country Name]
FROM Match M INNER JOIN League L ON M.league_id = L.id 
INNER JOIN Country C ON L.country_id = C.id;
GO


-- Problem:
-- Retrieve matches with home team, away team, and league names.
-- Purpose:
-- Combine multiple joins in a single query.
-- Expected Output:
-- Match ID, season, home team, away team, league.

SELECT
	M.id AS [Match ID],
	M.season AS [Season],
	T.team_long_name AS [Home Team],
	T1.team_long_name AS [Away Team], 
	L.name AS [League Name]
FROM Match M INNER JOIN League L
ON M.league_id = L.id 
INNER JOIN Team T ON M.home_team_api_id = T.team_api_id
INNER JOIN TEAM T1 ON M.away_team_api_id = T1.team_api_id;
GO


-- Problem:
-- Retrieve all matches where a specific team participated (home or away).
-- Purpose:
-- Practice OR conditions with joins.
-- Expected Output:
-- Match ID, season, home team, away team.

SELECT 
	M.id AS [Match ID],
	M.season AS [Season],
	HomeTeam.team_long_name AS [Home Team],
	AwayTeam.team_long_name AS [Away Team]
FROM Match M 
INNER JOIN Team HomeTeam ON M.home_team_api_id = HomeTeam.team_api_id
INNER JOIN TEAM AwayTeam ON M.away_team_api_id = AwayTeam.team_api_id
WHERE HomeTeam.team_long_name = 'FC Barcelona' OR AwayTeam.team_long_name = 'FC Barcelona';
GO


-- Problem:
-- Retrieve all matches played in a specific country.
-- Purpose:
-- Combine filtering with multi-table joins.
-- Expected Output:
-- Match ID, season, league, country.

SELECT 
	M.id AS [Match ID],
	M.season AS [Season],
	L.name AS [League Name],
	C.name AS [Country]
FROM Match M 
INNER JOIN League L ON M.league_id = L.id
INNER JOIN Country C ON L.country_id = C.id
WHERE C.name = 'Spain';
GO

-- Problem:
-- Count how many matches each team played using joins.
-- Purpose:
-- Validate participation frequency.
-- Expected Output:
-- Team name, total matches played.

SELECT 
	T.team_long_name AS [Team Name],
	COUNT(*) AS [Total Matches Played] 
FROM Match M INNER JOIN Team T 
ON T.team_api_id IN (M.home_team_api_id, M.away_team_api_id)
GROUP BY T.team_long_name
ORDER BY [Total Matches Played] DESC;
GO


-- Problem:
-- Count total matches per league using joins.
-- Purpose:
-- Reinforce aggregation with joins.
-- Expected Output:
-- League name, match count.

SELECT
	L.name AS [League Name],
	COUNT(*) AS [Match Count]
FROM Match M INNER JOIN League L
ON M.league_id = L.id
GROUP BY L.name
ORDER BY [Match Count] DESC;
GO

