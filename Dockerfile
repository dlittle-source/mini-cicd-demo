# ---- Build Stage ----
FROM node:20-alpine AS build

WORKDIR /app

COPY app/package*.json ./
RUN npm ci --only=production

COPY app/ .

# ---- Runtime Stage ----
FROM node:20-alpine

WORKDIR /app

# Create non-root user (security best practice)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=build /app .

USER appuser

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://localhost:3000/health || exit 1

CMD ["npm", "start"]
