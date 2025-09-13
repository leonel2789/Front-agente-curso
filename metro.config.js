const { getDefaultConfig } = require('expo/metro-config');

const config = getDefaultConfig(__dirname);

// Configuración específica para contenedores Docker
config.watchFolders = [];
config.resolver.platforms = ['web'];

// Desactivar watchers en entorno containerizado
if (process.env.NODE_ENV === 'production' || process.env.DOCKER === 'true') {
  config.watcher = {
    additionalExts: [],
    watchman: false,
    healthCheck: {
      enabled: false,
    },
  };
}

module.exports = config;