import React from 'react';
import { Stack } from 'expo-router';
import LoginPage from '../src/screens/LoginPage';

export default function Login() {
  return (
    <>
      <Stack.Screen
        options={{
          headerShown: false,
        }}
      />
      <LoginPage />
    </>
  );
}