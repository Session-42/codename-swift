import { useState, useCallback } from 'react';

export const useChat = (initialMessages = []) => {
  const [messages, setMessages] = useState(initialMessages);
  const [isTyping, setIsTyping] = useState(false);

  const getBotResponse = (userMessage) => {
    if (userMessage.toLowerCase().includes('help')) {
      return "I'll be happy to help! Could you tell me more about what you're looking to achieve?";
    }
    if (userMessage.toLowerCase().includes('music')) {
      return "Music is what I do best! Let's explore some ideas together. What genre or style interests you?";
    }
    const responses = [
      "That's interesting! Let's explore this idea further. What specific aspects would you like to focus on?",
      "I understand what you're looking for. Here's what we can do...",
      "Great question! Let me help you with that. First, let's consider...",
      "I can definitely assist with that. Would you like to try a specific approach?"
    ];
    return responses[Math.floor(Math.random() * responses.length)];
  };

  const sendMessage = useCallback((text, isFromUser = true) => {
    const newMessage = {
      id: Date.now().toString(),
      text,
      isFromUser,
      timestamp: new Date(),
    };
    
    setMessages(prev => [...prev, newMessage]);

    // Simulate bot response
    if (isFromUser) {
      setIsTyping(true);
      setTimeout(() => {
        const botResponse = {
          id: (Date.now() + 1).toString(),
          text: getBotResponse(text),
          isFromUser: false,
          timestamp: new Date(),
        };
        setMessages(prev => [...prev, botResponse]);
        setIsTyping(false);
      }, 1500);
    }
  }, []);

  return {
    messages,
    isTyping,
    sendMessage,
  };
};