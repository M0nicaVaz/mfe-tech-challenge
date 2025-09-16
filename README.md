# Monorepo MFE (Next.js 15)

Este repositório contém MFE (microfrontends) em Next.js 15: `login` e `home`. A pasta `shared` guarda código compartilhado (componentes e tipos) e pode ser usada como submódulo Git.

## Como rodar (sem Docker)

1. Inicialize os submodulos(mfe):
   - `git submodule update --init --recursive`
2. Variáveis de ambiente (login):
   - Copie `login/.env.example` para `login/.env` e ajuste valores se necessário.
3. Instale dependências por mfe:
   - Terminal 1: `cd home && npm install`
   - Terminal 2: `cd login && npm install`
   - Terminal 3: `cd shared && npm install`
   - Terminal 4: `cd .. && npm install` (root)
4. Suba os servidores de desenvolvimento:
   - Terminal 1 (home, porta 4444): `cd home && npm run dev`
   - Terminal 2 (login, porta 7777): `cd login && npm run dev`
5. Acesse a aplicação pelo host `login`:
   - `http://localhost:7777`

## Como rodar (com Docker)

1. Inicialize os submodulos(mfe):
   - `git submodule update --init --recursive`
2. Build da imagem:
   - `docker build -t mfe-finance .`
3. Rodar o container (mapeando as portas das zonas):
   - `docker run --rm -p 7777:7777 -p 4444:4444 mfe-finance`
4. Acesse:
   - Login: `http://localhost:7777`
   - Home: `http://localhost:4444`

## Estrutura

```
/ (raiz)
  shared/              # componentes compartilhados
  home/                # mfe Home
  login/               # mfe Login
  Dockerfile
  README.md
```

## Desenvolvimento

- Importações compartilhadas: use `shared` (pacote local em `shared/`).
- Para componentes com eventos (ex.: `onClick`), use `"use client"` no topo do arquivo.
