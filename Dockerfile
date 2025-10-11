FROM node:20-alpine

WORKDIR /app

ARG NEXT_PUBLIC_HOME_URL=http://localhost:4444
ARG NEXT_PUBLIC_API_URL=http://localhost:5555/api
ENV NEXT_PUBLIC_HOME_URL=${NEXT_PUBLIC_HOME_URL}
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}

COPY home/package*.json home/
COPY login/package*.json login/
COPY api/package*.json api/
COPY shared/package*.json shared/
COPY shared shared

RUN cd shared && npm install && \
    cd ../home && npm install && \
    cd ../login && npm install && \
    cd ../api && npm install

COPY . .

EXPOSE 7777 4444 5555

RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
