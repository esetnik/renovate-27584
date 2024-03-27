FROM node:20.12.0-alpine@sha256:ce6596fb57e9c3c126a93add6a52f661298e17f0be51ef08cf6e1788213a9c9b

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
