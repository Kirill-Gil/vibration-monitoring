@echo off
chcp 65001 > nul
echo ========================================================
echo  Запуск системы онлайн-мониторинга электродвигателей ДНС
echo ========================================================
echo.

python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ОШИБКА] Python не найден! Установите Python 3.10+ и поставьте галочку "Add Python to PATH".
    pause
    exit /b
)

if not exist venv (
    echo [1/3] Создание виртуального окружения venv...
    python -m venv venv
)

echo [2/3] Активация окружения и установка зависимостей...
call venv\Scripts\activate
python -m pip install --upgrade pip > nul
pip install -r requirements.txt

echo [3/3] Запуск локального веб-сервера...
echo Сервер доступен по адресу: http://127.0.0.1:8000
start http://127.0.0.1:8000
python -m uvicorn app:app --host 127.0.0.1 --port 8000 --reload

pause
