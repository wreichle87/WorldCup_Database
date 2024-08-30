#!/bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#Truncate all tables for testing purposes
echo "$($PSQL "TRUNCATE teams,games;")"
#Read file
shopt -s lastpipe
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  #Insert teams into teams table
  if [[ $WINNER != "winner" ]]
  then
    echo "teams_Insert: $($PSQL "INSERT INTO teams(name) SELECT '$WINNER' WHERE NOT EXISTS (SELECT name FROM teams WHERE name='$WINNER');")"
    echo "teams_Insert: $($PSQL "INSERT INTO teams(name) SELECT '$OPPONENT' WHERE NOT EXISTS (SELECT name FROM teams WHERE name='$OPPONENT');")"
    #GET WINNER_ID
    WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")"
    #echo "Winner_id: $WINNER_ID"
    #GET OPPONENT_ID
    OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")"
    #echo "Opponent_id: $OPPONENT_ID"
    #INSERT INTO GAMES TABLE
    echo "games_Insert: $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")" 
  fi
done
