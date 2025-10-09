# Monorepo MFE (Next.js 15)

Este repositório contém MFE (microfrontends) em Next.js 15: `login` e `home`. A pasta `shared` guarda código compartilhado (componentes e tipos) e o pacote `api` expõe um backend Next.js simples em memória para persistir transações.

## Como rodar (sem Docker)

1. Inicialize os submódulos (mfe):
   - `git submodule update --init --recursive`
2. Variáveis de ambiente:
   - Copie `login/.env.example` para `login/.env` e ajuste valores se necessário.
   - Copie `home/.env.example` para `home/.env.local` (ou `.env`) e confirme `NEXT_PUBLIC_API_URL`.
3. Instale dependências por pacote:
   - Terminal 1: `cd home && npm install`
   - Terminal 2: `cd login && npm install`
   - Terminal 3: `cd shared && npm install`
   - Terminal 4: `cd api && npm install`
   - Terminal 5: `cd .. && npm install` (root)
4. Suba os servidores de desenvolvimento:
   - Terminal 1 (api, porta 5555): `cd api && npm run dev`
   - Terminal 2 (home, porta 4444): `cd home && npm run dev`
   - Terminal 3 (login, porta 7777): `cd login && npm run dev`
5. Acesse a aplicação pelo host `login`:
   - `http://localhost:7777`

## Como rodar (com Docker)

1. Inicialize os submódulos (mfe):
   - `git submodule update --init --recursive`
2. Para subir tudo com Docker Compose:
   - `docker-compose up`
3. Para construir/rodar uma imagem única:
   - `docker build -t mfe-finance .`
   - `docker run --rm -p 7777:7777 -p 4444:4444 -p 5555:5555 mfe-finance`
4. Acesse:
   - Login: `http://localhost:7777`
   - Home: `http://localhost:4444`
5. Para parar os serviços do Compose:
   - `docker-compose down`

## Estrutura

```
/ (raiz)
  shared/              # componentes compartilhados
  home/                # mfe Home
  login/               # mfe Login
  api/                 # backend Next.js
  Dockerfile
  README.md
```

## Desenvolvimento

- Importações compartilhadas: use `shared` (pacote local em `shared/`).
- Para componentes com eventos (ex.: `onClick`), use `"use client"` no topo do arquivo.
- Tipagens de transações ficam em `shared/types/transaction.ts` e são reutilizadas por `home` e `api`.
