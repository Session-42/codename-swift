import React, { useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Image,
  Dimensions,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';
import { MusicianHeader } from '../components/MusicianHeader';

const SCREEN_WIDTH = Dimensions.get('window').width;
const GRID_SPACING = 16;
const CARD_WIDTH = (SCREEN_WIDTH - (3 * GRID_SPACING)) / 2;

const StyleCard = ({ track, onSelect }) => (
  <View style={styles.cardContainer}>
    <View style={styles.imageContainer}>
      <Image
        source={{ uri: `https://picsum.photos/200/200?random=${track.imageNumber}` }}
        style={styles.trackImage}
      />
      <View style={styles.playButtonContainer}>
        <TouchableOpacity 
          style={styles.playButton}
          activeOpacity={0.9}
          onPress={() => console.log('Play track:', track.title)}
        >
          <Ionicons 
            name="play" 
            size={24} 
            color={HitCraftColors.accent} 
          />
        </TouchableOpacity>
      </View>
    </View>

    <View style={styles.trackInfo}>
      <Text style={styles.trackTitle}>{track.title}</Text>
      <View style={styles.artistRow}>
        <Text style={styles.artistName}>{track.artist}</Text>
        {track.verified && (
          <Ionicons 
            name="checkmark-circle" 
            size={14} 
            color={HitCraftColors.accent} 
          />
        )}
      </View>

      <TouchableOpacity 
        onPress={onSelect} 
        style={styles.selectButton}
        activeOpacity={0.8}
      >
        <LinearGradient
          colors={HitCraftColors.gradient.primary}
          style={styles.selectButtonGradient}
          start={{ x: 0, y: 0 }}
          end={{ x: 1, y: 0 }}
        >
          <Text style={styles.selectButtonText}>SELECT</Text>
        </LinearGradient>
      </TouchableOpacity>
    </View>
  </View>
);

const FilterMenu = ({ options, selected, onSelect }) => (
  <TouchableOpacity
    style={styles.filterButton}
    onPress={() => {
      // Implement menu opening logic here
      // You might want to use a modal or dropdown library
    }}
    activeOpacity={0.8}
  >
    <Text style={styles.filterButtonText}>{selected}</Text>
    <Ionicons name="chevron-down" size={14} color={HitCraftColors.text} />
  </TouchableOpacity>
);

export default function StylesView() {
  const insets = useSafeAreaInsets();
  const [selectedGenre, setSelectedGenre] = useState('All Genres');
  const [selectedMood, setSelectedMood] = useState('All Moods');

  const genres = ['All Genres', 'Hip-Hop', 'R&B', 'Pop', 'Electronic'];
  const moods = ['All Moods', 'Energetic', 'Chill', 'Dark', 'Happy'];

  const tracks = Array(20).fill(null).map((_, index) => ({
    id: index.toString(),
    title: `Track ${index + 1}`,
    artist: 'Artist Name',
    imageNumber: index + 1,
    verified: Math.random() > 0.5,
  }));

  return (
    <View style={[styles.container, { paddingTop: insets.top }]}>
      <MusicianHeader
        title="LIBRARY"
        showSwitchOption={true}
      />

      <ScrollView style={styles.scrollView}>
        <Text style={[styles.headerTitle, { marginTop: 14 }]}>Listen. Select. Produce</Text>

        <View style={styles.filterContainer}>
          <FilterMenu
            options={genres}
            selected={selectedGenre}
            onSelect={setSelectedGenre}
          />
          <FilterMenu
            options={moods}
            selected={selectedMood}
            onSelect={setSelectedMood}
          />
        </View>

        <View style={styles.gridContainer}>
          {tracks.map((track) => (
            <StyleCard
              key={track.id}
              track={track}
              onSelect={() => console.log('Selected:', track.title)}
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
  scrollView: {
    flex: 1,
  },
  headerTitle: {
    ...HitCraftFonts.poppins(32, 'Bold'),
    textAlign: 'center',
    marginBottom: 20,
  },
  filterContainer: {
    flexDirection: 'row',
    paddingHorizontal: 20,
    gap: 12,
    marginBottom: 20,
  },
  filterButton: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'white',
    padding: 12,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: HitCraftColors.border,
  },
  filterButtonText: {
    ...HitCraftFonts.poppins(14),
    marginRight: 8,
  },
  gridContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    padding: GRID_SPACING,
    gap: GRID_SPACING,
  },
  cardContainer: {
    width: CARD_WIDTH,
    backgroundColor: 'white',
    borderRadius: 16,
    padding: 8,
  },
  imageContainer: {
    position: 'relative',
  },
  trackImage: {
    width: '100%',
    aspectRatio: 1,
    borderRadius: 16,
  },
  playButtonContainer: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    justifyContent: 'center',
    alignItems: 'center',
  },
  playButton: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: 'white',
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5,
  },
  trackInfo: {
    marginTop: 8,
    gap: 4,
  },
  trackTitle: {
    ...HitCraftFonts.poppins(16, 'Medium'),
  },
  artistRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  artistName: {
    ...HitCraftFonts.poppins(14),
    color: 'gray',
  },
  selectButton: {
    marginTop: 4,
  },
  selectButtonGradient: {
    paddingVertical: 8,
    borderRadius: 20,
    alignItems: 'center',
  },
  selectButtonText: {
    ...HitCraftFonts.poppins(14, 'Medium'),
    color: 'white',
  },
});