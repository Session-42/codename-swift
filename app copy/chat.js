import { Redirect } from 'expo-router';
import { useAuth } from '../src/contexts/AuthContext';
import ChatView from '../src/screens/ChatView.js';

export default function Chat() {
  const { sessionToken } = useAuth();

  if (!sessionToken) {
    return <Redirect href="/" />;
  }

  return <ChatView />;
}