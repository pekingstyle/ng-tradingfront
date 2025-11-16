@echo off
echo 🔍 Electron金融框架启动诊断工具 (Windows版)
echo ====================================================

echo 📋 检查文件结构...

echo.
echo 🗂️ 检查构建文件:

if exist "dist\main\main.js" (
    echo ✅ 主进程文件: dist\main\main.js
) else (
    echo ❌ 主进程文件: dist\main\main.js (缺失)
)

if exist "dist\preload\preload.js" (
    echo ✅ 预加载脚本: dist\preload\preload.js
) else (
    echo ❌ 预加载脚本: dist\preload\preload.js (缺失)
)

if exist "dist\renderer\src\renderer\index.html" (
    echo ✅ HTML文件: dist\renderer\src\renderer\index.html
) else (
    echo ❌ HTML文件: dist\renderer\src\renderer\index.html (缺失)
)

if exist "dist\renderer\assets\main.js" (
    echo ✅ 主脚本: dist\renderer\assets\main.js
) else (
    echo ❌ 主脚本: dist\renderer\assets\main.js (缺失)
)

if exist "dist\renderer\assets\css\index.css" (
    echo ✅ 样式文件: dist\renderer\assets\css\index.css
) else (
    echo ❌ 样式文件: dist\renderer\assets\css\index.css (缺失)
)

echo.
echo 📝 检查HTML文件内容:
if exist "dist\renderer\src\renderer\index.html" (
    echo 📄 HTML文件内容检查 (查找资源路径):
    findstr /n "src=" "dist\renderer\src\renderer\index.html" 2>nul
    findstr /n "href=" "dist\renderer\src\renderer\index.html" 2>nul
) else (
    echo ❌ HTML文件不存在
)

echo.
echo 🔧 检查主进程配置:
if exist "dist\main\main.js" (
    echo 📄 检查文件加载路径:
    findstr /n "loadFile" "dist\main\main.js" 2>nul
) else (
    echo ❌ 主进程文件不存在
)

echo.
echo 🚀 建议的启动方法:
echo 1. 方式一: npm run start
echo 2. 方式二: npm run dev (开发模式)
echo 3. 方式三: node test-startup.js

echo.
echo 💡 如果仍然无法显示内容，请:
echo - 打开浏览器开发者工具查看控制台错误
echo - 检查是否有JavaScript错误
echo - 确认所有资源文件都能正常加载

echo.
pause
