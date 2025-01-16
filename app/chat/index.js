import React from 'react';
import { Stack } from 'expo-router';
import StylesView from '../../src/screens/StylesView';

export default function ChatScreen() {
  return (
    <>
      <Stack.Screen
        options={{
          headerShown: false,
        }}
      />
      <StylesView />
    </>
  );
}