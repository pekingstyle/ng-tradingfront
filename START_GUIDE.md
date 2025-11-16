# 金融Electron框架 - 启动指南

## 🚀 Windows环境启动方法

### 方法1：使用启动脚本（推荐）
```cmd
# 在项目根目录执行
start.bat
```

### 方法2：命令行启动
```cmd
# 1. 安装依赖
npm install

# 2. 启动开发服务器
npm run dev
```

### 方法3：直接运行构建版本
```cmd
# 1. 构建项目
npm run build

# 2. 运行Electron
npm start
```

## 🔧 环境要求
- Node.js >= 20.0 (你的v22.17.0完全满足)
- Windows 10/11
- npm 或 yarn

## 📱 应用功能
启动成功后，你会看到一个专业的金融应用界面，包含：
- 📊 实时市场数据仪表盘
- 🔔 智能通知中心  
- 🔍 高级搜索功能
- ⚙️ 完整设置管理

## ❓ 故障排除

### 如果遇到"模块找不到"错误
```cmd
npm run clean
npm install
npm run dev
```

### 如果Vite构建失败
确保Node.js版本 >= 20.0
```cmd
node --version
```

## 📞 需要帮助？
查看 `DEVELOPMENT_STATUS.md` 获取最新开发状态
