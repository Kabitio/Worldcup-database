#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#Empty the tables and reset serial columns
echo $($PSQL "Truncate teams, games restart identity")
#Read games.csv and while loop
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $WINNER != winner ]]
then
  WINNER_ID=$($PSQL "Select team_id from teams where name='$WINNER'")
  OPPONENT_ID=$($PSQL "Select team_id from teams where name='$OPPONENT'")
  if [[ -z $WINNER_ID ]]
  then
    echo $($PSQL "Insert into teams(name) values('$WINNER')")
  fi
  if [[ -z $OPPONENT_ID ]]
  then
    echo $($PSQL "Insert into teams(name) values('$OPPONENT')")
  fi
WINNER_ID=$($PSQL "Select team_id from teams where name='$WINNER'")
OPPONENT_ID=$($PSQL "Select team_id from teams where name='$OPPONENT'")
echo $($PSQL "Insert into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
fi
done