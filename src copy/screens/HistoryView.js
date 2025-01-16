import React, { useState, useRef, useEffect } from 'react';
import {
  View,
  ScrollView,
  TextInput,
  TouchableOpacity,
  Text,
  StyleSheet,
  Animated,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';
import { MusicianHeader } from '../components/MusicianHeader';

const ChatHistoryItem = ({ 
  item, 
  isExpanded, 
  onPress,
  onNavigate,
}) => {
  const animatedHeight = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.timing(animatedHeight, {
      toValue: isExpanded ? 1 : 0,
      duration: 200,
      useNativeDriver: false,
    }).start();
  }, [isExpanded]);

  return (
    <TouchableOpacity
      style={styles.historyItem}
      onPress={onPress}
      activeOpacity={0.7}
    >
      <View style={styles.itemHeader}>
        <Ionicons 
          name="chatbubble-outline" 
          size={20} 
          color={HitCraftColors.text} 
          style={styles.chatIcon}
        />
        <Text style={styles.itemTitle}>{item.title}</Text>
      </View>

      <Animated.View style={{
        maxHeight: animatedHeight.interpolate({
          inputRange: [0, 1],
          outputRange: [0, 200],
        }),
        opacity: animatedHeight,
        overflow: 'hidden',
      }}>
        {item.details && (
          <View style={styles.detailsContainer}>
            <DetailRow title="Plugin name" value={item.details.pluginName} />
            <DetailRow title="Year" value={item.details.year} />
            <DetailRow 
              title="Link to preset" 
              value={item.details.presetLink} 
              isLink
            />
            <TouchableOpacity 
              style={styles.navigateButton}
              onPress={onNavigate}
            >
              <Text style={styles.navigateText}>Take me to this Chat</Text>
              <Ionicons 
                name="arrow-forward" 
                size={16} 
                color={HitCraftColors.accent}
              />
            </TouchableOpacity>
          </View>
        )}
      </Animated.View>
    </TouchableOpacity>
  );
};

const DetailRow = ({ title, value, isLink = false }) => (
  <View style={styles.detailRow}>
    <Text style={styles.detailTitle}>{title}</Text>
    <Text style={[
      styles.detailValue,
      isLink && styles.detailValueLink
    ]}>{value}</Text>
  </View>
);

export default function HistoryView() {
  const insets = useSafeAreaInsets();
  const [searchText, setSearchText] = useState('');
  const [expandedItemId, setExpandedItemId] = useState(null);

  const sampleChatItems = [
    {
      id: '1',
      title: "Need help with my 2nd verse lyrics",
      details: null,
    },
    {
      id: '2',
      title: "I need some help with good presets for my kick drum sound",
      details: {
        pluginName: "12/07/92",
        year: "2003",
        presetLink: "https://knightsoftheedit..."
      },
    },
    {
      id: '3',
      title: "Catchy drop ideas",
      details: null,
    },
    {
      id: '4',
      title: "Pop ballad production",
      details: null,
    },
    {
      id: '5',
      title: "Recommend the right tempo for my song",
      details: null,
    },
  ];

  const filteredItems = sampleChatItems.filter(item =>
    item.title.toLowerCase().includes(searchText.toLowerCase())
  );

  return (
    <View style={[styles.container, { paddingTop: insets.top }]}>
      <MusicianHeader
        title="HISTORY"
        showSwitchOption={true}
        showTalentGPT={false}
      />

      <View style={styles.searchContainer}>
        <Ionicons 
          name="search" 
          size={20} 
          color="gray" 
          style={styles.searchIcon}
        />
        <TextInput
          style={styles.searchInput}
          value={searchText}
          onChangeText={setSearchText}
          placeholder="Search chats..."
          placeholderTextColor="gray"
        />
      </View>

      <ScrollView style={styles.scrollView}>
        <View style={styles.historyList}>
          {filteredItems.map((item) => (
            <ChatHistoryItem
              key={item.id}
              item={item}
              isExpanded={expandedItemId === item.id}
              onPress={() => {
                setExpandedItemId(
                  expandedItemId === item.id ? null : item.id
                );
              }}
              onNavigate={() => {
                console.log('Navigate to chat:', item.id);
              }}
            />
          ))}
        </View>
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: HitCraftColors.background,
  },
  searchContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    margin: 20,
    paddingHorizontal: 16,
    paddingVertical: 12,
    backgroundColor: 'white',
    borderRadius: 25,
    borderWidth: 1,
    borderColor: HitCraftColors.border,
  },
  searchIcon: {
    marginRight: 8,
  },
  searchInput: {
    flex: 1,
    ...HitCraftFonts.poppins(15, 'Light'),
  },
  scrollView: {
    flex: 1,
  },
  historyList: {
    padding: 20,
    gap: 15,
  },
  historyItem: {
    backgroundColor: HitCraftColors.background,
    borderRadius: 14,
    borderWidth: 1,
    borderColor: HitCraftColors.border,
    padding: 19,
  },
  itemHeader: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: 12,
  },
  chatIcon: {
    marginTop: 2,
  },
  itemTitle: {
    flex: 1,
    ...HitCraftFonts.poppins(14, 'Light'),
    lineHeight: 20,
  },
  detailsContainer: {
    marginTop: 12,
    marginLeft: 32,
    gap: 8,
  },
  detailRow: {
    gap: 4,
  },
  detailTitle: {
    ...HitCraftFonts.poppins(12, 'Light'),
    color: 'gray',
  },
  detailValue: {
    ...HitCraftFonts.poppins(14, 'Light'),
  },
  detailValueLink: {
    color: 'blue',
  },
  navigateButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    marginTop: 4,
  },
  navigateText: {
    ...HitCraftFonts.poppins(14, 'Medium'),
    color: HitCraftColors.accent,
  },
});