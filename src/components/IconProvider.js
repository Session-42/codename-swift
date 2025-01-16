import React from 'react';
import { View, ActivityIndicator } from 'react-native';
import Ionicons from 'react-native-vector-icons/Ionicons';

// Create a component that provides icons throughout the app
export const Icon = ({ name, size = 24, color = 'black', ...props }) => {
  return <Ionicons name={name} size={size} color={color} {...props} />;
};

export function IconProvider({ children }) {
  return children;
}

// Export commonly used icons for convenience
export const Icons = {
  home: (props) => <Icon name="home" {...props} />,
  chat: (props) => <Icon name="chatbubble" {...props} />,
  library: (props) => <Icon name="library" {...props} />,
  history: (props) => <Icon name="time" {...props} />,
  menu: (props) => <Icon name="menu" {...props} />,
  close: (props) => <Icon name="close" {...props} />,
  send: (props) => <Icon name="arrow-up" {...props} />,
  chevronDown: (props) => <Icon name="chevron-down" {...props} />,
  person: (props) => <Icon name="person-circle" {...props} />,
  play: (props) => <Icon name="play" {...props} />,
  checkmark: (props) => <Icon name="checkmark" {...props} />,
};