// Mapeo de roles a webhooks de N8N
export const N8N_WEBHOOKS = {
  'agente-ventas': process.env.EXPO_PUBLIC_N8N_VENTAS_URL || 'https://your-webhook-url.com/webhook/sales',
  'agente-soporte': process.env.EXPO_PUBLIC_N8N_SOPORTE_URL || 'https://your-webhook-url.com/webhook/support',
  'agente-marketing': process.env.EXPO_PUBLIC_N8N_MARKETING_URL || 'https://your-webhook-url.com/webhook/marketing',
  'agente-general': process.env.EXPO_PUBLIC_N8N_GENERAL_URL || 'https://your-webhook-url.com/webhook/general'
};

// URL por defecto (Agente General - mantiene compatibilidad con versión anterior)
export const N8N_URL = process.env.EXPO_PUBLIC_N8N_URL || 
  'https://your-webhook-url.com/webhook/general';

export const KEYCLOAK_CONFIG = {
  url: process.env.EXPO_PUBLIC_KEYCLOAK_URL || 'http://localhost:8080',
  realm: process.env.EXPO_PUBLIC_KEYCLOAK_REALM || 'n8n-course',
  clientId: process.env.EXPO_PUBLIC_KEYCLOAK_CLIENT_ID || 'course-client',
  clientSecret: process.env.EXPO_PUBLIC_KEYCLOAK_CLIENT_SECRET || 'course-secret-2024'
};

// Roles disponibles en el sistema
export const AVAILABLE_ROLES = [
  'agente-ventas',
  'agente-soporte', 
  'agente-marketing',
  'agente-general'
] as const;

export type UserRole = typeof AVAILABLE_ROLES[number];

// Configuración de agentes AI
export const AI_AGENTS = {
  'agente-ventas': {
    name: 'Agente de Ventas',
    shortName: 'Ventas',
    description: 'Especialista en procesos de venta y atención al cliente',
    icon: 'cart-outline',
    color: '#2E7D32',
    lightColor: '#E8F5E8',
    borderColor: '#4CAF50'
  },
  'agente-soporte': {
    name: 'Agente de Soporte',
    shortName: 'Soporte',
    description: 'Especialista en soporte técnico y resolución de problemas',
    icon: 'headset',
    color: '#1565C0',
    lightColor: '#E3F2FD',
    borderColor: '#2196F3'
  },
  'agente-marketing': {
    name: 'Agente de Marketing',
    shortName: 'Marketing',
    description: 'Especialista en campañas de marketing y análisis de datos',
    icon: 'bullhorn-outline',
    color: '#E65100',
    lightColor: '#FFF3E0',
    borderColor: '#FF9800'
  },
  'agente-general': {
    name: 'Agente General',
    shortName: 'General',
    description: 'Asistente virtual general para consultas y tareas diversas',
    icon: 'robot-outline',
    color: '#6A1B9A',
    lightColor: '#F3E5F5',
    borderColor: '#9C27B0'
  }
} as const;

export interface ChatMessage {
  message: string;
  sessionId?: string;
}

// Configuración de Google Drive
export const GOOGLE_DRIVE_CONFIG = {
  apiKey: process.env.EXPO_PUBLIC_GOOGLE_API_KEY,
  clientId: process.env.EXPO_PUBLIC_GOOGLE_CLIENT_ID,
  clientSecret: process.env.EXPO_PUBLIC_GOOGLE_CLIENT_SECRET,
  scopes: [
    'https://www.googleapis.com/auth/drive.file',
    'https://www.googleapis.com/auth/drive.readonly'
  ]
};

// Mapeo de agentes a carpetas de Google Drive
export const GOOGLE_DRIVE_FOLDERS = {
  'agente-ventas': process.env.EXPO_PUBLIC_GD_VENTAS_FOLDER_ID || 'your-folder-id',
  'agente-soporte': process.env.EXPO_PUBLIC_GD_SOPORTE_FOLDER_ID || 'your-folder-id', 
  'agente-marketing': process.env.EXPO_PUBLIC_GD_MARKETING_FOLDER_ID || 'your-folder-id',
  'agente-general': '1wWEGO_9wSXKQux7cJXb4C9WVx2tIXAgi'
} as const;

// Subfolder names for "no procesados"
export const AGENT_SUBFOLDER_NAMES = {
  'agente-ventas': 'ventas no procesados',
  'agente-soporte': 'soporte no procesados',
  'agente-marketing': 'marketing no procesados',
  'agente-general': 'general no procesados'
} as const;