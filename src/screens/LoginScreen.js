import React, { useState } from 'react';
import { View, TouchableOpacity, Text, StyleSheet, Alert } from 'react-native';
import { useAuth } from '../contexts/AuthContext';
import * as WebBrowser from 'expo-web-browser';

const DESCOPE_PROJECT_ID = 'P2c5c3JHvZ8w5oiRpMMZnRKRtP2e';
const REDIRECT_URL = 'hitcraft://oauth-callback';

export default function LoginScreen() {
  const [isLoading, setIsLoading] = useState(false);
  const { signIn } = useAuth();

  const handleLogin = async () => {
    try {
      setIsLoading(true);
      console.log('Starting login process...');

      // Start OAuth flow with Descope
      const authUrl = `https://api.descope.com/v1/auth/oauth/authorize`;
      const params = new URLSearchParams({
        provider: 'google',
        redirectUrl: REDIRECT_URL,
      });

      console.log('Fetching auth URL...');
      const response = await fetch(authUrl + '?' + params.toString(), {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${DESCOPE_PROJECT_ID}`,
          'Content-Type': 'application/json',
        },
      });

      const data = await response.json();
      console.log('Got auth URL:', data.url);

      // Open web browser for authentication
      const result = await WebBrowser.openAuthSessionAsync(
        data.url,
        REDIRECT_URL
      );

      console.log('Browser result:', result);

      if (result.type === 'success') {
        const url = new URL(result.url);
        const code = url.searchParams.get('code');

        if (!code) {
          throw new Error('No authorization code received');
        }

        console.log('Exchanging code for tokens...');
        // Exchange code for tokens
        const tokenResponse = await fetch('https://api.descope.com/v1/auth/oauth/exchange', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${DESCOPE_PROJECT_ID}`,
          },
          body: JSON.stringify({ code }),
        });

        const tokenData = await tokenResponse.json();
        console.log('Got token data');
        
        // Save auth data
        await signIn(
          {
            sessionToken: tokenData.sessionJwt,
            refreshToken: tokenData.refreshJwt,
          },
          tokenData.user
        );
      }
    } catch (error) {
      console.error('Login error:', error);
      Alert.alert('Login Failed', 'Unable to sign in at this time. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <View style={styles.container}>
      <TouchableOpacity
        style={[styles.button, isLoading && styles.buttonDisabled]}
        onPress={handleLogin}
        disabled={isLoading}
      >
        <Text style={styles.buttonText}>
          {isLoading ? 'Signing in...' : 'Sign in with Google'}
        </Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  button: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 20,
    paddingVertical: 12,
    borderRadius: 8,
    width: '80%',
    alignItems: 'center',
  },
  buttonDisabled: {
    opacity: 0.7,
  },
  buttonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
  },
});