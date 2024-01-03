import { defineConfig } from 'vite'
import { djangoVitePlugin } from 'django-vite-plugin'
import { globSync } from 'glob'

export default defineConfig({
    plugins: [
        djangoVitePlugin([
            "demo/static/demo/ts/sierpinski.ts"
        ])
    ],
});