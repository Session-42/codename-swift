import { Stack, Redirect } from 'expo-router';
import { useAuth } from '../src/contexts/AuthContext';
import LoginScreen from '../src/screens/LoginScreen';

export default function App() {
  const { sessionToken } = useAuth();

  if (sessionToken) {
    return <Redirect href="/home" />;
  }

  return <LoginScreen />;
}