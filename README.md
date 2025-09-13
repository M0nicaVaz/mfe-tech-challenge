# Monorepo MFE (Next.js 15)

Este repositório contém MFE (microfrontends) em Next.js 15: `login` e `home`. A pasta `shared` guarda código compartilhado (componentes e tipos) e pode ser usada como submódulo Git.

## Como rodar (sem Docker)

1. (Se usar submódulos) inicialize-os:
   - `git submodule update --init --recursive`
2. Variáveis de ambiente (login):
   - Copie `login/.env.example` para `login/.env` e ajuste valores se necessário.
3. Instale dependências por zona:
   - Terminal 1: `cd home && npm install`
   - Terminal 2: `cd login && npm install`
4. Suba os servidores de desenvolvimento:
   - Terminal 1 (home, porta 4444): `cd home && npm run dev`
   - Terminal 2 (login, porta 7777): `cd login && npm run dev`
5. Acesse a aplicação pelo host `login`:
   - `http://localhost:7777`

Observações:

- `login` faz rewrites para `home` usando `NEXT_PUBLIC_HOME_URL` (configure no `.env`).
- `shared` é um pacote local instalado via `file:../shared` (inicialize o submódulo `shared`).
- As zonas estão configuradas com `transpilePackages: ['shared']` para compilar o código do pacote local.

## Como rodar (com Docker)

1. Build da imagem (pode sobrescrever a URL do home):
   - `docker build -t mfe-finance .`
   - ou: `docker build --build-arg NEXT_PUBLIC_HOME_URL=http://host.docker.internal:4444 -t mfe-finance .`
2. Rodar o container (mapeando as portas das zonas):
   - `docker run --rm -p 7777:7777 -p 4444:4444 mfe-finance`
   - ou sobrescrevendo via env em runtime: `docker run --rm -e NEXT_PUBLIC_HOME_URL=http://localhost:4444 -p 7777:7777 -p 4444:4444 mfe-finance`
3. Acesse:
   - Login: `http://localhost:7777`
   - Home: `http://localhost:4444`

Notas sobre Docker:

- O container usa o script `start.sh` para subir `home` (porta interna 4444) e `login` (porta interna 7777) simultaneamente.
- `NEXT_PUBLIC_HOME_URL` controla para onde o `login` reescreve rotas do `/home`.
- Você pode defini-la no build (`--build-arg`) ou no `docker run` (`-e`).

## Estrutura

```
/ (raiz)
  shared/              # código compartilhado (pode ser submódulo)
  home/                # zona Home (Next.js)
  login/               # zona Login (Next.js)
  Dockerfile           # sobe as duas zonas em dev
  README.md            # este arquivo
```

## Desenvolvimento

- Importações compartilhadas: use `shared` (pacote local em `shared/`).
- Para componentes com eventos (ex.: `onClick`), use `"use client"` no topo do arquivo.
- As zonas usam `transpilePackages: ['shared']` (em `next.config.ts`) para garantir o transpile.
