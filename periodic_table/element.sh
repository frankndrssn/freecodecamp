#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# check if the input is a number
if [[ $1 =~ ^[0-9]+$ ]]
then
  # if it is a number, proceed with atomic number by setting CONDITION
  CONDITION="atomic_number = $1"
else
  # else proceed with symbol or name by setting CONDITION
  CONDITION="symbol = '$1' OR name = '$1'"
fi

# query the database
QUERY_RESULT="$($PSQL "SELECT 
  atomic_number, 
  name, 
  symbol, 
  type, 
  atomic_mass, 
  melting_point_celsius, 
  boiling_point_celsius 
  FROM elements
    INNER JOIN properties USING(atomic_number)
    INNER JOIN types USING(type_id)
  WHERE $CONDITION")"
# if the element does not exist, print error message
if [[ -z $QUERY_RESULT ]]
then
  echo "I could not find that element in the database."
else
  # print its properties
  echo "$QUERY_RESULT" | while IFS="|" read NUMBER\
                                            NAME\
                                            SYMBOL\
                                            TYPE\
                                            MASS\
                                            MELTING\
                                            BOILING
  do
    echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  done
fi
