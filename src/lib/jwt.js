import AsyncStorage from '@react-native-async-storage/async-storage';
import { TOKEN_NAME } from './api-client';

export function decodeJWT(token) {
  try {
    const base64Payload = token.split('.')[1];
    const payload = JSON.parse(atob(base64Payload));
    return payload;
  } catch (error) {
    console.error('Error decoding JWT:', error);
    return null;
  }
}

export async function getUserId() {
  try {
    const token = await AsyncStorage.getItem(TOKEN_NAME);
    if (!token) return null;

    const payload = decodeJWT(token);
    return payload?.v2UserId || null;
  } catch (error) {
    console.error('Error getting user ID:', error);
    return null;
  }
}

// Helper function to encode base64 in React Native
function atob(input) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
  let str = input.replace(/=+$/, '');
  let output = '';

  if (str.length % 4 === 1) {
    throw new Error("'atob' failed: The string to be decoded is not correctly encoded.");
  }

  for (let bc = 0, bs = 0, buffer, i = 0; buffer = str.charAt(i++);) {
    const idx = chars.indexOf(buffer);
    if (idx === -1) continue;
    
    bs = bc % 4 ? bs * 64 + idx : idx;
    bc++;
    
    if (bc % 4) {
      output += String.fromCharCode(255 & (bs >> (-2 * bc & 6)));
    }
  }

  return output;
}