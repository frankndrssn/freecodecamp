#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

GAME_LOOP() {
  if [[ $1 ]]
  then
    echo -e "$1"
  else
    echo "Guess the secret number between 1 and 1000:"
  fi
  read INPUT
  GUESSES=$(($GUESSES + 1))
  # if input is not number
  if [[ ! $INPUT =~ ^[0-9]+$ ]]
  then
    GAME_LOOP "That is not an integer, guess again:"
  else
    # if input is too high
    if (( $INPUT > $SECRET ))
    then
      GAME_LOOP "It's lower than that, guess again:"
    elif (( $INPUT < $SECRET ))
    then
      GAME_LOOP "It's higher than that, guess again:"
    else
      # done
      return
    fi
  fi
}

echo "Enter your username:"
read USERNAME

PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE username = '$USERNAME'")
# if not found
if [[ -z $PLAYER_ID ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  # add new player
  _=$($PSQL "INSERT INTO players(username) VALUES('$USERNAME')")
  PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE username = '$USERNAME'")
else
  QUERY_STATS_RESULT="$($PSQL "SELECT COUNT(*), MIN(guesses)
    FROM players
      INNER JOIN games USING(player_id)
    WHERE player_id = $PLAYER_ID")"
  echo "$QUERY_STATS_RESULT" | while IFS="|" read GAMES BEST
  do
    echo -e "\nWelcome back, $USERNAME! You have played $GAMES games, and your best game took $BEST guesses."
  done
fi

SECRET=$(($RANDOM % 1000 + 1))
GUESSES=0
GAME_LOOP
echo "You guessed it in $GUESSES tries. The secret number was $SECRET. Nice job!"
# insert game record into db
_=$($PSQL "INSERT INTO games(player_id, guesses) VALUES($PLAYER_ID, $GUESSES)")