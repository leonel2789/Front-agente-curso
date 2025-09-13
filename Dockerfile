# Dockerfile (versión simple)
FROM node:18-alpine

WORKDIR /app

# Copiar archivos de package
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar código fuente
COPY . .

# Instalar Expo CLI globalmente
RUN npm install -g @expo/cli

# Limpiar node_modules de archivos innecesarios para reducir file watchers
RUN find node_modules -name "*.test.*" -delete && \
    find node_modules -name "__tests__" -type d -exec rm -rf {} + 2>/dev/null || true && \
    find node_modules -name "test" -type d -exec rm -rf {} + 2>/dev/null || true && \
    find node_modules -name "tests" -type d -exec rm -rf {} + 2>/dev/null || true && \
    find node_modules -name "*.spec.*" -delete 2>/dev/null || true

# Variables de entorno para optimizar Metro
ENV NODE_ENV=production
ENV EXPO_CLI_DISABLE_UPDATE_CHECK=1
ENV EXPO_CLI_NO_UPDATE_CHECK=1
ENV CHOKIDAR_USEPOLLING=true
ENV CHOKIDAR_INTERVAL=2000
ENV WATCHPACK_POLLING=true

# Exponer puerto
EXPOSE 3005

# Comando para iniciar la aplicación web con configuración optimizada
CMD ["npx", "expo", "start", "--web", "--port", "3005", "--host", "0.0.0.0"]