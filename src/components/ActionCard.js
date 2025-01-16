import React from 'react';
import {
  TouchableOpacity,
  View,
  Text,
  StyleSheet,
} from 'react-native';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';

export function ActionCard({ title, subtitle, onPress }) {
  return (
    <TouchableOpacity
      style={styles.container}
      onPress={onPress}
      activeOpacity={0.7}
    >
      <View style={styles.content}>
        <Text style={styles.title}>{title}</Text>
        <Text style={styles.subtitle}>{subtitle}</Text>
      </View>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 12,
    height: 90,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 3,
    elevation: 3,
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  title: {
    ...HitCraftFonts.poppins(16, 'Medium'),
    color: HitCraftColors.text,
    textAlign: 'center',
    marginBottom: 4,
  },
  subtitle: {
    ...HitCraftFonts.poppins(14, 'Light'),
    color: HitCraftColors.secondaryText,
    textAlign: 'center',
  },
});