/* 
Project: European Soccer Game Analysis
Phase: 1.2 Basic SELECT Queries
Author: Abhishek Chakravarty
Description: Fundamental query tasks to explore base tables and understand the dataset.
*/


USE EuropeanSoccer
GO

-- Problem:
-- Retrieve the complete list of leagues available in the dataset.
-- Purpose:
-- Establish the top-level competitions that form the basis of all match data.
-- Expected Output:
-- League ID, League Name.

SELECT id [League Id], NAME AS [League Name] FROM League;
GO


-- Problem:
-- Retrieve the list of countries represented in the dataset.
-- Purpose:
-- Understand geographical coverage and link leagues to countries later.
-- Expected Output:
-- Country ID, Country Name.

SELECT Id AS [Country Id], NAME AS [Country Name] FROM Country;
GO


-- Problem:
-- Find all unique seasons present in the Match dataset.
-- Purpose:
-- Determine the temporal scope for later seasonal analysis.
-- Expected Output:
-- Distinct season values sorted chronologically.

SELECT DISTINCT season AS [Season] FROM MATCH ORDER BY [Season] DESC;
GO


-- Problem:
-- Count the total number of match records in the dataset.
-- Purpose:
-- Validate row counts and understand dataset size for future performance considerations.
-- Expected Output:
-- Single number: total matches.

SELECT COUNT(*) AS [Total Matches] FROM Match;
GO


-- Problem:
-- Retrieve all matches from a chosen league.
-- Purpose:
-- Build comfort filtering and understanding league-level segmentation.
-- Expected Output:
-- Match ID, season, date, home_team_api_id, away_team_api_id for that league.

SELECT id AS [Match ID], season AS [Season], CAST(date AS DATE) AS [Match Date], home_team_api_id AS [Home Team Id], away_team_api_id AS [Away Team Id] FROM MATCH WHERE league_id = 21518;
GO


-- Problem:
-- View the earliest or latest matches in the dataset.
-- Purpose:
-- Understand temporal sorting and date field accuracy.
-- Expected Output:
-- 20 rows sorted ASC or DESC by date.

SELECT TOP 20 id AS [Match ID], season AS [Season], CAST(date AS DATE) AS [Match Date], home_team_api_id AS [Home Team Id], away_team_api_id AS [Away Team Id] FROM MATCH ORDER BY date DESC;
GO


-- Problem:
-- Retrieve a deduplicated list of teams.
-- Purpose:
-- Build understanding of team dimensions and identifiers.
-- Expected Output:
-- Distinct team_long_name, team_api_id.

SELECT DISTINCT TEAM_API_ID AS [Team Id], TEAM_LONG_NAME AS [Team Name] FROM Team;
GO


-- Problem:
-- Count number of matches grouped by league.
-- Purpose:
-- Understand distribution of match data across leagues.
-- Expected Output:
-- League ID, number of matches sorted from highest to lowest.

SELECT league_id, COUNT(*) AS [Number of Matches] FROM MATCH GROUP BY league_id ORDER BY [Number of Matches] DESC;
GO


-- Problem:
-- Compute average goals scored by home teams and away teams.
-- Purpose:
-- Build initial scoring insights using basic aggregation.
-- Expected Output:
-- Two numbers: average home goals, average away goals.

SELECT ROUND(AVG(CAST(home_team_goal AS FLOAT)), 2) AS [Avg. Home Goal], ROUND(AVG(CAST(away_team_goal AS FLOAT)), 2) AS [Avg. Away Goal] FROM MATCH;
GO


-- Problem:
-- Retrieve matches with unusually high scoring.
-- Purpose:
-- Begin exploring extreme values for future anomaly detection.
-- Expected Output:
-- Match ID, season, date, goals, home_team_api_id, away_team_api_id.

SELECT id AS [Match Id], season AS [Season], CAST(date AS DATE) as [Date], (home_team_goal + away_team_goal) AS [Goals], home_team_api_id AS [Home Team Id], away_team_api_id AS [Away Team Id] FROM Match where (home_team_goal + away_team_goal) > 5 ORDER BY Goals DESC;
GO