FROM node:20.11.1-alpine@sha256:f3299f16246c71ab8b304d6745bb4059fa9283e8d025972e28436a9f9b36ed24

ARG REACT_APP_ENV=local

RUN apk add --no-cache \
  curl

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN yarn global add serve

COPY package.json yarn.lock .npmrc ./
COPY patches ./patches
RUN yarn install --frozen-lockfile

COPY . .

RUN REACT_APP_ENV=$REACT_APP_ENV yarn build

CMD ["serve", "-s", "build"]
