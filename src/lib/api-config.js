import axios from "axios";
import AsyncStorage from '@react-native-async-storage/async-storage';

// Token name constant
export const TOKEN_NAME = "DS";

// Base URL configuration
const BASE_URL = "https://api-v2.session42.xyz";

// Create axios instance
export const axiosAuth = axios.create({
  baseURL: BASE_URL,
  headers: {
    "Content-Type": "application/json"
  },
  timeout: 10000
});

// Request interceptor for auth
axiosAuth.interceptors.request.use(
  async (config) => {
    try {
      const token = await AsyncStorage.getItem(TOKEN_NAME);
      if (token) {
        config.headers.Authorization = `Bearer ${token}`;
      }
      return config;
    } catch (error) {
      console.error("Error in request interceptor:", error);
      return config;
    }
  },
  (error) => Promise.reject(error)
);

// Response interceptor for handling auth errors
axiosAuth.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (error.response?.status === 401) {
      await AsyncStorage.removeItem(TOKEN_NAME);
    }
    return Promise.reject(error);
  }
);

// API endpoints
export const api = {
  chat: {
    create: (artistId) => axiosAuth.post("/api/v1/chat/", { artistId }),
    sendMessage: (threadId, content) => axiosAuth.post(`/api/v1/chat/${threadId}/messages`, { content }),
    listMessages: (threadId) => axiosAuth.get(`/api/v1/chat/${threadId}/messages`)
  },
  artist: {
    list: () => axiosAuth.get("/api/v1/artist"),
    get: (artistId) => axiosAuth.post(`/api/v1/artist/${artistId}`)
  },
  user: {
    create: (descopeUserId, descopeLoginIds) => axiosAuth.post("/api/v1/user/", { descopeUserId, descopeLoginIds }),
    get: (userId) => axiosAuth.get(`/api/v1/user/${userId}`)
  }
};