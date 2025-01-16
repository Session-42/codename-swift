import React from 'react';
import { useAuth } from '../src/contexts/AuthContext';
import ChatMainView from '../src/screens/ChatMainView';
import { View, ActivityIndicator } from 'react-native';
import { HitCraftColors } from '../src/theme/colors';

export default function HomeScreen() {
  const { loading } = useAuth();

  if (loading) {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <ActivityIndicator size="large" color={HitCraftColors.accent} />
      </View>
    );
  }

  return <ChatMainView />;
}

// Prevent re-rendering on tab press
HomeScreen.unstable_settings = {
  unmountOnBlur: false,
};