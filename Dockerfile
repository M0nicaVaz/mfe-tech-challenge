FROM node:20-alpine

WORKDIR /app

ARG NEXT_PUBLIC_HOME_URL=http://localhost:4444
ENV NEXT_PUBLIC_HOME_URL=${NEXT_PUBLIC_HOME_URL}

COPY home/package*.json home/
COPY login/package*.json login/
COPY shared/package*.json shared/
COPY shared shared

RUN cd shared && npm install && cd ../home && npm install && cd ../login && npm install

COPY . .

EXPOSE 7777 4444

RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
