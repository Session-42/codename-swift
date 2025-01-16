import React, { useState, useMemo } from 'react';
import {
  View,
  ScrollView,
  StyleSheet,
  Text,
  TouchableOpacity,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';
import { ActionCard } from '../components/ActionCard';
import { MusicianHeader } from '../components/MusicianHeader';
import { ChatInput } from '../components/chat/ChatInput';
import { chatApi } from '../lib/api-client';

const DEFAULT_MUSICIAN = {
  id: 'hitcraft',
  name: 'Hitcraft',
  iconAsset: 'hiti2',
};

export default function ChatMainView({ onShowSidebar }) {
  const [messageText, setMessageText] = useState('');
  const [selectedMusician, setSelectedMusician] = useState(DEFAULT_MUSICIAN);
  const insets = useSafeAreaInsets();
  const router = useRouter();

  const greeting = useMemo(() => {
    const hour = new Date().getHours();
    if (hour < 12) return 'GOOD MORNING';
    if (hour < 17) return 'GOOD AFTERNOON';
    return 'GOOD EVENING';
  }, []);

  const handleSendMessage = async () => {
    if (!messageText.trim()) return;

    try {
      const response = await chatApi.create(selectedMusician.id);
      const threadId = response?.threadId;

      if (threadId) {
        router.push({
          pathname: `/chat/${selectedMusician.id}`,
          params: { 
            initialMessage: messageText,
            threadId: threadId
          }
        });
        setMessageText('');
      }
    } catch (error) {
      console.error('Failed to create chat:', error);
      if (__DEV__) {
        router.push({
          pathname: `/chat/${selectedMusician.id}`,
          params: { 
            initialMessage: messageText,
            threadId: 'offline-default'
          }
        });
        setMessageText('');
      }
    }
  };

  const navigateToChat = async (message) => {
    try {
      const response = await chatApi.create(selectedMusician.id);
      const threadId = response?.threadId;

      if (threadId) {
        router.push({
          pathname: `/chat/${selectedMusician.id}`,
          params: { 
            initialMessage: message,
            threadId: threadId
          }
        });
      }
    } catch (error) {
      console.error('Failed to create chat:', error);
      if (__DEV__) {
        router.push({
          pathname: `/chat/${selectedMusician.id}`,
          params: { 
            initialMessage: message,
            threadId: 'offline-default'
          }
        });
      }
    }
  };

  return (
    <View style={[styles.container, { paddingTop: insets.top }]}>
      {/* Header with hamburger menu */}
      <View style={styles.header}>
        <TouchableOpacity 
          style={styles.menuButton}
          onPress={onShowSidebar}
        >
          <Ionicons name="menu" size={24} color={HitCraftColors.text} />
        </TouchableOpacity>
        <MusicianHeader
          title="TalentGPT™"
          showSwitchOption={true}
          showTalentGPT={true}
          selectedMusician={selectedMusician}
          onMusicianChange={setSelectedMusician}
        />
      </View>

      <ScrollView style={styles.content}>
        {/* Greeting */}
        <View style={styles.greetingContainer}>
          <Text style={styles.greetingText}>{greeting}</Text>
          <Text style={styles.nameText}>SANDMAN</Text>
        </View>

        {/* Action Cards */}
        <View style={styles.cardsContainer}>
          <ActionCard
            title="Browse Music"
            subtitle="& Produce"
            onPress={() => navigateToChat("I want to browse music and produce something new")}
          />
          <ActionCard
            title="Let's collaborate & make"
            subtitle="your next song together"
            onPress={() => navigateToChat("I want to collaborate and make a new song. Can you help me?")}
          />
          <ActionCard
            title="Get guidance, help and"
            subtitle="sounds for your project"
            onPress={() => navigateToChat("I need guidance and help finding sounds for my project")}
          />
        </View>

        {/* Recent Chats */}
        <View style={styles.recentChatsContainer}>
          <View style={styles.recentChatsHeader}>
            <Text style={styles.recentChatsTitle}>Your recent chats</Text>
            <TouchableOpacity onPress={() => router.push('/history')}>
              <Text style={styles.viewAllText}>View all →</Text>
            </TouchableOpacity>
          </View>

          <View style={styles.chatsList}>
            {['Need help with my 2nd verse...', 'Catchy drop ideas', 'Pop ballad production'].map((title, index) => (
              <TouchableOpacity
                key={index}
                style={styles.chatCard}
                onPress={() => navigateToChat(title)}
              >
                <Text style={styles.chatTitle}>{title}</Text>
                <View style={styles.timeContainer}>
                  <Ionicons name="time-outline" size={12} color={HitCraftColors.secondaryText} />
                  <Text style={styles.timeText}>{`${index + 1} day${index !== 0 ? 's' : ''} ago`}</Text>
                </View>
              </TouchableOpacity>
            ))}
          </View>
        </View>
      </ScrollView>

      {/* Chat Input */}
      <ChatInput
        value={messageText}
        onChangeText={setMessageText}
        onSend={handleSendMessage}
        placeholder="How can I help you make some music today?"
        selectedMusician={selectedMusician.name}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: HitCraftColors.background,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 12,
    backgroundColor: 'white',
    borderBottomWidth: 1,
    borderBottomColor: HitCraftColors.border,
  },
  menuButton: {
    padding: 8,
    marginRight: 8,
  },
  content: {
    flex: 1,
  },
  greetingContainer: {
    alignItems: 'center',
    marginTop: 40,
    marginBottom: 32,
  },
  greetingText: {
    ...HitCraftFonts.poppins(32, 'Light'),
    color: HitCraftColors.text,
  },
  nameText: {
    ...HitCraftFonts.poppins(32, 'Bold'),
    color: HitCraftColors.text,
    marginTop: 8,
  },
  cardsContainer: {
    paddingHorizontal: 20,
    gap: 12,
  },
  recentChatsContainer: {
    paddingHorizontal: 20,
    marginTop: 32,
  },
  recentChatsHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
  },
  recentChatsTitle: {
    ...HitCraftFonts.poppins(14, 'Medium'),
    color: HitCraftColors.text,
  },
  viewAllText: {
    ...HitCraftFonts.poppins(14, 'Regular'),
    color: HitCraftColors.accent,
  },
  chatsList: {
    gap: 12,
  },
  chatCard: {
    backgroundColor: 'white',
    borderRadius: 12,
    padding: 16,
    borderWidth: 1,
    borderColor: HitCraftColors.border,
  },
  chatTitle: {
    ...HitCraftFonts.poppins(14, 'Light'),
    color: HitCraftColors.text,
    marginBottom: 8,
  },
  timeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  timeText: {
    ...HitCraftFonts.poppins(12, 'Light'),
    color: HitCraftColors.secondaryText,
  },
});