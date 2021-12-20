FROM node:16-alpine AS builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# /usr/share/nginx/html is the default location where nginx will serve the static html
# no need to specidy CMD here because nginx will automatically run when container run.