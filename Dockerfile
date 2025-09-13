# Dockerfile (versión simple)
FROM node:18-alpine

# Configurar límites del sistema para file watchers
RUN echo 'fs.inotify.max_user_watches=524288' >> /etc/sysctl.conf && \
    echo 'fs.inotify.max_user_instances=512' >> /etc/sysctl.conf

WORKDIR /app

# Copiar archivos de package
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar código fuente
COPY . .

# Instalar Expo CLI globalmente
RUN npm install -g @expo/cli

# Variables de entorno para optimizar Metro
ENV CHOKIDAR_USEPOLLING=false
ENV WATCHPACK_POLLING=false
ENV EXPO_CLI_DISABLE_UPDATE_CHECK=1

# Exponer puerto
EXPOSE 3005

# Comando para iniciar la aplicación web
CMD ["sh", "-c", "sysctl -w fs.inotify.max_user_watches=524288 && sysctl -w fs.inotify.max_user_instances=512 && npx expo start --web --port 3005"]