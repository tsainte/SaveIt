#!/bin/bash

# fetchAPIs: use this script to fetch responses from the banking APIs.
# It can be useful for create stubs for your unit tests! :)
# Right not it is saving under the test folders.

# How to use:
# ./fetchAPIs.sh -starling_token <<starling_token>> -monzo_token <<monzo_token>> -monzo_account <<monzo_account_id>>

# Have fun! 👋

### Functions

# Fetch starling account, balance and transactions by given valid token. No account id needed.
function fetch_starling {
  echo -e "\nFetching Starling account & details... 🚀"

  curl -X GET -H "Content-type: application/json" -H "Authorization: Bearer $starling_token" \
   -o "$base_output_dir/Starling/StarlingAccount.json" "https://api.starlingbank.com/api/v1/accounts" \
   -o "$base_output_dir/Starling/StarlingBalance.json" "https://api.starlingbank.com/api/v1/accounts/balance" \
   -o "$base_output_dir/Starling/StarlingTransactions.json" "https://api.starlingbank.com/api/v1/transactions"
}

# Fetch monzo account, balance and transactions by given valid token and account id.
function fetch_monzo {
  echo -e "\nFetching Monzo account... 🚀"

  curl -X GET -H "Content-type: application/json" -H "Authorization: Bearer $monzo_token" \
   -o "$base_output_dir/Monzo/MonzoAccount.json" "https://api.monzo.com/accounts"

   if [ -n "$monzo_account" ]
   then
     echo -e "\nFetching Monzo details... 🚀"

     curl -X GET -H "Content-type: application/json" -H "Authorization: Bearer $monzo_token" \
     -o "$base_output_dir/Monzo/MonzoBalance.json" "https://api.monzo.com/balance?account_id=$monzo_account" \
     -o "$base_output_dir/Monzo/MonzoTransactions.json" "https://api.monzo.com/transactions?account_id=$monzo_account"
   fi
}

### MAIN

# Variables
base_output_dir="../SaveItTests/Mocks"

# Getting token variables

while test $# -gt 0; do
         case "$1" in
              -starling_token)
                  shift
                  starling_token=$1
                  shift
                  ;;
              -monzo_token)
                  shift
                  monzo_token=$1
                  shift
                  ;;
              -monzo_account)
                  shift
                  monzo_account=$1
                  shift
                  ;;
              *)
                 echo "$1 is not a recognized flag!"
                 return 1;
                 ;;
        esac
done

if [ -n "$starling_token" ] # if lenght of string is greater than zero
then
  fetch_starling
fi

if [ -n "$monzo_token" ] # if lenght of string is greater than zero
then
  fetch_monzo
fi
