# Claude Memory - Proyecto N8N Course Platform

## Resumen del Proyecto
- **Frontend**: React Native con Expo (N8N Course Platform)
- **Autenticación**: Keycloak
- **Arquitectura**: Plataforma de aprendizaje con IA y agentes virtuales
- **Propósito**: App educativa para curso de N8N con múltiples agentes
- **Branding**: Preparada con placeholders para logos de dos empresas

## Integración de Keycloak Completada 

### 1. Frontend (N8N Course Platform)
- **Dependencias instaladas**: expo-auth-session, expo-web-browser, expo-crypto, @react-native-async-storage/async-storage
- **AuthProvider**: contexts/AuthContext.tsx - Manejo completo OAuth2/OpenID Connect
- **LoginScreen**: components/LoginScreen.tsx - Pantalla de login con placeholders para logos de empresas
- **Configuración**: config.ts actualizado para agentes de curso N8N
- **Integración**: AuthProvider envolviendo la app, control de acceso en index.tsx
- **Logout**: Botón agregado al menú del chat
- **Branding**: Dos placeholders para logos de empresas (principal y secundario)

### 2. Keycloak Server (para N8N Course)
- **Docker Compose**: PostgreSQL + Keycloak 23.0.3
- **Realm**: "n8n-course" preconfigurado
- **Cliente**: course-client con secret "course-secret-2024"
- **Usuarios**:
  - admin/admin123 (course-admin)
  - testuser/test123 (course-user)
- **Scripts**: start.sh, stop.sh, reset.sh, backup.sh

### Configuración Clave
```typescript
export const KEYCLOAK_CONFIG = {
  url: process.env.EXPO_PUBLIC_KEYCLOAK_URL || 'http://localhost:8080',
  realm: process.env.EXPO_PUBLIC_KEYCLOAK_REALM || 'n8n-course',
  clientId: process.env.EXPO_PUBLIC_KEYCLOAK_CLIENT_ID || 'course-client'
};
```

### URLs Importantes
- Admin Console: http://localhost:8080/admin
- Realm: http://localhost:8080/realms/n8n-course
- Auth Endpoint: http://localhost:8080/realms/n8n-course/protocol/openid-connect/auth

### Para Iniciar
```bash
cd keycloak-server
./scripts/start.sh
```

### Estado Actual
- ✅ Keycloak configurado completamente
- ✅ Frontend integrado con autenticación
- ✅ Sistema multi-agente implementado
- ✅ Scripts de administración creados
- ✅ Documentación completa
- ✅ Placeholders para logos de empresas

### Próximos Pasos Potenciales
- Configurar SSL/TLS para producción
- Personalizar temas de Keycloak
- Configurar proveedores externos (Google, Facebook)
- Implementar roles más granulares
- Agregar logos reales de las empresas

## Sistema de Roles por Tipos de Agentes (ACTUALIZACIÓN)

### Roles Configurados
- **agente-ventas**: Agente especializado en ventas y atención al cliente
- **agente-soporte**: Agente especializado en soporte técnico  
- **agente-marketing**: Agente especializado en marketing y campañas
- **agente-general**: Agente general para consultas diversas (por defecto)

### Mapeo de Webhooks N8N
```typescript
{
  'agente-ventas': 'https://your-webhook-url.com/webhook/sales',
  'agente-soporte': 'https://your-webhook-url.com/webhook/support',
  'agente-marketing': 'https://your-webhook-url.com/webhook/marketing',
  'agente-general': 'https://your-webhook-url.com/webhook/general'
}
```

### Configuración de Roles en Keycloak

#### 1. Crear Roles en el Realm
1. Acceder a Admin Console: http://localhost:8080/admin
2. Ir a Realm "n8n-course" → Realm roles
3. Crear los siguientes roles:
   - `agente-ventas`
   - `agente-soporte`
   - `agente-marketing`
   - `agente-general`

#### 2. Asignar Roles a Usuarios
1. Ir a Users → Seleccionar usuario
2. Tab "Role mappings"
3. Asignar el rol correspondiente según la especialidad del usuario

### Funcionamiento Automático
1. **Login**: Usuario se autentica con Keycloak
2. **Extracción de Roles**: El frontend extrae roles del JWT token
3. **Selección de Webhook**: Se selecciona automáticamente el webhook según el primer rol del usuario
4. **Interfaz Personalizada**: Múltiples indicadores visuales del agente activo

