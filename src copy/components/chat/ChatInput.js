import React from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { LinearGradient } from 'expo-linear-gradient';
import { HitCraftColors } from '../../theme/colors';
import { HitCraftFonts } from '../../theme/typography';

export const ChatInput = ({ 
  value, 
  onChangeText, 
  onSend, 
  placeholder = "Message Max Mart...",
  containerStyle
}) => {
  return (
    <View style={[styles.container, containerStyle]}>
      <View style={styles.inputWrapper}>
        <View style={styles.inputContainer}>
          <TextInput
            style={styles.input}
            value={value}
            onChangeText={onChangeText}
            placeholder={placeholder}
            placeholderTextColor="rgba(0, 0, 0, 0.4)"
            multiline
          />
          <TouchableOpacity 
            onPress={onSend}
            style={styles.sendButton}
            disabled={!value.trim()}
            activeOpacity={0.8}
          >
            <LinearGradient
              colors={HitCraftColors.gradient.primary}
              style={styles.sendButtonGradient}
              start={{ x: 0, y: 0 }}
              end={{ x: 1, y: 0 }}
            >
              <View style={styles.iconContainer}>
                <Ionicons 
                  name="arrow-up" 
                  size={20} 
                  color="white"
                  style={{ transform: [{ rotate: '45deg' }] }}
                />
              </View>
            </LinearGradient>
          </TouchableOpacity>
        </View>
      </View>
      <View style={styles.bottomRow}>
        <TouchableOpacity style={styles.assistantButton}>
          <Text style={styles.assistantText}>Max Mart... Assistant</Text>
          <Ionicons name="chevron-down" size={12} color="rgba(0, 0, 0, 0.4)" />
        </TouchableOpacity>
        <TouchableOpacity style={styles.styleButton}>
          <Text style={styles.styleText}>Choose style</Text>
          <Ionicons name="chevron-down" size={12} color="rgba(0, 0, 0, 0.4)" />
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    width: '100%',
    backgroundColor: 'white',
    paddingTop: 16,
    paddingBottom: 12,
    borderTopLeftRadius: 25,
    borderTopRightRadius: 25,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: -2,
    },
    shadowOpacity: 0.08,
    shadowRadius: 4,
    elevation: 4,
  },
  inputWrapper: {
    width: '100%',
    paddingHorizontal: 16,
    paddingVertical: 4,
    marginBottom: 8,
  },
  inputContainer: {
    width: '100%',
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'white',
    borderRadius: 25,
    borderWidth: 1,
    borderColor: HitCraftColors.border,
    paddingLeft: 16,
    paddingRight: 6,
    paddingVertical: 6,
  },
  input: {
    flex: 1,
    ...HitCraftFonts.poppins(15, 'Light'),
    paddingVertical: 8,
    color: 'rgba(0, 0, 0, 0.8)',
    minHeight: 36,
    marginRight: 8,
  },
  sendButton: {
    width: 37,
    height: 37,
    borderRadius: 18.5,
    overflow: 'hidden',
  },
  sendButtonGradient: {
    width: '100%',
    height: '100%',
    alignItems: 'center',
    justifyContent: 'center',
  },
  iconContainer: {
    width: '100%',
    height: '100%',
    alignItems: 'center',
    justifyContent: 'center',
  },
  bottomRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    marginTop: 4,
  },
  assistantButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  styleButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  assistantText: {
    ...HitCraftFonts.poppins(12, 'Regular'),
    color: 'rgba(0, 0, 0, 0.4)',
  },
  styleText: {
    ...HitCraftFonts.poppins(12, 'Regular'),
    color: 'rgba(0, 0, 0, 0.4)',
  },
});