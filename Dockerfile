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
ENV EXPO_CLI_DISABLE_UPDATE_CHECK=1
ENV EXPO_NO_TELEMETRY=1
ENV WATCHMAN_DISABLE_CI=1

# Exponer puerto
EXPOSE 3005

# Comando para iniciar la aplicación web con configuraciones optimizadas para contenedor
CMD ["sh", "-c", "echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && npx expo start --web --port 3005 --dev=false"]