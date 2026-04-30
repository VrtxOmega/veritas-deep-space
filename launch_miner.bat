@echo off
cd /d "%~dp0"
echo === VERITAS DEEP SPACE DISCOVERY ENGINE v3.0.0 ===
echo Starting Backend (port 5050)...
start "VERITAS Deep Space Backend" cmd /c "python server.py"

echo Starting Telemetry Dashboard (port 5173)...
cd dashboard
npm run dev -- --open
