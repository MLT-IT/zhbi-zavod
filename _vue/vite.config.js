import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],

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
  build: {
    outDir: 'assets/template/vue/',
    assetsDir: './',
    rollupOptions: {
      output: {
        entryFileNames: 'vue-main.js',
        assetFileNames: "vue-main.[ext]",
      },
    },
  },
})
