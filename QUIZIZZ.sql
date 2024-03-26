--What is the total number of registered users on Quizizz?
SELECT COUNT(userId) AS total_registered_users
FROM user_table;

--How many quizzes have been created in total?
SELECT COUNT(quizId) AS total_quiz
FROM quiz_table;

--What is the distribution of quiz creation over time?
SELECT DATE(createdAt) AS creation_date,
       COUNT(quizId) AS quizzes_created
FROM quiz_table
GROUP BY DATE(createdAt)
ORDER BY creation_date;

--Who are the top 10 users with the most quizzes created?
SELECT createdby AS quiz_Creator,
		COUNT(quizid) AS Number_of_quiz
FROM quiz_table
GROUP BY quiz_Creator
ORDER BY Number_of_quiz DESC
LIMIT 10


--How many games have been hosted on Quizizz?
SELECT COUNT(gameid) as number_of_games_hosted
FROM game_table;


--What is the distribution of game types?
SELECT gametype, COUNT(gametype) AS no_of_games
FROM game_table
GROUP BY gametype
ORDER BY no_of_games DESC

--How many players have participated in games in total?
SELECT SUM(totalPlayers) AS total_participants
FROM game_table;


--What is the average number of players per game?
SELECT SUM(totalplayers)/COUNT(gameid)
FROM game_table;


--How many responses have been received in total across all games?
SELECT SUM(totalresponses)  as total_responses
FROM game_table;


--What is the average number of responses per game?
SELECT AVG(totalresponses) as avg_response
FROM game_table;



--How does the distribution of game types vary over time?
SELECT TO_CHAR(createdAt, 'Mon YYYY') AS creation_month,
       gameType,
       COUNT(*) AS num_games
FROM game_table
GROUP BY TO_CHAR(createdAt, 'Mon YYYY'), gameType
ORDER BY MIN(createdAt), gameType;



--What is the total number of questions in all quizzes hosted in games?
SELECT 
SUM(totalquestionsinquiz) AS Grand_total_no_of_ques 
FROM game_table;



--What is the average number of questions per quiz?
SELECT ROUND(AVG(totalquestionsinquiz),1) AS avg_ques_per_quiz FROM
(
SELECT DISTINCT quizid, totalquestionsinquiz
FROM game_table
)



--How many unique users have both created quizzes and hosted games?
SELECT COUNT (DISTINCT createdBy)
FROM quiz_table qt
INNER JOIN game_table gt ON qt.quizId = gt.quizId
	


--What is the distribution of quiz creation by hour of the day?
SELECT TO_CHAR(createdAt, 'HH24') AS creation_hour,
       COUNT(*) AS num_quiz
FROM quiz_table
GROUP BY TO_CHAR(quiz_table.createdAt, 'HH24')
ORDER BY TO_CHAR(quiz_table.createdAt, 'HH24')



--How many quizzes were created by users who registered in each month?
SELECT TO_CHAR(createdat, 'MON') AS c_month,
		EXTRACT (YEAR FROM createdat) AS c_YEAR,
		COUNT(*) as cc
		FROM quiz_table
		GROUP BY c_month, c_year
		ORDER BY cc DEsc, c_year, c_month;
		

--What is the average duration between user registration and quiz creation?
SELECT AVG(quiz_reg - user_reg)
FROM
(
SELECT userid, ut.createdat as user_reg, MIN(qt.createdat) as quiz_reg
FROM user_table ut
INNER JOIN quiz_table qt ON ut.userid = qt.createdby
GROUP BY userid
)	
	

--How many quizzes have been duplicated from other users?
SELECT COUNT(*) AS total_duplicated_quizzes
FROM quiz_table
WHERE cloned = true;


--What are the top 5 most common languages used for quiz creation?
SELECT lang, COUNT(lang) AS no_of_quiz_per_lang
FROM quiz_table
GROUP BY lang
ORDER BY no_of_quiz_per_lang DESC
LIMIT 5;


--What is the average number of players per game for each game type?
SELECT gameType, ROUND(AVG(totalPlayers),2) AS avg_players_per_game
FROM game_table
GROUP BY gameType
ORDER BY avg_players_per_game DESC;


--How many quizzes have been hosted as live games and have more than 100 total players?
SELECT COUNT(*) AS quizzes_hosted_as_live_games_with_more_than_100_players
FROM Quiz_table q
JOIN Game_table g ON q.quizId = g.quizId
WHERE g.gameType = 'live' AND g.totalPlayers > 100;


--What is the distribution of user registration over time?
SELECT
    EXTRACT(MONTH, createdAt) AS registration_month,
    COUNT(*) AS total_registrations
FROM
    user_table
GROUP BY
    registration_month
ORDER BY
    registration_month;


--

 

