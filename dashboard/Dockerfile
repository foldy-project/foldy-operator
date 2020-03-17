FROM foldy/dashboard:deps as deps
RUN flutter build web

# Stage 2 - Create the run-time image
FROM nginx
COPY --from=deps /app/build/web /usr/share/nginx/html
