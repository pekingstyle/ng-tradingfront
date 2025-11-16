#!/bin/bash

# npm安装错误自动修复脚本 (Linux/macOS)
# 作者: MiniMax Agent

echo "=========================================="
echo "   npm错误自动修复工具"
echo "=========================================="

echo "🔧 检测npm错误类型..."

# 检查是否存在node_modules
if [ -d "node_modules" ]; then
    echo "⚠️ 发现node_modules目录，正在清理..."
    rm -rf node_modules
fi

# 删除锁定文件
[ -f "package-lock.json" ] && echo "🗑️ 删除package-lock.json" && rm -f package-lock.json
[ -f "pnpm-lock.yaml" ] && echo "🗑️ 删除pnpm-lock.yaml" && rm -f pnpm-lock.yaml
[ -f "yarn.lock" ] && echo "🗑️ 删除yarn.lock" && rm -f yarn.lock

echo ""
echo "🧹 清理npm缓存..."
npm cache clean --force
if [ $? -ne 0 ]; then
    echo "⚠️ npm缓存清理失败，尝试其他方法..."
fi

echo ""
echo "🔄 正在重新安装依赖..."

# 检查包管理器优先级
if command -v pnpm &> /dev/null; then
    PKG_MANAGER="pnpm"
elif command -v yarn &> /dev/null; then
    PKG_MANAGER="yarn"
else
    PKG_MANAGER="npm"
fi

echo "📦 使用$PKG_MANAGER安装依赖..."

case $PKG_MANAGER in
    "pnpm")
        pnpm install
        if [ $? -eq 0 ]; then
            echo "✅ pnpm安装成功！"
            echo ""
            echo "🚀 启动开发模式..."
            pnpm run dev
        else
            echo "❌ pnpm安装失败，尝试yarn..."
            # 安装yarn并重试
            npm install -g yarn
            yarn install
            if [ $? -eq 0 ]; then
                echo "✅ yarn安装成功！"
                echo ""
                echo "🚀 启动开发模式..."
                yarn dev
            else
                echo "❌ yarn安装也失败，请检查网络连接"
                echo "💡 尝试：npm config set registry https://registry.npmmirror.com"
            fi
        fi
        ;;
    "yarn")
        yarn install
        if [ $? -eq 0 ]; then
            echo "✅ yarn安装成功！"
            echo ""
            echo "🚀 启动开发模式..."
            yarn dev
        else
            echo "❌ yarn安装失败，使用npm..."
            npm install
            if [ $? -eq 0 ]; then
                echo "✅ npm安装成功！"
                echo ""
                echo "🚀 启动开发模式..."
                npm run dev
            else
                echo "❌ 所有安装方式都失败了"
                echo "💡 建议检查："
                echo "   1. 网络连接"
                echo "   2. 磁盘空间"
                echo "   3. 权限问题"
                echo "   4. 重启系统后重试"
            fi
        fi
        ;;
    "npm")
        npm install
        if [ $? -eq 0 ]; then
            echo "✅ npm安装成功！"
            echo ""
            echo "🚀 启动开发模式..."
            npm run dev
        else
            echo "❌ npm安装失败！"
            echo "💡 建议尝试以下方案："
            echo "   1. npm config set registry https://registry.npmmirror.com"
            echo "   2. 安装pnpm: npm install -g pnpm"
            echo "   3. 重启系统"
        fi
        ;;
esac

echo ""
echo "📋 安装总结："
echo "- 如需手动操作，请参考：NPM_ERROR_FIX.md"
echo "- 使用Ctrl+C停止开发服务器"
echo "- 使用开发者工具：Ctrl+Shift+I (Windows/Linux) 或 Cmd+Option+I (macOS)"
echo ""
echo "按Enter键退出..."
read
