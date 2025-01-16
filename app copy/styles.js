import { Redirect } from 'expo-router';
import { useAuth } from '../src/contexts/AuthContext';
import StylesView from '../src/screens/StylesView.js';

export default function Styles() {
  const { sessionToken } = useAuth();

  if (!sessionToken) {
    return <Redirect href="/" />;
  }

  return <StylesView />;
}