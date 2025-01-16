import React from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';

const RecentChatCard = ({ title, time, onPress }) => {
  return (
    <TouchableOpacity
      style={styles.cardContainer}
      onPress={onPress}
      activeOpacity={0.7}
    >
      <View style={styles.cardContent}>
        <Text style={styles.cardTitle}>{title}</Text>
        <View style={styles.timeContainer}>
          <Ionicons name="time-outline" size={14} color="gray" />
          <Text style={styles.timeText}>{time}</Text>
        </View>
      </View>
    </TouchableOpacity>
  );
};

export const RecentChatsGrid = () => {
  const recentChats = [
    {
      id: '1',
      title: "Need help with my 2nd verse...",
      time: "1 day ago"
    },
    {
      id: '2',
      title: "Catchy drop ideas",
      time: "3 days ago"
    },
    {
      id: '3',
      title: "Pop ballad production",
      time: "4 days ago"
    }
  ];

  return (
    <View style={styles.container}>
      {recentChats.map((chat) => (
        <RecentChatCard
          key={chat.id}
          title={chat.title}
          time={chat.time}
          onPress={() => console.log('Chat pressed:', chat.title)}
        />
      ))}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    gap: 12,
  },
  cardContainer: {
    backgroundColor: 'white',
    borderRadius: 12,
    borderWidth: 1,
    borderColor: HitCraftColors.border,
    padding: 16,
  },
  cardContent: {
    gap: 8,
  },
  cardTitle: {
    ...HitCraftFonts.poppins(14, 'Light'),
    color: HitCraftColors.text,
  },
  timeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  timeText: {
    ...HitCraftFonts.poppins(12, 'Light'),
    color: 'gray',
  },
});