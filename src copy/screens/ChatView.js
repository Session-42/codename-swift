import React, { useState, useEffect } from 'react';
import {
  View,
  ScrollView,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Text,
  KeyboardAvoidingView,
  Platform,
  Image,
  Alert,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useNavigation, useLocalSearchParams } from 'expo-router';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';
import { MusicianHeader } from '../components/MusicianHeader';
import { TypingIndicator } from '../components/chat/TypingIndicator';
import { useAuth } from '../contexts/AuthContext';
import { chatApi } from '../lib/api';

const AVATAR_IMAGE = require('../../assets/images/oudi.png');

export default function ChatView() {
  const [messageText, setMessageText] = useState('');
  const [messages, setMessages] = useState([]);
  const [isTyping, setIsTyping] = useState(false);
  const [threadId, setThreadId] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const insets = useSafeAreaInsets();
  const navigation = useNavigation();
  const { artistId, initialMessage } = useLocalSearchParams();
  const { signOut, user } = useAuth();

  // Initialize chat thread
  useEffect(() => {
    const initializeChat = async () => {
      try {
        setIsLoading(true);
        const response = await chatApi.create(artistId);
        setThreadId(response.threadId);
        
        // Load existing messages if any
        const messagesResponse = await chatApi.listMessages(response.threadId);
        setMessages(messagesResponse.messages.map(msg => ({
          id: msg.id,
          text: msg.content,
          isUser: msg.sender === user.id,
          timestamp: new Date(msg.createdAt)
        })));
      } catch (error) {
        console.error('Error initializing chat:', error);
        Alert.alert(
          'Error',
          'Failed to initialize chat. Please try again later.'
        );
      } finally {
        setIsLoading(false);
      }
    };

    if (artistId && !threadId) {
      initializeChat();
    }
  }, [artistId, user.id]);

  const handleSend = async () => {
    if (!messageText.trim() || !threadId) return;

    const tempMessageId = Date.now().toString();
    const newMessage = {
      id: tempMessageId,
      text: messageText,
      isUser: true,
      pending: true
    };

    setMessages(prev => [...prev, newMessage]);
    setMessageText('');
    setIsTyping(true);

    try {
      const response = await chatApi.sendMessage(threadId, messageText.trim());
      
      // Update the temporary message with the real one
      setMessages(prev => prev.map(msg => 
        msg.id === tempMessageId 
          ? {
              id: response.id,
              text: response.content,
              isUser: true,
              timestamp: new Date(response.createdAt)
            }
          : msg
      ));

      // Simulate typing indicator before showing response
      setTimeout(() => {
        setIsTyping(false);
        // In a real implementation, the response would come from the server
        // This is just for demonstration
        setMessages(prev => [...prev, {
          id: (Date.now() + 1).toString(),
          text: "I understand you're interested in music production. Let me help you with that!",
          isUser: false,
          timestamp: new Date()
        }]);
      }, 2000);
    } catch (error) {
      console.error('Error sending message:', error);
      // Remove the pending message
      setMessages(prev => prev.filter(msg => msg.id !== tempMessageId));
      Alert.alert(
        'Error',
        'Failed to send message. Please try again.'
      );
      setIsTyping(false);
    }
  };

  return (
    <View style={[styles.container, { paddingTop: insets.top }]}>
      <View style={styles.header}>
        <TouchableOpacity 
          style={styles.backButton}
          onPress={() => navigation.goBack()}
        >
          <Ionicons name="arrow-back" size={24} color={HitCraftColors.text} />
        </TouchableOpacity>
        <MusicianHeader
          title="CHAT"
          showSwitchOption={true}
        />
        <TouchableOpacity 
          style={styles.signOutButton}
          onPress={signOut}
        >
          <Ionicons name="log-out-outline" size={24} color={HitCraftColors.accent} />
        </TouchableOpacity>
      </View>

      <KeyboardAvoidingView 
        style={styles.content} 
        behavior={Platform.OS === 'ios' ? 'padding' : undefined}
      >
        <ScrollView 
          style={styles.messagesContainer}
          contentContainerStyle={styles.messagesContent}
        >
          {messages.map(message => (
            <View 
              key={message.id}
              style={[
                styles.messageBubble,
                message.isUser ? styles.userMessage : styles.botMessage,
                message.pending && styles.pendingMessage
              ]}
            >
              {message.isUser && (
                <Image
                  source={AVATAR_IMAGE}
                  style={styles.avatar}
                  resizeMode="contain"
                />
              )}
              <Text style={styles.messageText}>{message.text}</Text>
            </View>
          ))}
          {isTyping && (
            <View style={[styles.messageBubble, styles.botMessage]}>
              <TypingIndicator />
            </View>
          )}
        </ScrollView>

        <View style={styles.inputContainer}>
          <TextInput
            style={styles.input}
            value={messageText}
            onChangeText={setMessageText}
            placeholder="Type your message..."
            placeholderTextColor={HitCraftColors.secondaryText}
            multiline
            editable={!isLoading}
          />
          <TouchableOpacity
            style={styles.sendButton}
            onPress={handleSend}
            disabled={!messageText.trim() || isLoading}
          >
            <Ionicons
              name="send"
              size={24}
              color={messageText.trim() && !isLoading ? HitCraftColors.accent : HitCraftColors.secondaryText}
            />
          </TouchableOpacity>
        </View>
      </KeyboardAvoidingView>
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
    justifyContent: 'space-between',
    paddingHorizontal: 16,
  },
  backButton: {
    padding: 8,
  },
  signOutButton: {
    padding: 8,
  },
  content: {
    flex: 1,
  },
  messagesContainer: {
    flex: 1,
    paddingHorizontal: 10,
  },
  messagesContent: {
    paddingVertical: 10,
  },
  messageBubble: {
    width: '100%',
    minHeight: 60,
    marginVertical: 5,
    borderRadius: 17,
    flexDirection: 'row',
    alignItems: 'center',
  },
  userMessage: {
    backgroundColor: '#f1e4e9',
    paddingLeft: 8,
    paddingRight: 29,
    paddingVertical: 10,
  },
  botMessage: {
    backgroundColor: '#efe9f4',
    paddingLeft: 17,
    paddingRight: 29,
    paddingVertical: 10,
  },
  pendingMessage: {
    opacity: 0.7,
  },
  messageText: {
    flex: 1,
    fontFamily: 'Poppins',
    fontSize: 15,
    fontWeight: '300',
    lineHeight: 24,
    color: '#424246',
  },
  avatar: {
    width: 36,
    height: 36,
    margin: 2.5,
    marginRight: 6.5,
    marginBottom: 2,
    borderRadius: 18,
  },
  inputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: HitCraftColors.border,
    backgroundColor: '#FFFFFF',
  },
  input: {
    flex: 1,
    fontFamily: 'Poppins',
    fontSize: 15,
    fontWeight: '300',
    backgroundColor: '#F8F8F8',
    borderRadius: 20,
    paddingHorizontal: 16,
    paddingVertical: 8,
    marginRight: 8,
    maxHeight: 100,
    color: '#424246',
  },
  sendButton: {
    padding: 8,
  },
});