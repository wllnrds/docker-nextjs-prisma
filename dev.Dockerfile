FROM node:18-alpine

WORKDIR /app

COPY ./app/package.json ./

RUN \
  if [ -f yarn.lock ]; then yarn install; \
  elif [ -f package.json ]; then npm install; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i; \
  else echo "Using NPM as default" && npm install; \
  fi

COPY ./app .

ARG DATABASE_URL
ENV DATABASE_URL=${DATABASE_URL}

RUN npx prisma generate

EXPOSE 3000

CMD npm run dev