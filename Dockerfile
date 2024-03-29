FROM node:16

WORKDIR /app
RUN npm i -g pnpm@6
RUN chown -R node:node /app
USER node
RUN pnpm add "tuxmachine/rover-arm#master"

ENTRYPOINT ["node_modules/.bin/rover"]
