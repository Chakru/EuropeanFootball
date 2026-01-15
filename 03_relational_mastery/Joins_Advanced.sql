/* 
Project: European Soccer Game Analysis (SQL Only)
Phase: 2.1 Advanced Join Practice
Author: Abhishek Chakravarty
Description: Advanced join scenarios focusing on correctness, edge cases, and analytical thinking.
*/


USE EuropeanSoccer
GO

-- Problem:
-- Retrieve match results with home team name, away team name, and match outcome.
-- Purpose:
-- Practice joins combined with conditional logic.
-- Expected Output:
-- Match ID, season, home team, away team, home goals, away goals, result (Home Win / Away Win / Draw).

SELECT 
	 M.id AS [Match ID],
	 M.season AS [Season],
	 HomeTeam.team_long_name AS [Home Team],
	 AwayTeam.team_long_name AS [Away Team],
	 M.home_team_goal AS [Home Team Goal],
	 M.away_team_goal AS [Away Team Goal],
	 CASE 
			WHEN M.home_team_goal > M.away_team_goal THEN 'Home Win'
			WHEN M.home_team_goal < M.away_team_goal THEN 'Away Win'
			ELSE 'Draw' 
	END AS [Result]
FROM Match M 
	INNER JOIN Team HomeTeam
		ON M.home_team_api_id = HomeTeam.team_api_id
	INNER JOIN Team AwayTeam
		ON M.away_team_api_id = AwayTeam.team_api_id
ORDER BY M.season;
GO


-- Problem:
-- Calculate total home goals and total away goals per league.
-- Purpose:
-- Combine joins with grouped aggregations.
-- Expected Output:
-- League name, total home goals, total away goals.

SELECT
	L.name AS [League Name],
	SUM(M.home_team_goal) AS [Home Goals],
	SUM(M.away_team_goal) AS [Away Goals]
FROM Match M
	INNER JOIN League L
		ON M.league_id = L.id
GROUP BY L.name;
GO


-- Problem:
-- For each country, calculate total matches and total goals scored.
-- Purpose:
-- Practice multi-hop joins with aggregation.
-- Expected Output:
-- Country name, total matches, total goals.

SELECT 
    C.name AS [Country],
    COUNT(*) AS [Total Matches],
    SUM(M.home_team_goal + M.away_team_goal) AS [Total Goals]
FROM Match M
	INNER JOIN League L 
		ON M.league_id = L.id
	INNER JOIN Country C 
		ON L.country_id = C.id
GROUP BY C.name;
GO


-- Problem:
-- For each team, calculate goals scored at home and goals scored away.
-- Purpose:
-- Practice joining the same table in different roles and aggregating correctly.
-- Expected Output:
-- Team name, home goals scored, away goals scored.

SELECT 
    T.team_long_name AS [Team Name],
    SUM(CASE WHEN role = 'Home' THEN goals ELSE 0 END) AS [Home Goals],
    SUM(CASE WHEN role = 'Away' THEN goals ELSE 0 END) AS [Away Goals]
FROM (
    SELECT home_team_api_id AS team_api_id, home_team_goal AS goals, 'Home' AS role
    FROM Match
    UNION ALL
    SELECT away_team_api_id, away_team_goal, 'Away'
    FROM Match
) M
	INNER JOIN Team T 
		ON M.team_api_id = T.team_api_id
GROUP BY T.team_long_name;
GO


-- Problem:
-- Identify teams that have more away wins than home wins.
-- Purpose:
-- Test complex join conditions and grouped comparisons.
-- Expected Output:
-- Team name, home wins, away wins.

SELECT 
	T.team_long_name AS [Team Name],
	SUM(
			CASE 
				WHEN 
					T.team_api_id = M.home_team_api_id AND M.home_team_goal > M.away_team_goal THEN 1 ELSE 0
			END
		) AS [Home Wins],
	SUM(
			CASE	
				WHEN 
					T.team_api_id = M.away_team_api_id AND M.away_team_goal > M.home_team_goal THEN 1 ELSE 0
			END
		) AS [Away Wins]
FROM Match M 
	INNER JOIN Team T
		ON T.team_api_id IN (M.home_team_api_id, M.away_team_api_id)
GROUP BY T.team_long_name
HAVING
    SUM(
        CASE 
            WHEN T.team_api_id = M.away_team_api_id
                 AND M.away_team_goal > M.home_team_goal
            THEN 1 ELSE 0
        END
    ) >
    SUM(
        CASE 
            WHEN T.team_api_id = M.home_team_api_id
                 AND M.home_team_goal > M.away_team_goal
            THEN 1 ELSE 0
        END
    );
GO


-- Problem:
-- Identify leagues that have match data for every available season in the dataset.
-- Purpose:
-- Practice joins combined with distinct counts.
-- Expected Output:
-- League name.

