# Web Server

* Put the files in /web
* And the server will serve them at the port **3000**

## Dockerfile Example:
```dockerfile
# Build the website

FROM node:latest AS builder

WORKDIR /app

COPY . .

RUN npm install
RUN npm audit fix
RUN npm run build


# Serve the website

FROM afonsopc/web-server AS runtime

COPY --from=builder /app/dist /web
```