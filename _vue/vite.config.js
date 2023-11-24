import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from "path";
// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: [
        {
          find: "@assets",
          replacement: path.resolve(__dirname, "src/assets"),
        }
    ]
  },
  server: {
    base: './_vue/',
    stats: 'verbose',
    hot: true,
    open: true,
    proxy: {
      '/': {
        target: 'http://kraski-st.local/',
        secure: false,
        changeOrigin: true
      }
    }
  },
  base: "/_vue/assets/template/vue/",
  build: {
    outDir: 'assets/template/vue/',
    assetsDir: './',
    rollupOptions: {
      output: {
        entryFileNames: 'vue-main.js',
        assetFileNames: (assetInfo) => {
          // assetInfo содержит информацию о ресурсе (например, имя и расширение)
          // Вам нужно вернуть строку с новым именем файла

          // Пример: изменить имена картинок, остальные оставить без изменений
          if (assetInfo.name.endsWith('.css')) {

            return `vue-main[extname]`;
          }

          // Для остальных ресурсов оставляем текущую структуру именования
          return `${assetInfo.name}`;
        },
      },
    },
  },
})
