FROM node:20-bullseye-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    python \
    yarn \
    dumb-init \
 && rm -rf /var/lib/apt/lists/*
ENV NODE_ENV production
WORKDIR /home/node/app
COPY --chown=node . .
RUN yarn add graphql @graphql-mesh/runtime \
  @graphql-mesh/cli@0.82.35 \
  @graphql-mesh/graphql@1.0.0 \
  @graphql-mesh/openapi@0.35.26 \
  @graphql-mesh/json-schema \
  @graphql-mesh/transform-rename \
  @graphql-mesh/transform-prefix \
  @graphql-mesh/transform-cache \
  @graphql-mesh/transform-snapshot \
  @graphql-mesh/transform-mock \
  @graphql-mesh/transform-resolvers-composition \
  @graphql-mesh/transform-federation \
  @graphql-mesh/transform-filter-schema \
  @graphql-mesh/transform-naming-convention \
  @graphql-mesh/transform-type-merging \
  @graphql-mesh/merger-federation \
  @graphql-mesh/postgraphile \
  @graphile-contrib/pg-many-to-many \
  && yarn install --frozen-lockfile --immutable --immutable-cache --check-cache --production && yarn cache clean \
  && chown -R node /home/node/app
USER node
CMD ["dumb-init", "npm", "start"]