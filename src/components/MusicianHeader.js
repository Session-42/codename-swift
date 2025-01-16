import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Modal,
  ScrollView,
  Image,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';

const DEFAULT_MUSICIANS = [
  { id: 'hitcraft', name: 'Hitcraft', iconAsset: 'hiti2' },
  { id: 'chainsmokers', name: 'The Chainsmokers', iconAsset: 'Chainsmokers' },
  { id: 'chamillionaire', name: 'Chamillionaire', iconAsset: 'chamillionaire' },
  { id: 'maxmartin', name: 'Max Martin', iconAsset: 'maxmartin' },
  { id: 'yinonyahel', name: 'Yinon Yahel (DJ)', iconAsset: 'yinonyahel' },
];

export function MusicianHeader({ 
  title, 
  showSwitchOption = false,
  showTalentGPT = false,
  selectedMusician = DEFAULT_MUSICIANS[0],
  onMusicianChange,
}) {
  const [showMusicianPicker, setShowMusicianPicker] = useState(false);

  const handleMusicianSelect = (musician) => {
    onMusicianChange?.(musician);
    setShowMusicianPicker(false);
  };

  return (
    <View style={styles.container}>
      <View style={styles.contentContainer}>
        {showSwitchOption ? (
          <TouchableOpacity 
            style={styles.musicianButton}
            onPress={() => setShowMusicianPicker(true)}
          >
            <Text style={styles.musicianName}>{selectedMusician.name}</Text>
            <Ionicons name="chevron-down" size={14} color={HitCraftColors.accent} />
          </TouchableOpacity>
        ) : (
          <Text style={styles.musicianName}>{selectedMusician.name}</Text>
        )}
        <Text style={styles.dot}>•</Text>
        <Text style={styles.title}>
          {showTalentGPT ? 'TalentGPT™' : title}
        </Text>
      </View>

      <Modal
        visible={showMusicianPicker}
        transparent
        animationType="slide"
        onRequestClose={() => setShowMusicianPicker(false)}
      >
        <View style={styles.modalOverlay}>
          <View style={styles.modalContent}>
            <View style={styles.modalHeader}>
              <Text style={styles.modalTitle}>Select Musician</Text>
              <TouchableOpacity 
                onPress={() => setShowMusicianPicker(false)}
                style={styles.closeButton}
              >
                <Text style={styles.closeButtonText}>Done</Text>
              </TouchableOpacity>
            </View>

            <ScrollView style={styles.musicianList}>
              {DEFAULT_MUSICIANS.map((musician) => (
                <TouchableOpacity
                  key={musician.id}
                  style={styles.musicianItem}
                  onPress={() => handleMusicianSelect(musician)}
                >
                  <View style={styles.musicianInfo}>
                    <Image
                      source={{ uri: musician.iconAsset }}
                      style={styles.musicianIcon}
                      defaultSource={require('../../assets/default-avatar.png')}
                    />
                    <Text style={styles.musicianItemName}>{musician.name}</Text>
                  </View>
                  {selectedMusician.id === musician.id && (
                    <Ionicons 
                      name="checkmark" 
                      size={24} 
                      color={HitCraftColors.accent} 
                    />
                  )}
                </TouchableOpacity>
              ))}
            </ScrollView>
          </View>
        </View>
      </Modal>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    paddingVertical: 12,
    paddingHorizontal: 20,
    backgroundColor: 'white',
    borderBottomWidth: 1,
    borderBottomColor: HitCraftColors.border,
  },
  contentContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
  },
  musicianButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  musicianName: {
    ...HitCraftFonts.poppins(18, 'Medium'),
    color: HitCraftColors.accent,
  },
  dot: {
    ...HitCraftFonts.poppins(18, 'Medium'),
    color: HitCraftColors.accent,
    marginHorizontal: 8,
  },
  title: {
    ...HitCraftFonts.poppins(18, 'Light'),
    color: HitCraftColors.text,
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
    maxHeight: '80%',
  },
  modalHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: HitCraftColors.border,
  },
  modalTitle: {
    ...HitCraftFonts.poppins(18, 'Medium'),
    color: HitCraftColors.text,
  },
  closeButton: {
    padding: 8,
  },
  closeButtonText: {
    ...HitCraftFonts.poppins(16, 'Medium'),
    color: HitCraftColors.accent,
  },
  musicianList: {
    padding: 16,
  },
  musicianItem: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderRadius: 8,
    marginBottom: 8,
    backgroundColor: 'white',
    borderWidth: 1,
    borderColor: HitCraftColors.border,
  },
  musicianInfo: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
  },
  musicianIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
  },
  musicianItemName: {
    ...HitCraftFonts.poppins(16, 'Regular'),
    color: HitCraftColors.text,
  },
});