### Indicadores Visuales del Agente Activo

#### 1. Cabecera Principal
- **Banner prominente** con información del agente
- **Colores personalizados** por tipo de agente
- **Badge "ACTIVO"** con animación de pulso
- **Icono representativo** de cada especialidad

#### 2. Barra Lateral
- **Información detallada** del agente y usuario
- **Descripción completa** de la especialidad
- **Roles adicionales** si el usuario tiene múltiples permisos
- **Colores temáticos** coherentes con el agente
- **Placeholder para logo principal** de empresa

#### 3. Estado Vacío
- **Mensaje personalizado** según el agente activo
- **Invitación contextual** para consultar al especialista
- **Iconografía específica** de cada área
- **Placeholder para logo secundario** de empresa

#### 4. Colores por Agente
- **Agente Ventas**: Verde (Ventas/Crecimiento)
- **Agente Soporte**: Azul (Confianza/Profesional) 
- **Agente Marketing**: Naranja (Creatividad/Atención)
- **Agente General**: Violeta (Versatilidad/AI)

## Sistema de Carga de Archivos a Google Drive (NUEVA FUNCIONALIDAD)

### Arquitectura de Carpetas
```
Google Drive Root (your-folder-id)
├── Agente Ventas/
│   └── ventas no procesados/     ← Archivos van aquí
├── Agente Soporte/
│   └── soporte no procesados/       ← Archivos van aquí
├── Agente Marketing/
│   └── marketing no procesados/ ← Archivos van aquí
└── Agente General/
    └── general no procesados/       ← Archivos van aquí
```

### Componentes Implementados

#### 1. Servicio Google Drive (`services/googleDriveService.ts`)
- **Autenticación OAuth2** con Google Drive API
- **Mapeo automático** de agentes a carpetas específicas
- **Creación automática** de subcarpetas "no procesados"
- **Manejo de tokens** con refresh automático
- **Subida de archivos** a la carpeta correcta según rol del usuario

#### 2. Componente de Carga (`components/FileUploader.tsx`)
- **Modal full-screen** con diseño cohesivo al agente activo
- **Selector de archivos múltiple** con preview
- **Indicador de progreso** por archivo
- **Autenticación integrada** con Google Drive
- **Validación de archivos** y manejo de errores

#### 3. Integración en ChatScreen
- **Botón "Subir Archivos"** en menú lateral
- **Detección automática del agente activo**
- **Colores y temas coherentes** con el sistema de roles

### Configuración Requerida

#### Variables de Entorno (.env)
```bash
# Google Drive API
EXPO_PUBLIC_GOOGLE_API_KEY=your_api_key
EXPO_PUBLIC_GOOGLE_CLIENT_ID=your_client_id.apps.googleusercontent.com
EXPO_PUBLIC_GOOGLE_CLIENT_SECRET=your_client_secret

# Folder IDs específicos por agente (opcionales)
EXPO_PUBLIC_GD_VENTAS_FOLDER_ID=folder_id_ventas
EXPO_PUBLIC_GD_SOPORTE_FOLDER_ID=folder_id_soporte
EXPO_PUBLIC_GD_MARKETING_FOLDER_ID=folder_id_marketing
EXPO_PUBLIC_GD_GENERAL_FOLDER_ID=folder_id_general
```

#### Dependencias Instaladas
```json
{
  "expo-file-system": "^18.1.11"
}
```

### Flujo de Funcionamiento

1. **Usuario accede a "Subir Archivos"** desde el menú lateral
2. **Sistema detecta el agente activo** basado en roles del usuario
3. **Modal se abre** con colores y branding del agente
4. **Usuario autoriza Google Drive** (solo la primera vez)
5. **Usuario selecciona archivos** desde el dispositivo
6. **Sistema sube archivos automáticamente** a la carpeta correcta:
   - `Agente Ventas/ventas no procesados/`
   - `Agente Soporte/soporte no procesados/`
   - `Agente Marketing/marketing no procesados/`
   - `Agente General/general no procesados/`

### Mapeo de Agentes a Carpetas
```typescript
const AGENT_SUBFOLDER_NAMES = {
  'agente-ventas': 'ventas no procesados',
  'agente-soporte': 'soporte no procesados', 
  'agente-marketing': 'marketing no procesados',
  'agente-general': 'general no procesados'
}
```

