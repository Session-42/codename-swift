import { Redirect } from 'expo-router';
import { useAuth } from '../src/contexts/AuthContext';
import HistoryView from '../src/screens/HistoryView.js';

export default function History() {
  const { sessionToken } = useAuth();

  if (!sessionToken) {
    return <Redirect href="/" />;
  }

  return <HistoryView />;
}