import React from 'react';
import { View, TextInput, TouchableOpacity, StyleSheet, Text } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';

export const ChatInput = ({ 
  value, 
  onChangeText, 
  onSend, 
  placeholder = "Message Max Mart..." 
}) => (
  <View style={styles.container}>
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
        >
          <LinearGradient
            colors={['#B23594', '#9B4D96']}
            style={styles.sendButtonGradient}
            start={{ x: 0, y: 0 }}
            end={{ x: 1, y: 0 }}
          >
            <View style={styles.iconContainer}>
              <Ionicons 
                name="arrow-up" 
                size={20} 
                color="white"
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
    paddingLeft: 4,
  },
  input: {
    flex: 1,
    ...HitCraftFonts.poppins(15, 'Light'),
    paddingVertical: 8,
    color: 'rgba(0, 0, 0, 0.8)',
    minHeight: 36,
  },
  sendButton: {
    width: 32,
    height: 32,
    borderRadius: 16,
    overflow: 'hidden',
    marginLeft: 8,
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
    paddingTop: 2,
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