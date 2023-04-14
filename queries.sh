#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "Select sum(winner_goals + opponent_goals) from games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "Select avg(winner_goals) from games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "Select round(avg(winner_goals), 2) from games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "Select avg(winner_goals + opponent_goals) from games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "Select max(winner_goals) from games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "Select count(game_id) from games where winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "Select name from teams left join games on teams.team_id = games.game_id where round='Final' and year=2018 and winner_goals > opponent_goals ")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "Select distinct name from teams left join games on teams.team_id = games.winner_id or teams.team_id = games.opponent_id where year=2014 and round='Eighth-Final' order by name")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "Select distinct name from teams right join games on teams.team_id = games.winner_id order by name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "Select year, name from teams inner join games on teams.team_id = games.game_id where round='Final' order by year, name desc")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "Select name from teams where name like 'Co%'")"