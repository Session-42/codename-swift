import React from 'react';
import { TouchableOpacity, Text, StyleSheet, View } from 'react-native';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';

export const ActionCard = ({ title, subtitle, onPress }) => {
  return (
    <TouchableOpacity 
      style={styles.container} 
      onPress={onPress}
      activeOpacity={0.7}
    >
      <View style={styles.content}>
        <Text style={styles.title} numberOfLines={1}>{title}</Text>
        <Text style={styles.subtitle} numberOfLines={1}>{subtitle}</Text>
      </View>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  container: {
    width: '100%',
    paddingVertical: 12,
    backgroundColor: HitCraftColors.cardBackground,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: HitCraftColors.border,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.05,
    shadowRadius: 3.84,
    elevation: 5,
  },
  content: {
    alignItems: 'center',
    justifyContent: 'center',
    gap: 2,
    paddingHorizontal: 4,
  },
  title: {
    ...HitCraftFonts.poppins(13, 'Regular'),
    color: HitCraftColors.text,
    textAlign: 'center',
  },
  subtitle: {
    ...HitCraftFonts.poppins(11, 'Light'),
    color: HitCraftColors.secondaryText,
    textAlign: 'center',
  },
});