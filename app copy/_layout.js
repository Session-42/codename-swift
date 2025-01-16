import { Tabs } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { AuthProvider } from '../src/contexts/AuthContext';
import { SafeAreaProvider } from 'react-native-safe-area-context';

export default function Layout() {
  return (
    <SafeAreaProvider>
      <AuthProvider>
        <Tabs
          screenOptions={{
            headerShown: false,
            tabBarStyle: {
              borderTopWidth: 0,
              backgroundColor: '#F4F4F5',
              height: 80,
              paddingTop: 8,
              paddingBottom: 28,
            },
            tabBarActiveTintColor: '#4285f4',
            tabBarInactiveTintColor: 'gray',
            tabBarIconStyle: {
              marginTop: -4,
            },
          }}
        >
          <Tabs.Screen
            name="home"
            options={{
              title: 'Home',
              tabBarIcon: ({ focused, color, size }) => (
                <Ionicons 
                  name={focused ? 'home' : 'home-outline'} 
                  size={size} 
                  color={color} 
                />
              ),
            }}
          />
          <Tabs.Screen
            name="chat"
            options={{
              title: 'Chat',
              tabBarIcon: ({ focused, color, size }) => (
                <Ionicons 
                  name={focused ? 'chatbubble' : 'chatbubble-outline'} 
                  size={size} 
                  color={color} 
                />
              ),
            }}
          />
          <Tabs.Screen
            name="styles"
            options={{
              title: 'Styles',
              tabBarIcon: ({ focused, color, size }) => (
                <Ionicons 
                  name={focused ? 'musical-notes' : 'musical-notes-outline'} 
                  size={size} 
                  color={color} 
                />
              ),
            }}
          />
          <Tabs.Screen
            name="history"
            options={{
              title: 'History',
              tabBarIcon: ({ focused, color, size }) => (
                <Ionicons 
                  name={focused ? 'time' : 'time-outline'} 
                  size={size} 
                  color={color} 
                />
              ),
            }}
          />
          <Tabs.Screen
            name="index"
            options={{
              tabBarItemStyle: { display: 'none' },
              tabBarLabel: () => null,
              tabBarIcon: () => null,
            }}
          />
        </Tabs>
      </AuthProvider>
    </SafeAreaProvider>
  );
}