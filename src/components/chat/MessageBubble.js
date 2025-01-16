import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { HitCraftColors } from '../../theme/colors';
import { HitCraftFonts } from '../../theme/typography';

export const MessageBubble = ({ text, isFromUser }) => {
  return (
    <View style={[
      styles.container,
      { backgroundColor: HitCraftColors.background }
    ]}>
      <View style={[
        styles.bubble,
        isFromUser ? styles.userBubble : styles.botBubble,
      ]}>
        {isFromUser && (
          <View style={styles.avatarContainer}>
            <Ionicons
              name="person-circle"
              size={32}
              color="rgba(0, 0, 0, 0.4)"
            />
          </View>
        )}
        <View style={[
          styles.textContainer,
          isFromUser ? styles.userTextContainer : styles.botTextContainer
        ]}>
          <Text style={[
            styles.text,
            isFromUser ? styles.userText : styles.botText
          ]}>{text}</Text>
        </View>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    paddingHorizontal: 16,
    marginBottom: 16,
    width: '100%',
  },
  bubble: {
    maxWidth: '85%',
    flexDirection: 'row',
    alignItems: 'flex-start',
  },
  userBubble: {
    marginLeft: 'auto',
    backgroundColor: '#F1E4E9',
    borderRadius: 20,
    borderTopRightRadius: 4,
    padding: 12,
  },
  botBubble: {
    marginRight: 'auto',
    backgroundColor: '#EFE9F4',
    borderRadius: 20,
    borderTopLeftRadius: 4,
    padding: 12,
  },
  avatarContainer: {
    marginRight: 8,
    alignItems: 'center',
    justifyContent: 'center',
  },
  textContainer: {
    flex: 1,
  },
  userTextContainer: {
    paddingRight: 4,
  },
  botTextContainer: {
    paddingLeft: 4,
  },
  text: {
    ...HitCraftFonts.poppins(15, 'Light'),
    lineHeight: 24,
    letterSpacing: 0,
  },
  userText: {
    color: '#424246',
  },
  botText: {
    color: '#424246',
  },
});