# monitoring_process
Сохранить monitor.sh в /usr/local/bin/

chmod +x /usr/local/bin/monitor_test.sh

Сохранить monitor-test.service в /etc/systemd/system/

Сохранить monitor-test.timer в /etc/systemd/system/

Перезапустить и включить таймер
systemctl daemon-reload
systemctl enable --now monitor-test.timer

Для проверки мониторинга можно запустить ./test &

Убедится что процесс test запущен - pgrep -x test
