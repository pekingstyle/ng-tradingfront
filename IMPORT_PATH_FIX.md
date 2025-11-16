# 导入路径修复

## 问题
`TopicDataType` 无法从 `src/renderer/types/index.ts` 导入

## 解决方案
修改了 `TopicManagerService.ts` 的导入路径：
- 从：`'../types'` 
- 到：`'@types'`

这使用了 Vite 配置中定义的别名。

## 修复的文件
- `src/renderer/services/TopicManagerService.ts` (第15行)

## 下一步
请重新运行构建命令：
```cmd
npm run build
```
或
```cmd
npm run dev
```

这个修复应该能解决类型导入问题。
