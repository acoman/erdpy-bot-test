# You must edit the values of MYWALLET and PEM_FILE
# and then modify the TRANSACTIONS list.
#SMART CONTRACT QoWATT - erd1qqqqqqqqqqqqqpgq7dcgyej6vr8ex6u545kq58yh3nsa3t8c83gqu7aj3c

MYWALLET="erd14............."
PEM_FILE="./bots/wallet-bot1.pem"

declare -a TRANSACTIONS=(
  "erd1qqqqqqqqqqqqqpgq7dcgyej6vr8ex6u545kq58yh3nsa3t8c83gqu7aj3c 25920000000000000000"
)

# DO NOT MODIFY ANYTHING FROM HERE ON
PROXY="https://gateway.elrond.com"

# We recall the nonce of the wallet
NONCE=$(erdpy account get --nonce --address="$MYWALLET" --proxy="$PROXY")

function send-bulk-tx {
  for transaction in "${TRANSACTIONS[@]}"; do
    set -- $transaction
    erdpy --verbose tx new --send --outfile="bon-mission-tx-$NONCE.json" --pem=$PEM_FILE --nonce=$NONCE --receiver=$1 --data 'buy_pack_diamant' --value="$2" --gas-limit=10000000 --proxy=$PROXY
    echo "Transaction sent with nonce $NONCE and backed up to bon-mission-tx-$NONCE.json."
    (( NONCE++ ))
  done
}

send-bulk-tx
