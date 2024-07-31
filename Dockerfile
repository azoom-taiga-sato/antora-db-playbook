FROM node:20-slim

ARG APP_NAME
ENV APP_NAME=${APP_NAME}

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN npm install -g pnpm
WORKDIR /app
COPY ["pnpm-lock.yaml", "package.json", "./"]
RUN pnpm install
COPY . .
RUN pnpm base prepare
RUN pnpm ${APP_NAME} build
ENTRYPOINT ["sh", "-c", "pnpm ${APP_NAME} start"]