import axios from "axios";
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Platform } from 'react-native';

// Base URL configuration
const BASE_URL = Platform.select({
  ios: "http://localhost:3500",
  android: "http://10.0.2.2:3500",
  default: "https://api-v2.session42.xyz"
});

// Token name constant
export const TOKEN_NAME = "DS";

// Create axios instance
export const axiosAuth = axios.create({
  baseURL: BASE_URL,
  headers: {
    "Content-Type": "application/json"
  },
  timeout: 5000 // Shorter timeout for faster error detection
});

// Debug function to check token
export const checkAuthToken = async () => {
  try {
    const token = await AsyncStorage.getItem(TOKEN_NAME);
    console.log('Current auth token:', token ? 'Present' : 'Not found');
    return token;
  } catch (error) {
    console.error('Error checking auth token:', error);
    return null;
  }
};

// Request interceptor for auth
axiosAuth.interceptors.request.use(
  async (config) => {
    try {
      const token = await AsyncStorage.getItem(TOKEN_NAME);
      if (token) {
        config.headers.Authorization = "Bearer " + token;
      }
      console.log('Making API request:', {
        url: config.url,
        method: config.method,
        baseURL: config.baseURL
      });
      return config;
    } catch (error) {
      console.error('Error in request interceptor:', error);
      return config;
    }
  },
  (error) => Promise.reject(error)
);

// Response interceptor for handling auth errors
axiosAuth.interceptors.response.use(
  (response) => response,
  async (error) => {
    // Network error handling
    if (!error.response) {
      console.error('Network Error:', {
        message: error.message,
        config: error.config
      });
      throw new Error('Unable to connect to server. Please check your connection.');
    }

    // Auth error handling
    if (error.response?.status === 401) {
      await AsyncStorage.removeItem(TOKEN_NAME);
    }

    return Promise.reject(error);
  }
);

// Mock data for offline mode
const mockResponses = {
  messages: [
    {
      id: '1',
      content: "Welcome! I'm here to help you with music production.",
      sender: 'bot',
      createdAt: new Date().toISOString()
    }
  ]
};

// API endpoints with offline fallback
export const chatApi = {
  create: async (artistId) => {
    try {
      const response = await axiosAuth.post("/api/v1/chat/", { artistId });
      return response.data;
    } catch (error) {
      console.log('Falling back to offline mode');
      return { threadId: 'offline-' + Date.now() };
    }
  },

  sendMessage: async (threadId, content) => {
    try {
      const response = await axiosAuth.post("/api/v1/chat/" + threadId + "/messages", { content });
      return response.data;
    } catch (error) {
      console.log('Falling back to offline mode');
      return {
        id: Date.now().toString(),
        content,
        sender: 'user',
        createdAt: new Date().toISOString()
      };
    }
  },

  listMessages: async (threadId) => {
    try {
      const response = await axiosAuth.get("/api/v1/chat/" + threadId + "/messages");
      return response.data;
    } catch (error) {
      console.log('Falling back to offline mode');
      return { messages: mockResponses.messages };
    }
  }
};

// Test connection function
export const testConnection = async () => {
  try {
    await axiosAuth.get("/api/v1/health");
    return true;
  } catch (error) {
    console.error('Connection test failed:', error.message);
    return false;
  }
};