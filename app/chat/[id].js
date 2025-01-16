import React from 'react';
import { Stack } from 'expo-router';
import ChatView from '../../src/screens/ChatView';

export default function ChatDetailScreen() {
  return (
    <>
      <Stack.Screen
        options={{
          headerShown: false,
        }}
      />
      <ChatView />
    </>
  );
}