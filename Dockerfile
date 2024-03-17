FROM node:20.11.1-alpine@sha256:bf77dc26e48ea95fca9d1aceb5acfa69d2e546b765ec2abfb502975f1a2d4def

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
