@echo off
REM B2B Manual Shipments - Complete Automated Setup
REM This script downloads and installs everything for you

cls
echo.
echo ================================================
echo   B2B MANUAL SHIPMENTS - AUTOMATED SETUP
echo ================================================
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if %errorlevel% neq 0 (
    cls
    echo.
    echo ERROR: Node.js not installed!
    echo.
    echo Please install from: https://nodejs.org/
    echo Click the big green LTS button
    echo.
    pause
    exit /b 1
)

echo Node.js found! Proceeding with setup...
echo.

REM Get current directory
cd /d %~dp0

REM Create the necessary files
echo Creating project files...

REM Create package.json if it doesn't exist
if not exist "package.json" (
    echo Creating package.json...
    (
        echo {
        echo   "name": "b2b-manual-shipments",
        echo   "version": "1.0.0",
        echo   "type": "module",
        echo   "scripts": {
        echo     "install-all": "cd backend ^&^& npm install ^&^& cd .. ^&^& cd frontend ^&^& npm install ^&^& cd ..",
        echo     "dev": "cd frontend ^&^& npm run dev"
        echo   }
        echo }
    ) > package.json
)

REM Create directory structure
if not exist "backend" mkdir backend
if not exist "frontend" mkdir frontend
if not exist "data" mkdir data

echo.
echo Installing all dependencies...
echo This may take 3-5 minutes...
echo.

REM Install backend dependencies
if not exist "backend\node_modules" (
    echo Installing backend dependencies...
    cd backend
    call npm install
    cd ..
)

REM Install frontend dependencies
if not exist "frontend\node_modules" (
    echo Installing frontend dependencies...
    cd frontend
    call npm install
    cd ..
)

cls
echo.
echo ================================================
echo   SETUP COMPLETE!
echo ================================================
echo.
echo Your B2B Manual Shipments dashboard is ready!
echo.
echo To start using it:
echo.
echo Terminal 1 - Start Backend:
echo   cd backend
echo   npm start
echo.
echo Terminal 2 - Start Frontend:
echo   cd frontend
echo   npm run dev
echo.
echo Then open: http://localhost:3000
echo.
echo ================================================
echo.
pause
