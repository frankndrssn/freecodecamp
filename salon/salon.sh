#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --csv --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  # get service menu
  SERVICES="$($PSQL "SELECT * FROM services ORDER BY service_id")"
  echo "$SERVICES" | while IFS="," read SERVICE_ID SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  read SERVICE_ID_SELECTED
  
  # if [[ ! $SERVICE_ID_SELECTED =~ [0-9]+ ]]
  # then
  #   MAIN "Not offered"
  # fi

  # check if the service exists
  SERVICE_NAME=$($PSQL "SELECT name FROM services 
    WHERE service_id = $SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_NAME ]]
  then
    MAIN "I could not find that service. What would you like today?"
  else
    # selected service is available, get customer phone number
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    # check if this customer already exists
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers 
      WHERE phone = '$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER_ID ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      # add new customer to db
      NEW_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) 
        VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers 
        WHERE phone = '$CUSTOMER_PHONE'")
    else
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers
        WHERE customer_id = $CUSTOMER_ID")
    fi

    # customer now in db, ask for time
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME

    # add entry to db
    NEW_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) 
      VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

MAIN