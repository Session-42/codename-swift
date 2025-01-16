import React from 'react';
import { Tabs } from 'expo-router';
import { HitCraftColors } from '../src/theme/colors';
import { Icons } from '../src/components/IconProvider';

export default function TabLayout() {
  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarStyle: {
          backgroundColor: 'white',
          borderTopColor: HitCraftColors.border,
        },
        tabBarActiveTintColor: HitCraftColors.accent,
        tabBarInactiveTintColor: HitCraftColors.secondaryText,
      }}
    >
      <Tabs.Screen
        name="home"
        options={{
          title: 'Home',
          tabBarIcon: ({ color, size }) => (
            <Icons.home size={size} color={color} />
          ),
        }}
      />
      <Tabs.Screen
        name="chat"
        options={{
          title: 'Chat',
          tabBarIcon: ({ color, size }) => (
            <Icons.chat size={size} color={color} />
          ),
        }}
      />
      <Tabs.Screen
        name="library"
        options={{
          title: 'Library',
          tabBarIcon: ({ color, size }) => (
            <Icons.library size={size} color={color} />
          ),
        }}
      />
      <Tabs.Screen
        name="history"
        options={{
          title: 'History',
          tabBarIcon: ({ color, size }) => (
            <Icons.history size={size} color={color} />
          ),
        }}
      />
    </Tabs>
  );
}