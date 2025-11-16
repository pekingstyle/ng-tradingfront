@echo off

REM npm Error Fix Script (English Version)
REM Author: MiniMax Agent

echo ==========================================
echo   npm Error Auto-Fix Tool
echo ==========================================

echo Detecting npm error...

REM Clean up existing files
if exist "node_modules" (
    echo Removing node_modules...
    rmdir /s /q node_modules
)

if exist "package-lock.json" (
    echo Removing package-lock.json...
    del package-lock.json
)

if exist "pnpm-lock.yaml" (
    echo Removing pnpm-lock.yaml...
    del pnpm-lock.yaml
)

if exist "yarn.lock" (
    echo Removing yarn.lock...
    del yarn.lock
)

echo.
echo Cleaning npm cache...
npm cache clean --force

echo.
echo Reinstalling dependencies...

REM Try pnpm first
pnpm --version >nul 2>&1
if errorlevel 1 (
    echo Installing pnpm...
    npm install -g pnpm
    if errorlevel 1 (
        echo pnpm installation failed, trying yarn...
        goto try_yarn
    )
) else (
    goto install_pnpm
)

:try_yarn
yarn --version >nul 2>&1
if errorlevel 1 (
    echo Installing yarn...
    npm install -g yarn
    if errorlevel 1 (
        echo yarn installation failed, using npm...
        goto install_npm
    )
) else (
    goto install_yarn
)

:install_pnpm
echo Installing dependencies with pnpm...
pnpm install
if errorlevel 1 (
    echo pnpm failed, trying yarn...
    goto try_yarn
) else (
    echo pnpm installation successful!
    echo.
    echo Starting development mode...
    pnpm run dev
    pause
    goto end
)

:install_yarn
echo Installing dependencies with yarn...
yarn install
if errorlevel 1 (
    echo yarn failed, using npm...
    goto install_npm
) else (
    echo yarn installation successful!
    echo.
    echo Starting development mode...
    yarn dev
    pause
    goto end
)

:install_npm
echo Installing dependencies with npm...
npm install
if errorlevel 1 (
    echo npm installation failed!
    echo.
    echo Please try:
    echo 1. Restart computer and run this script again
    echo 2. Run Command Prompt as Administrator
    echo 3. Check network connection and firewall settings
    echo 4. Use Chinese mirror: npm config set registry https://registry.npmmirror.com
    pause
    goto end
) else (
    echo npm installation successful!
    echo.
    echo Starting development mode...
    npm run dev
    pause
)

:end
echo.
echo Installation Summary:
echo - For manual troubleshooting, see: NPM_ERROR_FIX.md
echo - Use Ctrl+C to stop development server
echo - Use Developer Tools: Ctrl+Shift+I
echo.
pause
