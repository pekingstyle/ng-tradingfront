# 金融行业Electron框架

基于Electron框架的金融行业通用应用框架，专注于实时信息展示、高精度数据处理、安全通讯和智能搜索功能。

## 🚀 快速启动

### Windows环境启动
```cmd
# 方法1：使用启动脚本
start.bat

# 方法2：命令行启动  
npm install
npm run dev
```

详细启动指南：[START_GUIDE.md](START_GUIDE.md)

## ✨ 项目特点

- 📊 **实时数据展示**：支持高性能实时金融数据展示和处理
- 🔔 **智能通知系统**：基于Topic机制的智能通知和事件处理  
- 🔍 **高级搜索功能**：全文搜索和智能跳转功能
- 🛡️ **安全通信**：端到端加密和数字签名验证
- ⚡ **高性能**：优化的渲染性能和内存管理
- 📱 **现代UI**：基于Ant Design的现代化用户界面

## 🛠️ 技术栈

### 核心技术
- **框架**：Electron + React 18 + TypeScript
- **构建工具**：Vite 4.x  
- **UI组件库**：Ant Design 5.x
- **状态管理**：Zustand
- **路由**：React Router 6.x

### 专业功能
- **高精度计算**：decimal.js 10.x
- **WebSocket通信**：Socket.IO 4.x
- **HTTP客户端**：Axios 1.x
- **加密库**：CryptoJS 4.x

## 📁 项目结构

```
src/
├── main/                 # Electron主进程
├── preload/              # Electron预加载脚本  
└── renderer/             # React渲染进程
    ├── components/       # React组件
    ├── pages/            # 应用页面
    ├── store/            # Zustand状态管理
    ├── services/         # 业务服务层
    ├── utils/            # 工具函数
    └── types/            # TypeScript类型定义
```

## 📱 主要功能

### 仪表盘（Dashboard）
实时市场数据展示、风险指标监控、交易统计分析

### 通知中心（Notification Center）  
智能通知规则配置、多种通知方式支持、通知历史管理

### 搜索中心（Search Center）
全文搜索功能、搜索历史记录、智能搜索建议

### 设置中心（Settings）
用户偏好设置、安全配置管理、网络连接配置

## 📚 文档

- [启动指南](START_GUIDE.md) - 详细的启动步骤
- [开发指南](DEVELOPMENT.md) - 开发环境配置
- [开发状态](DEVELOPMENT_STATUS.md) - 最新开发状态

## 📄 许可证

MIT License

## 👨‍💻 作者

MiniMax Agent
