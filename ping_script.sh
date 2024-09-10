#!/bin/bash


if [ -z "$1" ]; then
  echo "Использование: $0 <адрес>"
  exit 1
fi

ADDRESS=$1
FAILURE_COUNT=0


while true; do
 
  PING_RESULT=$(ping -c 1 -W 1 $ADDRESS | grep 'time=' | awk -F'time=' '{print $2}' | awk -F' ' '{print $1}' | cut -d'=' -f2)

  
  if [ -z "$PING_RESULT" ]; then
    FAILURE_COUNT=$((FAILURE_COUNT + 1))
    echo "Пинг не удался. Не удалось получить ответ от $ADDRESS."
  else
    FAILURE_COUNT=0
   
    if (( $(echo "$PING_RESULT > 100" | bc -l) )); then
      echo "Пинг превысил 100 мс. Время: $PING_RESULT мс"
    else
      echo "Пинг успешен. Время: $PING_RESULT мс"
    fi
  fi


  if [ $FAILURE_COUNT -ge 3 ]; then
    echo "Не удалось выполнить пинг в течение 3 последовательных попыток."
    FAILURE_COUNT=0
  fi

  # Задержка в 1 секунду
  sleep 1
done
