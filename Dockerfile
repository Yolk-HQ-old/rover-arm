FROM node:16

WORKDIR /app
RUN npm install "tuxmachine/rover-arm#master"

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["node_modules/.bin/rover"]
