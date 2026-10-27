#!/bin/bash

echo "========================================================"
echo " Запуск системы онлайн-мониторинга электродвигателей ДНС "
echo "========================================================"
echo ""

# Проверка наличия Python
if command -v python3 &>/dev/null; then
    PY_CMD=python3
elif command -v python &>/dev/null; then
    PY_CMD=python
else
    echo "[ОШИБКА] Python не найден! Установите Python 3.10+."
    exit 1
fi

# Создание виртуального окружения при первом запуске
if [ ! -d "venv" ]; then
    echo "[1/3] Создание виртуального окружения venv..."
    $PY_CMD -m venv venv
fi

echo "[2/3] Активация окружения и установка библиотек..."
source venv/bin/activate
pip install --upgrade pip > /dev/null
pip install -r requirements.txt

echo "[3/3] Запуск веб-сервера..."
echo "Приложение доступно по адресу: http://127.0.0.1:8000"

# Автооткрытие браузера
if which xdg-open > /dev/null; then
    xdg-open http://127.0.0.1:8000 &
elif which open > /dev/null; then
    open http://127.0.0.1:8000 &
fi

python -m uvicorn app:app --host 127.0.0.1 --port 8000 --reload
