import React from 'react';
import { useAuth } from '../src/contexts/AuthContext';
import { View, ActivityIndicator } from 'react-native';
import { HitCraftColors } from '../src/theme/colors';
import { StylesView } from '../src/screens/StylesView';

export default function LibraryScreen() {
  const { loading } = useAuth();

  if (loading) {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <ActivityIndicator size="large" color={HitCraftColors.accent} />
      </View>
    );
  }

  return <StylesView />;
}

// Keep library screen mounted to preserve state
LibraryScreen.unstable_settings = {
  unmountOnBlur: false,
};