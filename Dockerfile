# Dockerfile optimizado para producción
FROM node:20-alpine

WORKDIR /app

# Instalar dependencias del sistema y aumentar límites
RUN apk add --no-cache curl dumb-init && \
    npm install -g @expo/cli serve

# Copiar solo package.json (no lock file para regenerarlo)
COPY package.json ./

# Instalar dependencias con optimizaciones
RUN npm install && \
    npm cache clean --force

# Copiar código fuente
COPY . .

# Variables de entorno para optimizar
ENV NODE_ENV=production
ENV CI=1
ENV EXPO_CLI_DISABLE_UPDATE_CHECK=1
ENV CHOKIDAR_USEPOLLING=false
ENV WATCHPACK_POLLING=false
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Build para producción web estático
RUN npx expo export --platform web --output-dir dist

# Exponer puerto
EXPOSE 3005

# Usar dumb-init y servir archivos estáticos
ENTRYPOINT ["dumb-init", "--"]
CMD ["serve", "-s", "dist", "-l", "3005"]