import React from 'react';
import { useAuth } from '../src/contexts/AuthContext';
import { View, ActivityIndicator } from 'react-native';
import { HitCraftColors } from '../src/theme/colors';
import { ChatSummaryView } from '../src/screens/ChatSummaryView';

export default function HistoryScreen() {
  const { loading } = useAuth();

  if (loading) {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <ActivityIndicator size="large" color={HitCraftColors.accent} />
      </View>
    );
  }

  return <ChatSummaryView isOpen={true} />;
}

// Keep history screen mounted to preserve state
HistoryScreen.unstable_settings = {
  unmountOnBlur: false,
};