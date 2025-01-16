import axios from "axios";
import AsyncStorage from '@react-native-async-storage/async-storage';

// Constants
export const TOKEN_NAME = "DS";
const API_URL = "https://api-v2.session42.xyz";

// Create axios instance
const apiClient = axios.create({
  baseURL: API_URL,
  headers: {
    "Content-Type": "application/json"
  },
  timeout: 10000
});

// Add auth token to requests
apiClient.interceptors.request.use(
  async (config) => {
    const token = await AsyncStorage.getItem(TOKEN_NAME);
    if (token) {
      config.headers.Authorization = "Bearer " + token;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

// Handle auth errors
apiClient.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (error.response?.status === 401) {
      await AsyncStorage.removeItem(TOKEN_NAME);
    }
    return Promise.reject(error);
  }
);

// Chat API methods
export const chatApi = {
  create: async (artistId) => {
    const response = await apiClient.post("/api/v1/chat/", { artistId });
    return response.data;
  },

  sendMessage: async (threadId, content) => {
    const response = await apiClient.post("/api/v1/chat/" + threadId + "/messages", { content });
    return response.data;
  },

  listMessages: async (threadId) => {
    const response = await apiClient.get("/api/v1/chat/" + threadId + "/messages");
    return response.data;
  }
};

// Test connection
export const testConnection = async () => {
  try {
    await apiClient.get("/api/v1/health");
    return true;
  } catch (error) {
    console.error("API connection test failed:", error.message);
    return false;
  }
};