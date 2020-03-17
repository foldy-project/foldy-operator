FROM foldy/dashboard:deps as deps
COPY . .
RUN flutter create . && flutter build web

FROM nginx:1.17.9-alpine
COPY --from=deps /app/build/web /usr/share/nginx/html
