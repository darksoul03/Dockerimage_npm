FROM ubuntu as build
ENV NODE_ENV=development
ENV BLUEBIRD_DEBUG=0
CMD ["echo", "quay.cnqr.delivery/baseimage/node"]
RUN apt-get update && apt-get install -y curl unzip && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
  nodejs \
  yarn \
  && rm -rf /var/lib/apt/lists/*
RUN npm install
ENV NODE_ENV=production
