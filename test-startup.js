/**
 * 测试Electron应用启动
 * 用于检查主进程和渲染进程是否正常工作
 */

const { spawn } = require('child_process');
const path = require('path');

console.log('🧪 测试Electron金融框架启动...\n');

// 启动Electron应用
const electronProcess = spawn('electron', ['.'], {
  cwd: __dirname,
  stdio: 'inherit',
  env: { ...process.env, NODE_ENV: 'production' }
});

// 监听进程退出
electronProcess.on('exit', (code, signal) => {
  console.log(`\n📴 Electron进程退出，代码: ${code}, 信号: ${signal}`);
  process.exit(code || 0);
});

// 监听未捕获的错误
electronProcess.on('error', (error) => {
  console.error('❌ Electron启动错误:', error);
  process.exit(1);
});

// 处理中断信号
process.on('SIGINT', () => {
  console.log('\n⚡ 收到中断信号，正在关闭Electron...');
  electronProcess.kill('SIGINT');
});

process.on('SIGTERM', () => {
  console.log('\n⚡ 收到终止信号，正在关闭Electron...');
  electronProcess.kill('SIGTERM');
});

console.log('✅ Electron进程已启动');
console.log('💡 如果应用启动正常，您应该能看到金融框架界面');
console.log('💡 如果仍然无法显示内容，请检查：');
console.log('   1. 控制台是否有错误信息');
console.log('   2. 文件路径是否正确');
console.log('   3. 资源文件是否存在');
