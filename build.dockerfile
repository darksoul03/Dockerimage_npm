FROM quay.cnqr.delivery/baseimage/node as build
ENV NODE_ENV=development
ENV BLUEBIRD_DEBUG=0
WORKDIR /build
ARG ARTIFACTORY_URI=https://artifactory.concurtech.net/artifactory
CMD ["echo", "quay.cnqr.delivery/baseimage/node"]
RUN npm install
RUN npm config set registry=$ARTIFACTORY_URI/api/npm/npm-aggregate/
COPY package.json package-lock.json docker-entrypoint.sh sonar-project.properties ./
RUN npm install
COPY .babelrc ./
COPY src ./src
COPY test ./test
ENV NODE_ENV=production
RUN npm run sonar:test && \
npm run translate && \
npm run build && \
npm run pack && \
rm -rf src && \
rm -rf test