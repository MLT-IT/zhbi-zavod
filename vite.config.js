import { defineConfig } from 'vite'
import path from 'path'
import fs from 'fs'

const SRC_DIR = '_src-vite'
const DIST_DIR = 'dist'
const HOST = 'localhost'
const PORT = 5173
const WATCH_DIR = 'core/elements'

const CSS_FILE_NAME = 'css/[name]-[hash].[ext]'
const ENTRY_FILE_NAME = 'js/[name]-[hash].js'
const CHUNK_FILE_NAME = 'js/[name]-[hash].js'
const ASSETS_PATH = 'assets/[name].[ext]'

const CSS_TEMPLATE = 'core/elements/vite/css.tpl'
const JS_TEMPLATE = 'core/elements/vite/js.tpl'

const entries = {
  main: path.resolve(__dirname, SRC_DIR, 'js/index.js'),
  // groupingTags: path.resolve(__dirname, 'core/elements/modules/groupingTags/scripts/main.js'),
  // preloader: path.resolve(__dirname, SRC_DIR, 'js/preloader.js'),
  // module_filter_table: path.resolve(__dirname, SRC_DIR, 'js/module_filter_table.js')
}

export default defineConfig(() => {
  return {
    base: `/`,
    build: {
      outDir: path.resolve(__dirname, DIST_DIR),
      emptyOutDir: true,
      rollupOptions: {
        input: entries,
        output: {
          entryFileNames: ENTRY_FILE_NAME,
          chunkFileNames: CHUNK_FILE_NAME,
          assetFileNames: (assetInfo) => {
            if (/\.(css)$/.test(assetInfo.name ?? '')) return CSS_FILE_NAME
            return ASSETS_PATH
          }
        }
      }
    },
    resolve: {
      alias: {
        '@': path.resolve(__dirname, SRC_DIR)
      }
    },
    server: {
      host: HOST,
      port: PORT,
      strictPort: true,
      cors: true
    },
    plugins: [
      {
        hotUpdate({ file, server }) {
          if (file.indexOf(WATCH_DIR) > -1) {
            server.ws.send({ type: 'full-reload' })
          }
        }
      },
      {
        generateBundle(options, bundle) {
          const cssFiles = []
          const jsFiles = []

          for (const fileName in bundle) {
            if (fileName.endsWith('.css')) cssFiles.push(fileName)
            if (fileName.endsWith('.js')) jsFiles.push(fileName)
          }

          const cssItems = cssFiles.map((f) => `<link rel="stylesheet" href="/${DIST_DIR}/${f}">`).join('\n')
          const jsItems = jsFiles.map((f) => `<script type="module" src="/${DIST_DIR}/${f}"></script>`).join('\n')

          safeWriteFile(path.resolve(__dirname, CSS_TEMPLATE), cssItems)
          safeWriteFile(path.resolve(__dirname, JS_TEMPLATE), jsItems)
        }
      }
    ]
  }
})

function safeWriteFile(filePath, content) {
  const dir = path.dirname(filePath)
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true })
  if (!fs.existsSync(filePath)) fs.writeFileSync(filePath, '', 'utf-8')
  fs.writeFileSync(filePath, content, 'utf-8')
}
