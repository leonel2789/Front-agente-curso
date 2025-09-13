# Dockerfile (versión simple)
FROM node:18-alpine

WORKDIR /app

# Copiar archivos de package
COPY package*.json ./

# Instalar dependencias
RUN npm ci --only=production

# Copiar código fuente
COPY . .

# Instalar Expo CLI globalmente
RUN npm install -g @expo/cli

# Variables de entorno para reducir watchers
ENV CHOKIDAR_USEPOLLING=false
ENV EXPO_CLI_DISABLE_UPDATE_CHECK=1

# Exponer puerto
EXPOSE 3005

# Comando para iniciar la aplicación web
CMD ["npx", "expo", "start", "--web", "--port", "3005"]