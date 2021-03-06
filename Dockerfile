# STEP 1, build dist
FROM node:11-alpine as node

WORKDIR /usr/src/app

COPY . ./

RUN npm install
RUN npm run build

# STEP 2, run it with nginx
FROM nginx:1.15.8-alpine

WORKDIR /usr/share/nginx/html

COPY --from=node /usr/src/app/nginx.conf /etc/nginx/nginx.conf
COPY --from=node /usr/src/app/dist/cx-website/ ./
