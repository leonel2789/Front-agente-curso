# Dockerfile (versión simple)
FROM node:22-alpine

WORKDIR /app

# Copiar archivos de package
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar código fuente
COPY . .

# Instalar Expo CLI globalmente
RUN npm install -g @expo/cli

# Variables de entorno específicas para contenedor
ENV NODE_ENV=production
ENV EXPO_CLI_DISABLE_UPDATE_CHECK=1
ENV EXPO_NO_TELEMETRY=1
ENV CHOKIDAR_USEPOLLING=false

# Exponer puerto
EXPOSE 3005

# Comando simple para iniciar la aplicación web
CMD ["npx", "expo", "start", "--web", "--port", "3005", "--non-interactive"]