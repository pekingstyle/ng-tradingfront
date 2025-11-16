# Vite 配置文件位置修复

## 问题描述
Vite 配置文件 `vite.config.js` 错误地位于 `src/renderer/` 目录下，而不是项目根目录。这导致路径解析出现重复路径的问题。

## 错误信息
```
Could not load C:\Users\afire\Workspace\Electron\financial-electron-framework\src\renderer\src\renderer\types
```

## 修复步骤

### 1. 移动配置文件
将 `vite.config.js` 从 `src/renderer/` 移动到项目根目录：
```bash
mv src/renderer/vite.config.js vite.config.js
```

### 2. 更新路径别名
修正所有路径别名的相对路径，添加 `./` 前缀：
```javascript
resolve: {
  alias: {
    '@': resolve(__dirname, './src/renderer'),
    '@components': resolve(__dirname, './src/renderer/components'),
    '@pages': resolve(__dirname, './src/renderer/pages'),
    '@hooks': resolve(__dirname, './src/renderer/hooks'),
    '@utils': resolve(__dirname, './src/renderer/utils'),
    '@services': resolve(__dirname, './src/renderer/services'),
    '@store': resolve(__dirname, './src/renderer/store'),
    '@types': resolve(__dirname, './src/renderer/types')
  }
}
```

### 3. 更新输入文件路径
修正 renderer 构建的输入文件路径：
```javascript
rollupOptions: {
  input: resolve(__dirname, './src/renderer/index.html'),
  // ...
}
```

## 修复结果
- Vite 现在能正确解析 `@types` 别名到 `src/renderer/types` 目录
- 路径重复问题已解决
- `TopicDataType` 等类型导入应该能正常工作

## 测试
运行 `npm run dev` 验证修复是否成功。