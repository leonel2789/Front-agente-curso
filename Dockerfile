# Dockerfile optimizado para producción
FROM node:20-alpine

WORKDIR /app

# Aumentar límite de file watchers y instalar dependencias del sistema
RUN echo fs.inotify.max_user_watches=524288 >> /etc/sysctl.conf && \
    apk add --no-cache curl && \
    npm install -g @expo/cli

# Copiar solo package.json (no lock file para regenerarlo)
COPY package.json ./

# Instalar dependencias con optimizaciones
RUN npm install && \
    npm cache clean --force

# Copiar código fuente
COPY . .

# Build para producción web
RUN npx expo export --platform web --output-dir dist

# Exponer puerto
EXPOSE 3005

# Variables de entorno para optimizar
ENV NODE_ENV=production
ENV EXPO_CLI_DISABLE_UPDATE_CHECK=1
ENV CHOKIDAR_USEPOLLING=false
ENV WATCHPACK_POLLING=false

# Comando optimizado para web
CMD ["npx", "expo", "start", "--web", "--port", "3005", "--non-interactive", "--no-dev", "--minify"]