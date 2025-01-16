import { Redirect } from 'expo-router';
import { useAuth } from '../src/contexts/AuthContext';
import { ChatMainView } from '../src/screens/ChatMainView';

export default function Home() {
  const { sessionToken } = useAuth();

  if (!sessionToken) {
    return <Redirect href="/" />;
  }

  return <ChatMainView />;
}