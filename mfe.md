# Guia do MFE

## Como adicionar um novo MFE como submódulo

1. **Preparar o repositório remoto**
   - Crie um novo repositório Git para o MFE (ex.: `reports`). Estruture-o como app Next.js 15 (pages ou app router) e exporte qualquer componente com `"use client"` quando houver eventos.
   - Configure `package.json` com `"name": "reports"` e adicione `"shared": "file:../shared"` em `dependencies`.
2. **Adicionar o submódulo ao monorepo**
   - `git submodule add -b main <URL_DO_REPO> reports`
   - Confirme que `reports/package.json` e `package-lock.json` estão versionados no repositório remoto antes de adicionar.
3. **Configurar o MFE localmente**

   - Dentro de `reports/`, instale dependências: `npm install`.
   - Ajuste `next.config.ts` replicando padrões:

     ```ts
     import type { NextConfig } from 'next';
     import path from 'node:path';

     const nextConfig: NextConfig = {
       assetPrefix: '/reports',
       basePath: '/reports',
       experimental: { externalDir: true },
       turbopack: {
         root: __dirname,
         resolveAlias: { shared: path.resolve(__dirname, '../shared') },
       },
       transpilePackages: ['shared'],
       webpack: (config) => ({
         ...config,
         resolve: {
           ...(config.resolve ?? {}),
           alias: {
             ...((config.resolve && config.resolve.alias) ?? {}),
             shared: path.resolve(__dirname, '../shared'),
           },
         },
       }),
     };

     export default nextConfig;
     ```

   - Atualize `tsconfig.json` copiando das zonas existentes para manter `@/*` e modo `bundler`.

4. **Integrar ao host/orquestrador**
   - Ajuste o app que atua como host (atualmente `login`) para incluir rewrites direcionando o novo caminho:
     ```ts
     {
       source: '/reports/:path*',
       destination: `${process.env.NEXT_PUBLIC_REPORTS_URL}/reports/:path*`,
     }
     ```
   - Garanta que o novo MFE expose sua URL (em dev: porta dedicada) e documente uma env como `NEXT_PUBLIC_REPORTS_URL`.
5. **Atualizar automações**
   - No GitHub Actions (`deploy.yml`), replique o job de deploy seguindo o padrão:
     - Checkout com submódulos.
     - Cache usando `reports/package-lock.json`.
     - Instalar deps em root/shared/reports.
     - Linkar projeto Vercel (`VERCEL_PROJECT_ID_REPORTS`).
     - Ajustar `needs` se depender de outras zonas para URLs.
   - No `Dockerfile`, copie `reports/package*.json`, rode `npm install` dentro da nova pasta e exponha a porta necessária.
   - Atualize `start.sh` (se aplicável) para iniciar o novo servidor (`npm run dev` na porta escolhida).
6. **Fluxo de publicação**
   - Commit no repositório do MFE e faça push.
   - No monorepo, commit da nova referência de submódulo + ajustes (workflow, Dockerfile, start.sh). Não esqueça de atualizar `.gitmodules` automaticamente criado.
   - Configure projetos/ambientes no Vercel para o novo MFE e adicione os `secrets` (`VERCEL_PROJECT_ID_REPORTS`, URLs de produção) usados pelo workflow.
