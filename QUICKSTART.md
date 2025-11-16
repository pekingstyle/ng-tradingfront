# 🚀 快速启动指南

## 方法一：使用一键启动脚本（推荐）

### Windows用户
```bash
# 双击运行或在命令行执行
start.bat
```

### Linux/macOS用户
```bash
# 在项目目录下执行
chmod +x start.sh
./start.sh
```

## 方法二：手动启动

### 1. 安装依赖
```bash
# 推荐使用pnpm（更快）
npm install -g pnpm
pnpm install

# 或使用npm
npm install
```

### 2. 启动开发模式
```bash
npm run dev
```

## 🎯 开发调试要点

### 打开开发者工具
- **Windows/Linux**: `Ctrl+Shift+I` 或 `F12`
- **macOS**: `Cmd+Option+I`

### 主要功能测试
1. **实时数据展示**: 访问仪表板页面，查看高精度数字格式
2. **加密通讯**: 检查网络面板的WebSocket连接
3. **主题管理**: 在控制台测试TopicManagerService
4. **通知中心**: 点击右上角通知按钮
5. **模糊搜索**: 使用全局搜索功能

### 调试建议
- 使用Chrome DevTools调试React组件
- 在控制台查看实时日志
- 监控网络请求和WebSocket连接
- 检查TypeScript类型错误

## 📁 重要文件

| 文件 | 说明 |
|------|------|
| `start.sh` / `start.bat` | 一键启动脚本 |
| `DEVELOPMENT.md` | 详细开发文档 |
| `README.md` | 项目概述 |
| `src/main/main.js` | Electron主进程 |
| `src/renderer/` | React前端代码 |

## 🆘 常见问题

**Q: 依赖安装失败？**
A: 尝试清理重新安装
```bash
npm run clean  # 或删除node_modules文件夹重新安装
```

**Q: 端口被占用？**
A: 修改vite.config.js中的端口配置

**Q: Electron启动失败？**
A: 检查Node.js版本是否为18+

---

💡 **提示**: 首次启动可能需要几分钟安装依赖，后续启动会更快！
