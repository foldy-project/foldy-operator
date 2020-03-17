FROM foldy/dashboard:deps as deps
COPY . .
RUN flutter build web

# Stage 2 - Create the run-time image
FROM nginx
COPY --from=deps /app/build/web /usr/share/nginx/html
