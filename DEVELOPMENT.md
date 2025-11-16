# 金融Electron框架 - 本地开发调试指南

## 环境要求

### 系统要求
- **操作系统**: Windows 10/11, macOS 10.14+, 或 Ubuntu 18.04+
- **Node.js**: 版本 18.0.0 或更高
- **npm**: 版本 8.0.0 或更高（或使用 pnpm/yarn）

### 安装Node.js
如果尚未安装Node.js，请访问 [Node.js官网](https://nodejs.org/) 下载并安装最新LTS版本。

验证安装：
```bash
node --version  # 应显示 v18.x.x 或更高
npm --version   # 应显示 8.x.x 或更高
```

## 快速开始

### 1. 进入项目目录
```bash
cd financial-electron-framework
```

### 2. 安装项目依赖
**推荐使用 pnpm**（更快更节省空间）：
```bash
npm install -g pnpm
pnpm install
```

**或使用 npm**：
```bash
npm install
```

### 3. 启动开发模式
```bash
npm run dev
```

这个命令会：
- 启动React开发服务器（端口5173）
- 同时启动Electron应用
- 支持热重载，代码修改后会自动刷新

## 开发模式详解

### 开发命令说明

| 命令 | 说明 |
|------|------|
| `npm run dev` | 启动完整的开发环境（推荐） |
| `npm run dev:react` | 仅启动React开发服务器 |
| `npm run dev:electron` | 仅启动Electron应用 |

### 开发模式特性
- **热重载**: 修改React组件代码后自动刷新
- **快速启动**: 通常5-10秒内完成启动
- **调试支持**: 支持Chrome DevTools
- **实时编译**: TypeScript类型检查

## 调试方法

### 1. 打开开发者工具
在Electron应用中：
- **Windows/Linux**: `Ctrl+Shift+I` 或 `F12`
- **macOS**: `Cmd+Option+I`

### 2. 调试React组件
在开发者工具中：
- 使用 `Elements` 面板检查DOM结构
- 使用 `Console` 面板查看日志和错误
- 使用 `Network` 面板监控网络请求
- 使用 `Sources` 面板调试JavaScript代码

### 3. 调试主进程代码
在主进程代码中添加调试日志：
```javascript
// 在 src/main/main.js 中
console.log('主进程调试信息');
```

### 4. 调试渲染进程代码
```typescript
// 在React组件中
useEffect(() => {
  console.log('组件已挂载');
}, []);
```

## 生产构建

### 1. 构建项目
```bash
npm run build
```

这会执行：
- 构建React应用
- 打包Electron应用

### 2. 创建安装包
```bash
# 创建生产版本安装包
npm run package

# 或构建并打包为可执行文件
npm run dist
```

### 3. 构建输出
构建完成后，在 `dist/` 目录下会生成：
- **Windows**: `金融框架 Setup x.x.x.exe`
- **macOS**: `金融框架-x.x.x.dmg`
- **Linux**: `金融框架-x.x.x.AppImage`

## 代码规范和检查

### 1. 代码检查
```bash
# 检查代码规范
npm run lint

# 自动修复代码格式问题
npm run lint:fix

# TypeScript类型检查
npm run type-check
```

### 2. 测试
```bash
# 运行单元测试
npm run test

# 运行端到端测试
npm run test:e2e
```

## 项目结构说明

```
financial-electron-framework/
├── src/
│   ├── main/           # Electron主进程
│   │   └── main.js     # 主进程入口
│   ├── preload/        # 预加载脚本
│   │   └── preload.js  # 安全IPC桥梁
│   └── renderer/       # 渲染进程（React应用）
│       ├── components/ # React组件
│       ├── pages/      # 页面组件
│       ├── services/   # 业务服务
│       ├── store/      # 状态管理
│       ├── utils/      # 工具函数
│       └── assets/     # 静态资源
├── assets/             # 应用程序资源
└── docs/              # 项目文档
```

## 常见问题解决

### 1. 依赖安装失败
```bash
# 清理并重新安装
npm run clean
rm -rf node_modules package-lock.json
npm install
```

### 2. 端口冲突
如果5173端口被占用，可以修改配置：
```javascript
// src/renderer/vite.config.js
export default defineConfig({
  server: {
    port: 3000  // 改为其他端口
  }
})
```

### 3. Electron启动失败
检查Node.js版本：
```bash
node --version
```

### 4. TypeScript编译错误
重新安装TypeScript依赖：
```bash
npm install --save-dev typescript @types/node
```

## 开发建议

### 1. 性能优化
- 使用React DevTools Profiler分析组件性能
- 避免在渲染过程中执行昂贵计算
- 使用React.memo优化重复渲染

### 2. 内存管理
- 及时清理定时器和事件监听器
- 在组件卸载时清理资源

### 3. 安全性
- 使用contextBridge安全暴露API
- 验证所有IPC通信数据
- 避免在渲染进程中使用Node.js API

## 部署指南

### 1. 代码签名（生产环境）
为避免操作系统安全警告，建议进行代码签名：

**Windows**:
```bash
# 设置环境变量
set CSC_NAME=your_certificate_name
npm run package
```

**macOS**:
```bash
# 设置环境变量
export CSC_NAME="Developer ID Application: Your Name"
npm run package
```

### 2. 自动更新
可以使用electron-updater实现自动更新功能。

## 技术支持

如果遇到问题，请检查：
1. Node.js版本是否符合要求
2. 所有依赖是否正确安装
3. 操作系统是否支持
4. 防火墙是否阻止了网络连接

---

**最后更新**: 2025-11-15  
**作者**: MiniMax Agent  
**版本**: v1.0.0
