import React from 'react';
import { Stack, useLocalSearchParams } from 'expo-router';
import ChatView from '../../src/screens/ChatView';

export default function ChatScreen() {
  const { artistId } = useLocalSearchParams();

  return (
    <>
      <Stack.Screen
        options={{
          title: 'Chat with Hitcraft',
          headerStyle: {
            backgroundColor: '#F4F4F5',
          },
          headerShadowVisible: false,
          headerBackTitle: 'Back',
        }}
      />
      <ChatView artistId={artistId} />
    </>
  );
}