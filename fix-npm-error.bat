@echo off
chcp 65001 >nul

REM npm安装错误自动修复脚本 (Windows)
REM 作者: MiniMax Agent

echo ==========================================
echo   npm错误自动修复工具
echo ==========================================

echo 🔧 检测npm错误类型...

REM 检查是否存在node_modules
if exist "node_modules" (
    echo ⚠️ 发现node_modules目录，正在清理...
    rmdir /s /q node_modules
)

REM 删除锁定文件
if exist "package-lock.json" (
    echo 🗑️ 删除package-lock.json
    del package-lock.json
)

if exist "pnpm-lock.yaml" (
    echo 🗑️ 删除pnpm-lock.yaml
    del pnpm-lock.yaml
)

if exist "yarn.lock" (
    echo 🗑️ 删除yarn.lock
    del yarn.lock
)

echo.
echo 🧹 清理npm缓存...
npm cache clean --force
if errorlevel 1 (
    echo ⚠️ npm缓存清理失败，尝试其他方法...
)

echo.
echo 🔄 正在重新安装依赖...

REM 尝试使用pnpm（推荐）
echo 📦 尝试使用pnpm安装...
pnpm --version >nul 2>&1
if errorlevel 1 (
    echo 📥 安装pnpm...
    npm install -g pnpm
    if errorlevel 1 (
        echo ❌ pnpm安装失败，尝试yarn...
        goto try_yarn
    )
) else (
    goto install_with_pnpm
)

:try_yarn
echo 📦 尝试使用yarn安装...
yarn --version >nul 2>&1
if errorlevel 1 (
    echo 📥 安装yarn...
    npm install -g yarn
    if errorlevel 1 (
        echo ❌ yarn安装失败，使用npm...
        goto install_with_npm
    )
) else (
    goto install_with_yarn
)

:install_with_pnpm
echo ✅ 使用pnpm安装依赖...
pnpm install
if errorlevel 1 (
    echo ❌ pnpm安装失败，尝试yarn...
    goto try_yarn
) else (
    echo ✅ pnpm安装成功！
    echo.
    echo 🚀 启动开发模式...
    pnpm run dev
    pause
    goto end
)

:install_with_yarn
echo ✅ 使用yarn安装依赖...
yarn install
if errorlevel 1 (
    echo ❌ yarn安装失败，使用npm...
    goto install_with_npm
) else (
    echo ✅ yarn安装成功！
    echo.
    echo 🚀 启动开发模式...
    yarn dev
    pause
    goto end
)

:install_with_npm
echo ✅ 使用npm安装依赖...
npm install
if errorlevel 1 (
    echo ❌ npm安装失败！
    echo.
    echo 💡 请尝试以下方案：
    echo 1. 重启电脑后重新运行此脚本
    echo 2. 以管理员身份运行命令提示符
    echo 3. 检查网络连接和防火墙设置
    echo 4. 使用国内镜像源：npm config set registry https://registry.npmmirror.com
    pause
    goto end
) else (
    echo ✅ npm安装成功！
    echo.
    echo 🚀 启动开发模式...
    npm run dev
    pause
)

:end
echo.
echo 📋 安装总结：
echo - 如需手动操作，请参考：NPM_ERROR_FIX.md
echo - 使用Ctrl+C停止开发服务器
echo - 使用开发者工具：Ctrl+Shift+I
echo.
pause
