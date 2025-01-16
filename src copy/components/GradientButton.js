import React from 'react';
import { TouchableOpacity, Text, StyleSheet } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';

export const GradientButton = ({ 
  title, 
  icon, 
  onPress,
  disabled = false,
  style
}) => {
  return (
    <TouchableOpacity 
      onPress={onPress}
      disabled={disabled}
      activeOpacity={0.8}
      style={[styles.buttonContainer, style]}
    >
      <LinearGradient
        colors={HitCraftColors.gradient.primary}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 0 }}
        style={styles.gradient}
      >
        {icon && (
          <Ionicons 
            name={icon} 
            size={14} 
            color="white" 
            style={styles.icon}
          />
        )}
        <Text style={styles.title}>{title}</Text>
      </LinearGradient>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  buttonContainer: {
    overflow: 'hidden',
    borderRadius: 25,
  },
  gradient: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: 24,
    paddingVertical: 12,
  },
  icon: {
    marginRight: 8,
  },
  title: {
    ...HitCraftFonts.poppins(14, 'Medium'),
    color: 'white',
  },
});