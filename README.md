# Bytebank - Tech Challenge parte 2

> Portal de serviços financeiros com arquitetura de micro front-end utilizando Next.js e Docker.

## Sumário

- [Produção](#produção)
- [Instalação](#instalação)
- [Arquitetura](#arquitetura)
- [Tecnologias](#tecnologias-principais)
- [Features](#features-implementadas)
- [Ambientes](#ambientes)

## Produção

- [Ver projeto](https://mfe-tech-challenge.vercel.app)

## Instalação

### Pré-requisitos

- Docker
- Docker Compose

### Passo a passo

1. Clone o repositório

```bash
git clone [url-do-repositorio]
```

2. Inicialize os submódulos (MFE):

```bash
git submodule update --init --recursive`
```

3. Para subir tudo com Docker Compose:

```bash
docker-compose up
```

- O serviço `api` expõe `NEXT_PUBLIC_HOME_URL` e `CORS_ALLOW_ORIGIN` via `docker-compose.yml`. Ajuste conforme necessário.

4. Para construir/rodar uma imagem única:

```bash
docker build -t mfe-finance .
docker run --rm -p 7777:7777 -p 4444:4444 -p 5555:5555 mfe-finance
```

5. Para parar os serviços do Compose:

```
docker-compose down
```

### Acessando as aplicações

| Serviço | URL                   |
| ------- | --------------------- |
| Login   | http://localhost:7777 |
| Home    | http://localhost:4444 |

## Arquitetura

- **Home**: Frontend principal (Dashboard, listagem e customização)
- **API**: Backend com serviços REST
- **Login**: Módulo de autenticação
- **Shared**: Biblioteca compartilhada

```
/ (raiz)
  shared/              # componentes compartilhados
  home/                # mfe Home
  login/               # mfe Login
  api/                 # backend Next.js
  Dockerfile
  README.md
```

## Tecnologias Principais

### Frontend

- ![Next.js](https://img.shields.io/badge/Next.js-15.5.3-000000?style=flat-square&logo=next.js)
- ![React](https://img.shields.io/badge/React-19.1.0-61DAFB?style=flat-square&logo=react)
- ![TypeScript](https://img.shields.io/badge/TypeScript-5+-3178C6?style=flat-square&logo=typescript)
- ![Sass](https://img.shields.io/badge/Sass-1.92.1-CC6699?style=flat-square&logo=sass)
- ![Zuatand](https://img.shields.io/badge/Zustand-5.0.2-602c3c?style=flat)

### Backend

- ![Next.js API](https://img.shields.io/badge/Next.js-15.5.3-000000?style=flat-square&logo=next.js)
- ![Docker](https://img.shields.io/badge/Docker-20.x-2496ED?style=flat-square&logo=docker)
- ![SQLite](https://img.shields.io/badge/Better%20SQLite3-4169E1?style=flat&logo=sqlite)

## Features Implementadas ✨

- [x] Arquitetura de microfrontend
- [x] Containerização com Docker
- [x] Sistema de autenticação
- [x] API REST
- [x] Estilização com Sass
- [x] Configuração de ESLint
- [x] Ambiente de desenvolvimento isolado
- [x] Acessibilidade adequada ao Lighthouse
- [x] Gerenciamento de estado com Zustand
- [x] Dashboard com Chart.js
- [x] Customização de Dashboard (ordem, retirar ou adicionar gráficos)
- [x] Pipeline com GitHub actions

## Ambientes

| Ambiente        | Comando/URL                                                |
| --------------- | ---------------------------------------------------------- |
| Desenvolvimento | `docker-compose up`                                        |
| Produção        | [Deploy via Vercel](https://mfe-tech-challenge.vercel.app) |

## Desenvolvido por

- [Gabriel Del Cesare Barros](https://github.com/gabriel-del)
- [Igor Oliveira Bitarães](https://github.com/bitaraes)
- [Maria Carolina Pereira de Mello Rosatto](https://github.com/carolinarosatto)
- [Monica Silva Nogueira Vaz](https://github.com/M0nicaVaz)
- [Thiago Cardoso de Souza Lopes](https://github.com/thiagocardososlopes)
