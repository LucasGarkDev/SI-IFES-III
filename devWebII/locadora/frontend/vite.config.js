import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import viteImagemin from 'vite-plugin-imagemin' // otimização de imagens

export default defineConfig({
  plugins: [
    react(),
    viteImagemin({
      gifsicle: { optimizationLevel: 7, interlaced: false },
      optipng: { optimizationLevel: 7 },
      mozjpeg: { quality: 80 },
      svgo: {
        plugins: [
          { name: 'removeViewBox', active: false },
          { name: 'removeEmptyAttrs', active: true }
        ]
      }
    })
  ],
  base: './', // caminhos relativos
  build: {
    outDir: 'docs', // pasta de saída
    assetsDir: 'assets', // pasta para JS/CSS/imagens
    sourcemap: false, // desativa sourcemaps (menos arquivos)
    rollupOptions: {
      output: {
        chunkFileNames: 'assets/[name]-[hash].js', // nomes dos chunks
        entryFileNames: 'assets/[name]-[hash].js',
        assetFileNames: 'assets/[name]-[hash].[ext]',
        manualChunks(id) {
          if (id.includes('node_modules')) {
            return 'vendor' // separa dependências em vendor.js
          }
        }
      }
    }
  }
})