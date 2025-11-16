@echo off
chcp 65001 >nul

REM 金融Electron框架快速启动脚本 (Windows版本)
REM 作者: MiniMax Agent
REM 版本: 1.0.0

echo ==========================================
echo   金融Electron框架 - 快速启动
echo ==========================================

echo 📋 检查系统环境...

REM 检查Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js 未安装！
    echo 请访问 https://nodejs.org/ 下载并安装Node.js 18+
    pause
    exit /b 1
)

echo ✅ Node.js版本: 
node --version

REM 检查包管理器
pnpm --version >nul 2>&1
if errorlevel 1 (
    set PACKAGE_MANAGER=npm
    echo ✅ 使用npm包管理器
) else (
    set PACKAGE_MANAGER=pnpm
    echo ✅ 使用pnpm包管理器
)

REM 检查依赖
echo.
echo 📦 检查项目依赖...

if not exist "node_modules" (
    echo 🔧 首次运行，正在安装依赖...
    if "%PACKAGE_MANAGER%"=="pnpm" (
        pnpm install
    ) else (
        npm install
    )
    if errorlevel 1 (
        echo ❌ 依赖安装失败！
        pause
        exit /b 1
    )
    echo ✅ 依赖安装完成
) else (
    echo ✅ 依赖已存在
)

REM TypeScript类型检查
echo.
echo 🔍 运行TypeScript类型检查...
if "%PACKAGE_MANAGER%"=="pnpm" (
    pnpm run type-check
) else (
    npm run type-check
)

REM 选择运行模式
echo.
echo ==========================================
echo   选择启动模式：
echo ==========================================
echo 1. 开发模式 ^(推荐^) - 热重载调试
echo 2. 生产构建 - 创建可执行文件
echo 3. 代码检查 - ESLint + TypeScript
echo 4. 运行测试 - 单元测试
echo 5. 清理项目 - 重新安装依赖
echo 6. 打开文档 - 显示帮助信息
echo 0. 退出
echo ==========================================

set /p choice="请选择操作 [1-6, 0]: "

if "%choice%"=="1" goto dev_mode
if "%choice%"=="2" goto build_mode
if "%choice%"=="3" goto lint_mode
if "%choice%"=="4" goto test_mode
if "%choice%"=="5" goto clean_mode
if "%choice%"=="6" goto help_mode
if "%choice%"=="0" goto exit
echo ❌ 无效选择！请重新运行脚本
pause
exit /b 1

:dev_mode
echo.
echo 🚀 启动开发模式...
echo 启动完成后，Electron窗口将自动打开
echo 使用 Ctrl+Shift+I 打开开发者工具
echo 按 Ctrl+C 停止开发服务器
echo.
if "%PACKAGE_MANAGER%"=="pnpm" (
    pnpm run dev
) else (
    npm run dev
)
pause
goto end

:build_mode
echo.
echo 🏗️ 开始构建生产版本...
if "%PACKAGE_MANAGER%"=="pnpm" (
    pnpm run build && pnpm run package
) else (
    npm run build && npm run package
)
echo ✅ 构建完成！可执行文件位于 dist\ 目录
pause
goto end

:lint_mode
echo.
echo 🔍 运行代码检查...
if "%PACKAGE_MANAGER%"=="pnpm" (
    pnpm run lint && pnpm run type-check
) else (
    npm run lint && npm run type-check
)
echo ✅ 代码检查完成
pause
goto end

:test_mode
echo.
echo 🧪 运行测试套件...
if "%PACKAGE_MANAGER%"=="pnpm" (
    pnpm run test
) else (
    npm run test
)
echo ✅ 测试完成
pause
goto end

:clean_mode
echo.
echo 🧹 清理项目...
echo 这将删除 node_modules 和锁定文件，重新安装依赖
set /p confirm="确认清理？[y/N]: "
if /i "%confirm%"=="y" (
    if exist node_modules rmdir /s /q node_modules
    
    if "%PACKAGE_MANAGER%"=="pnpm" (
        if exist pnpm-lock.yaml del pnpm-lock.yaml
        pnpm install
    ) else (
        if exist package-lock.json del package-lock.json
        npm install
    )
    
    echo ✅ 清理完成，依赖已重新安装
) else (
    echo ❌ 清理已取消
)
pause
goto end

:help_mode
echo.
echo 📚 项目文档：
echo.
echo 📖 开发指南: DEVELOPMENT.md
echo 📋 项目说明: README.md
echo 🏗️ 技术架构: docs\technical-architecture.md
echo.
echo 🌐 主要功能：
echo   • 实时数据展示 - 高精度数字格式化和千分位
echo   • 加密通讯 - AES+RSA+ECDSA多层加密
echo   • 主题管理 - 事件注册和消费确认
echo   • 通知中心 - 全局消息提醒
echo   • 模糊搜索 - 智能导航和参数传递
echo.
echo 📞 技术支持: MiniMax Agent
echo.
pause
goto end

:exit
echo 👋 再见！
goto end

:end
