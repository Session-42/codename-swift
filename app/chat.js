import React from 'react';
import { useAuth } from '../src/contexts/AuthContext';
import ChatView from '../src/screens/ChatView';
import { View, ActivityIndicator } from 'react-native';
import { HitCraftColors } from '../src/theme/colors';
import { useLocalSearchParams } from 'expo-router';

export default function ChatScreen() {
  const { loading } = useAuth();
  const params = useLocalSearchParams();
  const { initialMessage, threadId } = params;

  if (loading) {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <ActivityIndicator size="large" color={HitCraftColors.accent} />
      </View>
    );
  }

  return (
    <ChatView 
      initialMessage={initialMessage} 
      threadId={threadId}
    />
  );
}

// Keep chat screen mounted to preserve state
ChatScreen.unstable_settings = {
  unmountOnBlur: false,
};