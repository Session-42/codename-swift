import { axiosAuth } from "./axios-auth";

const api = axiosAuth;

// Chat related endpoints
export const chatApi = {
  create: async (artistId) => {
    const response = await api.post("/api/v1/chat/", { artistId });
    return response.data;
  },
  
  sendMessage: async (threadId, content) => {
    const response = await api.post(`/api/v1/chat/${threadId}/messages`, { content });
    return response.data;
  },
  
  listMessages: async (threadId) => {
    const response = await api.get(`/api/v1/chat/${threadId}/messages`);
    return response.data;
  }
};

// Artist related endpoints
export const artistApi = {
  list: async () => {
    const response = await api.get("/api/v1/artist");
    return response.data;
  },
  
  get: async (artistId) => {
    const response = await api.post(`/api/v1/artist/${artistId}`);
    return response.data;
  }
};

// User related endpoints
export const userApi = {
  create: async (descopeUserId, descopeLoginIds) => {
    const response = await api.post("/api/v1/user/", { 
      descopeUserId, 
      descopeLoginIds 
    });
    return response.data;
  },
  
  get: async (userId) => {
    const response = await api.get(`/api/v1/user/${userId}`);
    return response.data;
  }
};