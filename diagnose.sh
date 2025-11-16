#!/bin/bash

echo "🔍 Electron金融框架启动诊断工具"
echo "=================================="

# 检查必要文件
echo "📋 检查文件结构..."

files=(
  "dist/main/main.js:主进程文件"
  "dist/preload/preload.js:预加载脚本"
  "dist/renderer/src/renderer/index.html:HTML文件"
  "dist/renderer/assets/main.js:主脚本"
  "dist/renderer/assets/css/index.css:样式文件"
)

echo ""
echo "🗂️  检查构建文件:"
for item in "${files[@]}"; do
  IFS=':' read -r file desc <<< "$item"
  if [ -f "$file" ]; then
    echo "✅ $desc: $file"
  else
    echo "❌ $desc: $file (缺失)"
  fi
done

echo ""
echo "📝 检查HTML文件内容:"
if [ -f "dist/renderer/src/renderer/index.html" ]; then
  echo "📄 HTML文件大小: $(stat -f%z "dist/renderer/src/renderer/index.html" 2>/dev/null || echo "未知")"
  echo "📄 检查资源路径:"
  grep -n "src=" "dist/renderer/src/renderer/index.html" | head -3
  grep -n "href=" "dist/renderer/src/renderer/index.html" | head -3
else
  echo "❌ HTML文件不存在"
fi

echo ""
echo "🔧 检查主进程配置:"
if [ -f "dist/main/main.js" ]; then
  echo "📄 检查文件加载路径:"
  grep -n "loadFile" "dist/main/main.js"
else
  echo "❌ 主进程文件不存在"
fi

echo ""
echo "🚀 建议的启动方法:"
echo "1. 方式一: npm run start"
echo "2. 方式二: npm run dev (开发模式)"
echo "3. 方式三: node test-startup.js"

echo ""
echo "💡 如果仍然无法显示内容，请:"
echo "- 打开浏览器开发者工具查看控制台错误"
echo "- 检查是否有JavaScript错误"
echo "- 确认所有资源文件都能正常加载"