SELECT 
	L.name AS [League Name]
FROM League L INNER JOIN 
	(
		SELECT 
			league_id
		FROM Match
		GROUP BY league_id
		HAVING 
			COUNT(DISTINCT season) = (SELECT COUNT(DISTINCT season) FROM Match)
		
	)t
ON L.id = T.league_id;
GO


-- Problem:
-- For each league, identify the top 3 teams by total goals scored.
-- Purpose:
-- Practice multi-table joins with grouped ranking logic (no window functions yet).
-- Expected Output:
-- League name, team name, total goals.

SELECT *
FROM (
    SELECT 
        L.name AS [League Name],
        T.team_long_name AS [Team Name],
        SUM(
            CASE 
                WHEN T.team_api_id = M.home_team_api_id THEN M.home_team_goal
                ELSE M.away_team_goal
            END
        ) AS [Total Goals]
    FROM Match M
		INNER JOIN League L 
			ON M.league_id = L.id
		INNER JOIN Team T 
			ON T.team_api_id IN (M.home_team_api_id, M.away_team_api_id)
    GROUP BY L.name, T.team_long_name
) x
WHERE (
    SELECT COUNT(*)
    FROM (
        SELECT 
            SUM(
                CASE 
                    WHEN T2.team_api_id = M2.home_team_api_id THEN M2.home_team_goal
                    ELSE M2.away_team_goal
                END
            ) AS [Goals]
        FROM Match M2
			INNER JOIN Team T2 
				ON T2.team_api_id IN (M2.home_team_api_id, M2.away_team_api_id)
        WHERE M2.league_id = (
            SELECT id FROM League WHERE name = x.[League Name]
        )
        GROUP BY T2.team_api_id
    ) y
    WHERE y.[Goals] >= x.[Total Goals]
) <= 3;
GO


-- Problem:
-- Identify matches where the home team and away team are the same.
-- Purpose:
-- Data sanity validation using joins.
-- Expected Output:
-- Match ID, team name, season.

SELECT 
	M.id AS [Match ID],
	T.team_long_name AS [Team Name],
	M.season AS [Season]
FROM Match M 
	INNER JOIN Team T
		ON T.team_api_id = M.home_team_api_id
WHERE M.home_team_api_id = M.away_team_api_id;
GO


-- Problem:
-- Identify teams that appear in more than one league across all seasons.
-- Purpose:
-- Test joins combined with distinct aggregation.
-- Expected Output:
-- Team name, number of leagues played.

SELECT 
	[Team Name],
	COUNT(DISTINCT [League ID]) AS [LEAGUE NUMBER]
FROM (
	SELECT
		T.team_long_name AS [Team Name],
		M.league_id AS [League ID]
	FROM Match M 
		INNER JOIN Team T 
			ON T.team_api_id IN (M.home_team_api_id, M.away_team_api_id)
)T 
GROUP BY [Team Name]
HAVING COUNT(DISTINCT [League ID]) > 1;
GO


-- Problem:
-- For each league, identify the match with the highest total goals.
-- Purpose:
-- Practice joins combined with grouped max logic.
-- Expected Output:
-- League name, match ID, total goals.

SELECT 
    L.name AS [League Name],
    M.id AS [Match ID],
    (M.home_team_goal + M.away_team_goal) AS [Total Goals]
FROM Match M
	INNER JOIN League L 
		ON M.league_id = L.id
WHERE (M.home_team_goal + M.away_team_goal) = (
    SELECT MAX(M2.home_team_goal + M2.away_team_goal)
    FROM Match M2
    WHERE M2.league_id = M.league_id
);
GO


-- Problem:
-- Identify teams that never won a match when playing at home.
-- Purpose:
-- Test exclusion logic using joins and conditions.
-- Expected Output:
-- Team name.

SELECT 
	DISTINCT T.team_long_name AS [Team]
FROM TEAM T 
	INNER JOIN Match HG
		ON T.team_api_id = HG.home_team_api_id
	LEFT JOIN Match M 
		ON T.team_api_id = M.home_team_api_id 
	AND 
		M.home_team_goal > M.away_team_goal
WHERE M.id IS NULL;
GO


-- Problem:
-- Calculate the average goal difference (home goals minus away goals) per league.
-- Purpose:
-- Measure home advantage using joins and aggregation.
-- Expected Output:
-- League name, average goal difference.

SELECT 
	L.name AS [League Name],
	ROUND(
		AVG(
				CAST((M.home_team_goal - M.away_team_goal) AS float)
			)
		,2) AS [Average GD]
FROM Match M 
	INNER JOIN League L
		ON M.league_id = L.id
GROUP BY L.name;
GO