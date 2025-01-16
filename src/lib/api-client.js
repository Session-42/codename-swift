import axios from 'axios';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Platform } from 'react-native';

// Get the local IP address for Android emulator
const getLocalHostAddress = () => {
  if (Platform.OS === 'android') {
    return '10.0.2.2:3500'; // Android emulator maps this to host's localhost
  }
  if (Platform.OS === 'ios') {
    return 'localhost:3500'; // iOS simulator can use localhost
  }
  return 'localhost:3500'; // Web
};

// Base URL configuration with better platform handling
const BASE_URL = __DEV__ 
  ? `http://${getLocalHostAddress()}`
  : 'https://api.dev.hitcraft.ai:8080';

// Token name constant
export const TOKEN_NAME = 'DS';

// Create axios instance with improved error handling
const api = axios.create({
  baseURL: BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
  timeout: 10000, // 10 seconds timeout
});

// Mock responses for offline/development mode
const mockResponses = {
  welcomeMessage: {
    id: 'welcome',
    content: "Hi! I'm Hitcraft AI. How can I help you today?",
    sender: 'bot',
    createdAt: new Date().toISOString()
  },
  defaultThread: {
    threadId: 'offline-default',
    artistId: 'hitcraft',
    title: 'Chat with Hitcraft AI'
  },
  defaultArtist: {
    id: 'hitcraft',
    name: 'Hitcraft AI',
    genre: 'AI Music Assistant'
  },
  defaultUser: {
    id: 'offline-user',
    email: 'dev@hitcraft.ai',
    name: 'Development User'
  }
};

// Create a mock bot response
const createMockBotResponse = (userMessage) => ({
  id: `bot-${Date.now()}`,
  content: `I'm in offline mode right now, but I'll help you as best I can. You said: "${userMessage}"`,
  sender: 'bot',
  createdAt: new Date().toISOString()
});

// Request interceptor for auth
api.interceptors.request.use(
  async (config) => {
    try {
      const token = await AsyncStorage.getItem(TOKEN_NAME);
      if (token) {
        config.headers.Authorization = `Bearer ${token}`;
      }
      console.log(`[API] ${config.method?.toUpperCase()} ${config.url}`);
      return config;
    } catch (error) {
      console.error('[API] Error in request interceptor:', error);
      return config;
    }
  },
  (error) => {
    console.error('[API] Request interceptor error:', error);
    return Promise.reject(error);
  }
);

// Response interceptor with improved error handling and offline support
api.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (!error.response) {
      console.error('[API] Network Error:', error.message);
      if (__DEV__) {
        // In development, return mock data based on the request URL
        const url = error.config?.url || '';
        const method = error.config?.method || '';
        let mockData = { message: 'Offline mode - request simulated' };

        if (url.includes('/api/v1/chat/')) {
          if (url.includes('/messages')) {
            if (method === 'post') {
              // Handle message sending
              const content = error.config?.data ? JSON.parse(error.config.data).content : '';
              mockData = createMockBotResponse(content);
            } else {
              // Handle message listing
              mockData = { messages: [mockResponses.welcomeMessage] };
            }
          } else {
            mockData = mockResponses.defaultThread;
          }
        } else if (url.includes('/api/v1/user/')) {
          mockData = mockResponses.defaultUser;
        } else if (url.includes('/api/v1/artist/')) {
          mockData = mockResponses.defaultArtist;
        }

        console.log('[API] Using mock data in development:', mockData);
        return Promise.resolve({ data: mockData });
      }
      throw new Error('Unable to connect to server. Please check your connection.');
    }

    if (error.response?.status === 401) {
      console.log('[API] Unauthorized, clearing token');
      await AsyncStorage.removeItem(TOKEN_NAME);
    }

    return Promise.reject(error);
  }
);

