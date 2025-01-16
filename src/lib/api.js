import { axiosAuth } from "./axios-auth";

const api = axiosAuth;

// Chat related endpoints
export const chatApi = {
  create: (artistId) => api.post("/api/v1/chat/", { artistId }),
  sendMessage: (threadId, content) => 
    api.post(`/api/v1/chat/${threadId}/messages`, { content }),
  listMessages: (threadId) => 
    api.get(`/api/v1/chat/${threadId}/messages`)
};

// Artist related endpoints
export const artistApi = {
  list: () => api.get("/api/v1/artist"),
  get: (artistId) => api.post(`/api/v1/artist/${artistId}`)
};

// User related endpoints
export const userApi = {
  create: (descopeUserId, descopeLoginIds) =>
    api.post("/api/v1/user/", { descopeUserId, descopeLoginIds }),
  get: (userId) => api.get(`/api/v1/user/${userId}`)
};