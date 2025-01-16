import React, { useState, useRef } from 'react';
import {
  View,
  ScrollView,
  StyleSheet,
  KeyboardAvoidingView,
  Platform,
  Modal,
  TouchableOpacity,
  Text,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';
import { MusicianHeader } from '../components/MusicianHeader';
import { MessageBubble } from '../components/chat/MessageBubble';
import { ChatInput } from '../components/chat/ChatInput';
import { TypingIndicator } from '../components/chat/TypingIndicator';
import { chatApi } from '../lib/api-client';

const ASSISTANT_TYPES = [
  'General Assistant',
  'Music Producer',
  'Lyricist',
  'Sound Engineer'
];

const CHAT_STYLES = [
  'Professional',
  'Casual',
  'Technical',
  'Creative'
];

export default function ChatView({ selectedMusician = 'Hitcraft' }) {
  const [messages, setMessages] = useState([
    { id: '1', text: "Hi! I'm Hitcraft AI. How can I help you today?", isFromUser: false },
  ]);
  const [inputText, setInputText] = useState('');
  const [isTyping, setIsTyping] = useState(false);
  const [showAssistantModal, setShowAssistantModal] = useState(false);
  const [showStyleModal, setShowStyleModal] = useState(false);
  const [selectedAssistant, setSelectedAssistant] = useState('General Assistant');
  const [selectedStyle, setSelectedStyle] = useState('Professional');
  
  const insets = useSafeAreaInsets();
  const scrollViewRef = useRef();

  const handleSend = async () => {
    if (!inputText.trim()) return;

    const newMessage = {
      id: Date.now().toString(),
      text: inputText.trim(),
      isFromUser: true,
    };

    setMessages(prev => [...prev, newMessage]);
    setInputText('');
    setIsTyping(true);

    try {
      const response = await chatApi.sendMessage('offline-default', newMessage.text);
      setIsTyping(false);
      
      if (response) {
        const aiResponse = {
          id: (Date.now() + 1).toString(),
          text: response.content || "I'm here to help you with your music!",
          isFromUser: false,
        };
        setMessages(prev => [...prev, aiResponse]);
      }
    } catch (error) {
      console.error('Error sending message:', error);
      setIsTyping(false);
      
      if (__DEV__) {
        const mockResponse = {
          id: (Date.now() + 1).toString(),
          text: "I'm in development mode, but I'll help you as best I can!",
          isFromUser: false,
        };
        setMessages(prev => [...prev, mockResponse]);
      }
    }
  };

  const renderModal = (visible, onClose, title, options, selectedOption, onSelect) => (
    <Modal
      visible={visible}
      transparent
      animationType="slide"
      onRequestClose={onClose}
    >
      <TouchableOpacity 
        style={styles.modalOverlay}
        activeOpacity={1}
        onPress={onClose}
      >
        <View style={styles.modalContent}>
          <Text style={styles.modalTitle}>{title}</Text>
          {options.map((option) => (
            <TouchableOpacity
              key={option}
              style={[
                styles.modalOption,
                selectedOption === option && styles.selectedOption
              ]}
              onPress={() => {
                onSelect(option);
                onClose();
              }}
            >
              <Text style={[
                styles.modalOptionText,
                selectedOption === option && styles.selectedOptionText
              ]}>
                {option}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </TouchableOpacity>
    </Modal>
  );

  return (
    <KeyboardAvoidingView
      style={[styles.container, { paddingTop: insets.top }]}
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      keyboardVerticalOffset={Platform.OS === 'ios' ? 90 : 0}
    >
      <MusicianHeader
        title="CHAT"
        showSwitchOption={true}
        selectedMusician={selectedMusician}
      />

      <ScrollView
        ref={scrollViewRef}
        style={styles.messagesContainer}
        onContentSizeChange={() => scrollViewRef.current?.scrollToEnd({ animated: true })}
      >
        {messages.map((message) => (
          <MessageBubble
            key={message.id}
            text={message.text}
            isFromUser={message.isFromUser}
          />
        ))}
        {isTyping && (
          <View style={styles.typingContainer}>
            <TypingIndicator />
          </View>
        )}
      </ScrollView>

      <ChatInput
        value={inputText}
        onChangeText={setInputText}
        onSend={handleSend}
        placeholder={`Message ${selectedMusician}...`}
        selectedMusician={selectedMusician}
        onAssistantPress={() => setShowAssistantModal(true)}
        onStylePress={() => setShowStyleModal(true)}
      />

      {renderModal(
        showAssistantModal,
        () => setShowAssistantModal(false),
        'Select Assistant Type',
        ASSISTANT_TYPES,
        selectedAssistant,
        setSelectedAssistant
      )}

      {renderModal(
        showStyleModal,
        () => setShowStyleModal(false),
        'Select Chat Style',
        CHAT_STYLES,
        selectedStyle,
        setSelectedStyle
      )}
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: HitCraftColors.background,
  },
  messagesContainer: {
    flex: 1,
    paddingTop: 10,
  },
  typingContainer: {
    paddingHorizontal: 16,
    paddingVertical: 8,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'flex-end',
  },
  modalContent: {
    backgroundColor: 'white',
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    padding: 20,
    maxHeight: '80%',
  },
  modalTitle: {
    ...HitCraftFonts.poppins(18, 'Medium'),
    textAlign: 'center',
    marginBottom: 20,
  },
  modalOption: {
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderRadius: 8,
    marginBottom: 8,
  },
  selectedOption: {
    backgroundColor: HitCraftColors.cardBackground,
  },
  modalOptionText: {
    ...HitCraftFonts.poppins(16, 'Regular'),
    color: HitCraftColors.text,
  },
  selectedOptionText: {
    color: HitCraftColors.accent,
  },
});