#!/bin/bash

# 金融Electron框架快速启动脚本
# 作者: MiniMax Agent
# 版本: 1.0.0

echo "=========================================="
echo "  金融Electron框架 - 快速启动"
echo "=========================================="

# 检查Node.js版本
echo "📋 检查系统环境..."

if ! command -v node &> /dev/null; then
    echo "❌ Node.js 未安装！"
    echo "请访问 https://nodejs.org/ 下载并安装Node.js 18+"
    exit 1
fi

NODE_VERSION=$(node --version | cut -c2-)
REQUIRED_VERSION="18.0.0"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$NODE_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo "❌ Node.js版本过低！当前版本: $NODE_VERSION, 要求: $REQUIRED_VERSION+"
    exit 1
fi

echo "✅ Node.js版本检查通过: $NODE_VERSION"

# 检查npm/pnpm
if command -v pnpm &> /dev/null; then
    PACKAGE_MANAGER="pnpm"
    echo "✅ 使用pnpm包管理器"
elif command -v npm &> /dev/null; then
    PACKAGE_MANAGER="npm"
    echo "✅ 使用npm包管理器"
else
    echo "❌ 未找到包管理器！"
    exit 1
fi

# 检查依赖
echo ""
echo "📦 检查项目依赖..."

if [ ! -d "node_modules" ]; then
    echo "🔧 首次运行，正在安装依赖..."
    if [ "$PACKAGE_MANAGER" = "pnpm" ]; then
        pnpm install
    else
        npm install
    fi
    if [ $? -ne 0 ]; then
        echo "❌ 依赖安装失败！"
        exit 1
    fi
    echo "✅ 依赖安装完成"
else
    echo "✅ 依赖已存在"
fi

# TypeScript类型检查
echo ""
echo "🔍 运行TypeScript类型检查..."
if [ "$PACKAGE_MANAGER" = "pnpm" ]; then
    pnpm run type-check
else
    npm run type-check
fi

# 选择运行模式
echo ""
echo "=========================================="
echo "  选择启动模式："
echo "=========================================="
echo "1. 开发模式 (推荐) - 热重载调试"
echo "2. 生产构建 - 创建可执行文件"
echo "3. 代码检查 - ESLint + TypeScript"
echo "4. 运行测试 - 单元测试"
echo "5. 清理项目 - 重新安装依赖"
echo "6. 打开文档 - 显示帮助信息"
echo "0. 退出"
echo "=========================================="

read -p "请选择操作 [1-6, 0]: " choice

case $choice in
    1)
        echo ""
        echo "🚀 启动开发模式..."
        echo "启动完成后，Electron窗口将自动打开"
        echo "使用 Ctrl+Shift+I 打开开发者工具"
        echo "按 Ctrl+C 停止开发服务器"
        echo ""
        
        if [ "$PACKAGE_MANAGER" = "pnpm" ]; then
            pnpm run dev
        else
            npm run dev
        fi
        ;;
    2)
        echo ""
        echo "🏗️  开始构建生产版本..."
        
        if [ "$PACKAGE_MANAGER" = "pnpm" ]; then
            pnpm run build && pnpm run package
        else
            npm run build && npm run package
        fi
        
        echo "✅ 构建完成！可执行文件位于 dist/ 目录"
        ;;
    3)
        echo ""
        echo "🔍 运行代码检查..."
        
        if [ "$PACKAGE_MANAGER" = "pnpm" ]; then
            pnpm run lint && pnpm run type-check
        else
            npm run lint && npm run type-check
        fi
        
        echo "✅ 代码检查完成"
        ;;
    4)
        echo ""
        echo "🧪 运行测试套件..."
        
        if [ "$PACKAGE_MANAGER" = "pnpm" ]; then
            pnpm run test
        else
            npm run test
        fi
        
        echo "✅ 测试完成"
        ;;
    5)
        echo ""
        echo "🧹 清理项目..."
        echo "这将删除 node_modules 和锁定文件，重新安装依赖"
        
        read -p "确认清理？[y/N]: " confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            rm -rf node_modules
            
            if [ "$PACKAGE_MANAGER" = "pnpm" ]; then
                rm -f pnpm-lock.yaml
                pnpm install
            else
                rm -f package-lock.json
                npm install
            fi
            
            echo "✅ 清理完成，依赖已重新安装"
        else
            echo "❌ 清理已取消"
        fi
        ;;
    6)
        echo ""
        echo "📚 项目文档："
        echo ""
        echo "📖 开发指南: DEVELOPMENT.md"
        echo "📋 项目说明: README.md"
        echo "🏗️ 技术架构: docs/technical-architecture.md"
        echo ""
        echo "🌐 主要功能："
        echo "  • 实时数据展示 - 高精度数字格式化和千分位"
        echo "  • 加密通讯 - AES+RSA+ECDSA多层加密"
        echo "  • 主题管理 - 事件注册和消费确认"
        echo "  • 通知中心 - 全局消息提醒"
        echo "  • 模糊搜索 - 智能导航和参数传递"
        echo ""
        echo "📞 技术支持: MiniMax Agent"
        ;;
    0)
        echo "👋 再见！"
        exit 0
        ;;
    *)
        echo "❌ 无效选择！请重新运行脚本"
        exit 1
        ;;
esac