// API endpoints with improved error handling and offline support
export const chatApi = {
  create: async (artistId) => {
    if (!artistId) {
      throw new Error('Artist ID is required');
    }

    try {
      const response = await api.post('/api/v1/chat/', { artistId });
      return response.data;
    } catch (error) {
      if (__DEV__) {
        console.log('[API] Using mock chat in development');
        return {
          ...mockResponses.defaultThread,
          threadId: `offline-${Date.now()}`,
          artistId
        };
      }
      throw error;
    }
  },

  sendMessage: async (threadId, content) => {
    if (!threadId || !content) {
      throw new Error('Thread ID and content are required');
    }

    try {
      const response = await api.post(`/api/v1/chat/${threadId}/messages`, { content });
      return response.data;
    } catch (error) {
      if (__DEV__) {
        console.log('[API] Using mock message in development');
        return createMockBotResponse(content);
      }
      throw error;
    }
  },

  listMessages: async (threadId) => {
    if (!threadId) {
      throw new Error('Thread ID is required');
    }

    try {
      const response = await api.get(`/api/v1/chat/${threadId}/messages`);
      return response.data;
    } catch (error) {
      if (__DEV__) {
        console.log('[API] Using mock messages in development');
        return {
          messages: [mockResponses.welcomeMessage]
        };
      }
      throw error;
    }
  },

  list: async (amount = 3) => {
    try {
      const response = await api.get(`/api/v1/chat/?amount=${amount}`);
      return response.data;
    } catch (error) {
      if (__DEV__) {
        return { threads: [mockResponses.defaultThread] };
      }
      throw error;
    }
  },

  listByArtist: async (artistId) => {
    try {
      const response = await api.get(`/api/v1/chat/${artistId}`);
      return response.data;
    } catch (error) {
      if (__DEV__) {
        return { threads: [mockResponses.defaultThread] };
      }
      throw error;
    }
  },

  delete: (threadId) => api.delete(`/api/v1/chat/${threadId}`),
  getLast: (threadId) => api.get(`/api/v1/chat/${threadId}/last-message`),
  changeTitle: (threadId, title) => api.put(`/api/v1/chat/${threadId}/title`, { title }),
};

// Artist related endpoints
export const artistApi = {
  list: async () => {
    try {
      const response = await api.get('/api/v1/artist');
      return response.data;
    } catch (error) {
      if (__DEV__) {
        return { artists: [mockResponses.defaultArtist] };
      }
      throw error;
    }
  },
  get: (artistId) => api.get(`/api/v1/artist/${artistId}`),
  create: (data) => api.post('/api/v1/artist/', { data }),
  delete: (artistId) => api.delete(`/api/v1/artist/${artistId}`),
  updateInstructions: (artistId, instructions) =>
    api.put(`/api/v1/artist/${artistId}/instructions`, { instructions }),
  updateInfo: (artistId, data) =>
    api.post(`/api/v1/artist/${artistId}/info`, { data }),
};

// User related endpoints
export const userApi = {
  create: async (descopeUserId, descopeLoginIds) => {
    try {
      const response = await api.post('/api/v1/user/', { descopeUserId, descopeLoginIds });
      return response.data;
    } catch (error) {
      if (__DEV__) {
        console.log('[API] Using mock user in development');
        return {
          ...mockResponses.defaultUser,
          id: descopeUserId,
          email: descopeLoginIds[0]
        };
      }
      throw error;
    }
  },
  get: async (userId) => {
    try {
      const response = await api.get(`/api/v1/user/${userId}`);
      return response.data;
    } catch (error) {
      if (__DEV__) {
        return mockResponses.defaultUser;
      }
      throw error;
    }
  },
  delete: (userId) => api.delete(`/api/v1/user/${userId}`),
  update: (userId, data) => api.put(`/api/v1/user/${userId}`, { data }),
  isRegistered: (descopeUserId) => api.get(`/api/v1/user/${descopeUserId}/registered`),
};

// Knowledge related endpoints
export const knowledgeApi = {
  create: (artistId, type, content) =>
    api.post(`/api/v1/artist/${artistId}/knowledge`, { type, content }),
  list: (artistId) => api.get(`/api/v1/${artistId}/knowledge`),
  delete: (id) => api.post('/api/v1/knowledge/delete', { id }),
};

// Sketch related endpoints
export const sketchApi = {
  upload: (file, fullAnalysis = false) => {
    const formData = new FormData();
    formData.append('file', file);
    formData.append('fullAnalysis', String(fullAnalysis));
    return api.post('/api/v1/sketch', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
  },
  getStatus: (taskId) => api.get(`/api/v1/sketch/tasks/${taskId}/status`),
  setBpm: (sketchId, bpm) => api.put(`/api/v1/sketch/${sketchId}/bpm`, { bpm }),
  setShiftBeat: (sketchId, beat) =>
    api.put(`/api/v1/sketch/${sketchId}/shiftbeat`, { beat }),
  getAudioFile: (sketchId) => api.get(`/api/v1/sketch/${sketchId}/audio-file`),
  setName: (sketchId, name) => api.put(`/api/v1/sketch/${sketchId}/name`, { name }),
  getStructure: (userId, sketchId) =>
    api.get(`/api/v1/sketch/${sketchId}/structure`),
};

// Butcher related endpoints
export const butcherApi = {
  startV1: (referenceId, sketchId, sketchBpm) =>
    api.post('/api/v1/butcher/tasks', { referenceId, sketchId, sketchBpm }),
  getStatus: (taskId) => api.get(`/api/v1/butcher/tasks/${taskId}/status`),
};

// Render related endpoints
export const renderApi = {
  start: (butcherId) => api.post(`/api/v1/render/tasks`, { butcherId }),
  getStatus: (butcherId) => api.get(`/api/v1/render/tasks/${butcherId}/status`),
};

// Server status
export const serverApi = {
  status: () => api.get('/status'),
};