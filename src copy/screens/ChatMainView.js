import React, { useState, useMemo } from 'react';
import {
  View,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Dimensions,
  Text,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useRouter } from 'expo-router';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';
import { ActionCard } from '../components/ActionCard';
import { MusicianHeader } from '../components/MusicianHeader';
import { useAuth } from '../contexts/AuthContext';

const { width: SCREEN_WIDTH } = Dimensions.get('window');
const CARD_GAP = 8;
const HORIZONTAL_PADDING = 20;
const CARD_WIDTH = (SCREEN_WIDTH - (2 * HORIZONTAL_PADDING) - (2 * CARD_GAP)) / 3;

export const ChatMainView = () => {
  const [messageText, setMessageText] = useState('');
  const insets = useSafeAreaInsets();
  const router = useRouter();
  const { signOut, user } = useAuth();

  const greeting = useMemo(() => {
    const hour = new Date().getHours();
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }, []);

  const handleSendMessage = () => {
    if (messageText.trim()) {
      router.push({
        pathname: '/chat',
        params: { initialMessage: messageText }
      });
      setMessageText('');
    }
  };

  const navigateToChat = (message) => {
    router.push({
      pathname: '/chat',
      params: { initialMessage: message }
    });
  };

  return (
    <View style={[styles.container, { paddingTop: insets.top }]}>
      <View style={styles.header}>
        <MusicianHeader
          title="TalentGPT™"
          showSwitchOption={true}
        />
        <TouchableOpacity 
          style={styles.signOutButton}
          onPress={signOut}
        >
          <Ionicons name="log-out-outline" size={24} color={HitCraftColors.accent} />
        </TouchableOpacity>
      </View>

      {/* Greeting */}
      <View style={styles.greetingContainer}>
        <Text style={styles.greetingText}>{greeting}</Text>
        <Text style={styles.nameText}>{user?.name || 'there'}</Text>
      </View>

      {/* Action Cards */}
      <View style={styles.actionCardsContainer}>
        <View style={styles.actionCards}>
          <View style={styles.actionCardWrapper}>
            <ActionCard
              title="Produce"
              subtitle="Song"
              onPress={() => navigateToChat("I want to produce a new song. Can you help me?")}
            />
          </View>
          <View style={styles.actionCardWrapper}>
            <ActionCard
              title="Unblock"
              subtitle="Creativity"
              onPress={() => navigateToChat("I need help unblocking my creativity. Can you help me?")}
            />
          </View>
          <View style={styles.actionCardWrapper}>
            <ActionCard
              title="Ask"
              subtitle="Advise"
              onPress={() => navigateToChat("I need advice about my music project")}
            />
          </View>
        </View>
      </View>

      {/* Chat Input */}
      <View style={[styles.bottomContainer, { bottom: 5 }]}>
        <View style={styles.inputWrapper}>
          <TextInput
            style={styles.input}
            value={messageText}
            onChangeText={setMessageText}
            placeholder="How can I help you make some music today?"
            placeholderTextColor={HitCraftColors.secondaryText}
            onSubmitEditing={handleSendMessage}
          />
          <TouchableOpacity
            style={styles.sendButton}
            onPress={handleSendMessage}
          >
            <View style={styles.sendIconContainer}>
              <Ionicons
                name="arrow-up"
                size={20}
                color="white"
              />
            </View>
          </TouchableOpacity>
        </View>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: HitCraftColors.background,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingRight: 16,
  },
  signOutButton: {
    padding: 8,
    position: 'absolute',
    right: 16,
  },
  greetingContainer: {
    position: 'absolute',
    top: '40%',
    left: 0,
    right: 0,
    alignItems: 'center',
    gap: 8,
  },
  greetingText: {
    ...HitCraftFonts.poppins(48, 'Medium'),
    color: HitCraftColors.text,
    textAlign: 'center',
  },
  nameText: {
    ...HitCraftFonts.poppins(24, 'Medium'),
    color: HitCraftColors.text,
    textAlign: 'center',
  },
  actionCardsContainer: {
    position: 'absolute',
    bottom: 82,
    left: 0,
    right: 0,
    backgroundColor: HitCraftColors.background,
    paddingHorizontal: HORIZONTAL_PADDING,
    paddingVertical: 10,
  },
  actionCards: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  actionCardWrapper: {
    width: CARD_WIDTH,
  },
  bottomContainer: {
    position: 'absolute',
    left: 0,
    right: 0,
    backgroundColor: HitCraftColors.background,
    borderTopWidth: 1,
    borderTopColor: HitCraftColors.border,
    paddingHorizontal: 20,
    paddingVertical: 10,
  },
  inputWrapper: {
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
    marginRight: 6,
  },
  sendButton: {
    width: 37,
    height: 37,
    borderRadius: 18.5,
    overflow: 'hidden',
  },
  sendIconContainer: {
    width: '100%',
    height: '100%',
    backgroundColor: HitCraftColors.accent,
    borderRadius: 18.5,
    justifyContent: 'center',
    alignItems: 'center',
  },
});