### Siguientes Pasos para N8N Integration
1. **Crear webhook/trigger en N8N** para detectar archivos nuevos en Google Drive
2. **Procesar archivos** con el RAG system correspondiente al agente
3. **Mover archivos procesados** a carpeta "procesados" 
4. **Notificar al usuario** del procesamiento completado

### Características Destacadas
- ✅ **Detección automática del agente activo**
- ✅ **Subida directa a carpeta correcta** 
- ✅ **Interfaz visual coherente** con sistema de roles
- ✅ **Manejo robusto de errores** y autenticación
- ✅ **Soporte para múltiples archivos**
- ✅ **Preview de archivos** con iconos por tipo
- ✅ **Indicadores de progreso** en tiempo real
- ✅ **Compatibilidad web y móvil** - Funciona en ambas plataformas
- ✅ **OAuth2 con PKCE** - Seguridad mejorada según estándares Google

## Placeholders para Logos de Empresas

### Ubicaciones de Placeholders

#### 1. Logo Principal (Pantalla de Login)
- **Ubicación**: `components/LoginScreen.tsx` línea 36-40
- **Descripción**: Placeholder circular grande en la parte superior
- **Formato sugerido**: Logo cuadrado/circular, 100x100px
- **Código**:
```tsx
<View style={styles.logoPlaceholder}>
  <Text style={styles.logoText}>LOGO</Text>
  <Text style={styles.logoSubtext}>Empresa 1</Text>
</View>
```

#### 2. Logo Principal (Sidebar del Chat)
- **Ubicación**: `screens/ChatScreen.tsx` línea 206-209
- **Descripción**: Logo pequeño en la barra lateral
- **Formato sugerido**: Logo horizontal, 20x20px
- **Código**:
```tsx
<View style={styles.logoPlaceholder}>
  <Text style={styles.logoText}>LOGO</Text>
</View>
```

#### 3. Logo Secundario (Pantalla de Login - Footer)
- **Ubicación**: `components/LoginScreen.tsx` línea 64-67
- **Descripción**: Logo secundario en el pie de página del login
- **Formato sugerido**: Logo horizontal, mediano
- **Código**:
```tsx
<View style={styles.secondaryLogoContainer}>
  <Text style={styles.secondaryLogoText}>EMPRESA 2</Text>
</View>
```

#### 4. Logo Secundario (Estado Vacío del Chat)
- **Ubicación**: `screens/ChatScreen.tsx` línea 320-322
- **Descripción**: Logo secundario cuando no hay mensajes
- **Formato sugerido**: Logo horizontal, mediano
- **Código**:
```tsx
<View style={styles.secondaryLogoPlaceholder}>
  <Text style={styles.secondaryLogoText}>Empresa 2 Logo</Text>
</View>
```

### Instrucciones para Implementar Logos Reales

1. **Agregar imágenes** a la carpeta `assets/images/`
2. **Importar imágenes** en los componentes:
```tsx
import LogoEmpresa1 from '../assets/images/logo-empresa-1.png'
import LogoEmpresa2 from '../assets/images/logo-empresa-2.png'
```
3. **Reemplazar placeholders** con componente `<Image>`:
```tsx
<Image source={LogoEmpresa1} style={styles.logoImage} />
```

## Correcciones y Mejoras Implementadas (Diciembre 2024)

### 1. Solución a Error de Google SDK Logging
**Problema**: `Cannot read properties of undefined (reading 'GOOGLE_SDK_NODE_LOGGING')`
**Solución**: 
- ❌ **Eliminado** `googleapis` package (incompatible con React Native)
- ✅ **Implementado** HTTP requests directos a Google Drive API
- ✅ **Reemplazados** todos los métodos de `googleapis` con `fetch()` nativo

### 2. Corrección de AuthSession.startAsync Deprecated
**Problema**: `AuthSession.startAsync is not a function`
**Solución**:
- ❌ **Eliminado** uso de `AuthSession.startAsync` (deprecated)
- ✅ **Implementado** `AuthSession.AuthRequest` + `promptAsync` (API moderna)
- ✅ **Configurado** discovery endpoints oficiales de Google

