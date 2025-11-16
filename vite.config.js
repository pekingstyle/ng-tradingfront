import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import electron from 'vite-plugin-electron';
import { resolve } from 'path';

export default defineConfig({
  plugins: [
    react(),
    electron([
      {
        entry: 'src/main/main.js',
        onstart(options) {
          options.reloadWindow();
        },
        vite: {
          build: {
            outDir: 'dist/main',
            emptyOutDir: false,
            rollupOptions: {
              external: ['electron']
            }
          }
        }
      },
      {
        entry: 'src/preload/preload.js',
        onstart(options) {
          options.reloadWindow();
        },
        vite: {
          build: {
            outDir: 'dist/preload',
            emptyOutDir: false,
            rollupOptions: {
              external: ['electron']
            }
          }
        }
      }
    ])
  ],
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
  },
  build: {
    outDir: 'dist/renderer',
    emptyOutDir: false,
    sourcemap: true,
    minify: 'terser',
    rollupOptions: {
      input: {
        main: resolve(__dirname, './src/renderer/index.html')
      },
      output: {
        entryFileNames: 'assets/[name].js',
        chunkFileNames: 'assets/[name].js',
        assetFileNames: 'assets/[ext]/[name].[ext]'
      }
    }
  },
  server: {
    port: 5173,
    strictPort: true,
    hmr: {
      host: 'localhost',
      port: 5173
    }
  },
  optimizeDeps: {
    include: [
      'react',
      'react-dom',
      'react-router-dom',
      'antd',
      '@ant-design/icons',
      'zustand',
      'decimal.js',
      'socket.io-client',
      'axios',
      'lodash',
      'crypto-js',
      'uuid',
      'dayjs'
    ]
  },
  define: {
    // 为前端代码暴露环境变量
    __APP_VERSION__: JSON.stringify(process.env.npm_package_version),
    __BUILD_TIME__: JSON.stringify(new Date().toISOString())
  }
});