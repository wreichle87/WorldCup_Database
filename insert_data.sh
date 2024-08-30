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
declare -i COUNT=10
#Read file
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPENENT WINNER_GOALS OPPONENET_GOALS
do
  $COUNT=$(( 1 ))
  #Insert teams into teams table
  echo $YEAR
done
echo $COUNT