### 3. Implementación de OAuth2 con PKCE
**Problema**: `Missing code verifier` error 400
**Solución**:
- ✅ **PKCE habilitado** con `CodeChallengeMethod.S256`
- ✅ **Code verifier automático** generado por Expo
- ✅ **Parámetros flexibles** para Web applications y Mobile apps
- ✅ **Client secret opcional** según tipo de OAuth client

### 4. Configuración de Redirect URIs
**Problema**: Error 404 y CORS issues
**Solución**:
- ✅ **Scheme personalizado** configurado: `n8ncourse://`
- ✅ **Desarrollo local** con `preferLocalhost: true`
- ✅ **URIs recomendadas** para Google Cloud Console:
  ```
  http://localhost:19006
  http://localhost:8081
  n8ncourse://
  ```

### 5. Compatibilidad Web/Móvil para Upload de Archivos
**Problema**: `expo-file-system.getInfoAsync is not available on web`
**Solución**:
- ✅ **Detección de plataforma** con `Platform.OS === 'web'`
- ✅ **Web**: Usa File API nativo (`fetch()` + `arrayBuffer()`)
- ✅ **Móvil**: Mantiene `expo-file-system`
- ✅ **Conversión base64** unificada para ambas plataformas

### 6. Adaptación para Curso de N8N
**Cambios Realizados**:
- ✅ **Branding actualizado** de legal a educativo
- ✅ **Agentes redefinidos** para contexto de curso
- ✅ **Placeholders para logos** de empresas implementados
- ✅ **URLs y configuración** actualizadas
- ✅ **Documentación adaptada** al nuevo propósito

### Estado Actual: COMPLETAMENTE FUNCIONAL Y ADAPTADO
- ✅ **Autenticación Google Drive**: OAuth2 con PKCE
- ✅ **Upload de archivos**: Web y móvil compatible
- ✅ **Organización automática**: Por agente y subcarpetas
- ✅ **Interfaz intuitiva**: Diseño coherente con sistema de roles
- ✅ **Error handling**: Manejo robusto de fallos de red/auth
- ✅ **Branding empresarial**: Placeholders para dos empresas
- ✅ **Contexto educativo**: Adaptado para curso de N8N

## Configuración Final para Producción

### Variables de Entorno Requeridas
```bash
# Keycloak Configuration
EXPO_PUBLIC_KEYCLOAK_URL=http://localhost:8080
EXPO_PUBLIC_KEYCLOAK_REALM=n8n-course
EXPO_PUBLIC_KEYCLOAK_CLIENT_ID=course-client
EXPO_PUBLIC_KEYCLOAK_CLIENT_SECRET=course-secret-2024

# N8N Webhooks por Agente
EXPO_PUBLIC_N8N_VENTAS_URL=https://your-webhook-url.com/webhook/sales
EXPO_PUBLIC_N8N_SOPORTE_URL=https://your-webhook-url.com/webhook/support
EXPO_PUBLIC_N8N_MARKETING_URL=https://your-webhook-url.com/webhook/marketing
EXPO_PUBLIC_N8N_GENERAL_URL=https://your-webhook-url.com/webhook/general

# Google Drive API Configuration
EXPO_PUBLIC_GOOGLE_API_KEY=your_google_api_key_here
EXPO_PUBLIC_GOOGLE_CLIENT_ID=your_google_client_id_here.apps.googleusercontent.com
EXPO_PUBLIC_GOOGLE_CLIENT_SECRET=your_google_client_secret_here

# Google Drive Folder IDs por Agente
EXPO_PUBLIC_GD_VENTAS_FOLDER_ID=your_ventas_folder_id_here
EXPO_PUBLIC_GD_SOPORTE_FOLDER_ID=your_soporte_folder_id_here
EXPO_PUBLIC_GD_MARKETING_FOLDER_ID=your_marketing_folder_id_here
EXPO_PUBLIC_GD_GENERAL_FOLDER_ID=your_general_folder_id_here
```

### Próximos Pasos para Personalización
1. **Reemplazar placeholders de logos** con imágenes reales
2. **Configurar webhooks de N8N** con URLs reales
3. **Configurar carpetas de Google Drive** con IDs reales
4. **Personalizar colores y branding** según identidad de las empresas
5. **Configurar Keycloak** con realm y usuarios específicos del curso