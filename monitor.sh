#!/bin/bash

PROCESS_NAME="test"
LOG_FILE="/var/log/monitoring.log"
MONITOR_URL="https://test.com/monitoring/test/api"

# Проверяем, запущен ли процесс
if pgrep -x "$PROCESS_NAME" > /dev/null; then
    PREV_PID_FILE="var/tmp/${PROCESS_NAME}_pid"
    CURRENT_PID=$(pgrep -x "$PROCESS_NAME" | head -n 1)

    if [[ -f "$PREV_PID_FILE" ]]; then
        PREV_PID=$(cat "$PREV_PID_FILE")
        if [[ "$CURRENT_PID" != "$PREV_PID" ]]; then
            echo "$(date) - Процесс $PROCESS_NAME был перезапущен (PID: $CURRENT_PID)" >> "$LOG_FILE"
        fi
    fi
    echo "$CURRENT_PID" > "$PREV_PID_FILE"

    # Отправляем запрос на сервер мониторинга
    if ! curl -s --connect-timeout 5 -X POST "$MONITOR_URL"; then
        echo "$(date) - Ошибка: сервер мониторинга недоступен" >> "$LOG_FILE"
    fi
fi
