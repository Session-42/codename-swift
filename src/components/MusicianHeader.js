import React, { useState } from 'react';
import { View, Text, TouchableOpacity, Modal, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { HitCraftColors } from '../theme/colors';
import { HitCraftFonts } from '../theme/typography';

const MUSICIANS = [
  { id: '1', name: 'Hitcraft' },
  { id: '2', name: 'Max Martin' },
  { id: '3', name: 'Chamillionaire' },
  { id: '4', name: 'The Chainsmokers' },
  { id: '5', name: 'Yinon Yahel (DJ)' }
];

export const MusicianHeader = ({
  title = 'CHAT',
  showSwitchOption = true,
  selectedMusician = MUSICIANS[0],
  onMusicianChange,
  style
}) => {
  const [showPicker, setShowPicker] = useState(false);

  return (
    <>
      <View style={[styles.container, style]}>
        <View style={styles.contentContainer}>
          {showSwitchOption ? (
            <TouchableOpacity
              onPress={() => setShowPicker(true)}
              style={styles.nameButton}
              activeOpacity={0.6}
            >
              <Text style={styles.musicianName}>{selectedMusician.name}</Text>
              <Ionicons name="chevron-down" size={14} color={HitCraftColors.accent} />
            </TouchableOpacity>
          ) : (
            <Text style={styles.musicianName}>{selectedMusician.name}</Text>
          )}
          <Text style={styles.dot}> • </Text>
          <Text style={styles.titleText}>{title}</Text>
        </View>
      </View>

      <Modal
        visible={showPicker}
        transparent
        animationType="slide"
        onRequestClose={() => setShowPicker(false)}
      >
        <View style={styles.modalContainer}>
          <View style={styles.modalContent}>
            <View style={styles.modalHeader}>
              <Text style={styles.modalTitle}>Select Musician</Text>
              <TouchableOpacity 
                style={styles.closeButton}
                onPress={() => setShowPicker(false)}
              >
                <Text style={styles.closeText}>Done</Text>
              </TouchableOpacity>
            </View>
            {MUSICIANS.map(musician => (
              <TouchableOpacity
                key={musician.id}
                onPress={() => {
                  onMusicianChange?.(musician);
                  setShowPicker(false);
                }}
                style={{
                  padding: 16,
                  borderBottomWidth: 1,
                  borderBottomColor: HitCraftColors.border,
                  flexDirection: 'row',
                  justifyContent: 'space-between',
                  alignItems: 'center'
                }}
              >
                <Text style={{
                  ...HitCraftFonts.poppins(16, 'Regular'),
                }}>{musician.name}</Text>
                {musician.id === selectedMusician.id && (
                  <Ionicons name="checkmark" size={24} color={HitCraftColors.accent} />
                )}
              </TouchableOpacity>
            ))}
          </View>
        </View>
      </Modal>
    </>
  );
};

const styles = StyleSheet.create({
  container: {
    height: 44,
    backgroundColor: HitCraftColors.background,
    justifyContent: 'center',
    marginBottom: 0,
  },
  contentContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: 16,
  },
  nameButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  musicianName: {
    ...HitCraftFonts.poppins(18, 'Medium'),
    color: HitCraftColors.accent,
  },
  dot: {
    ...HitCraftFonts.poppins(18, 'Regular'),
    color: HitCraftColors.accent,
    marginHorizontal: 8,
  },
  titleText: {
    ...HitCraftFonts.poppins(18, 'Light'),
    color: '#000',
  },
  modalContainer: {
    flex: 1,
    justifyContent: 'flex-end',
    backgroundColor: 'rgba(0,0,0,0.5)',
  },
  modalContent: {
    backgroundColor: 'white',
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    maxHeight: '80%',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: HitCraftColors.border,
  },
  modalTitle: {
    ...HitCraftFonts.poppins(16, 'Medium'),
  },
  closeButton: {
    padding: 8,
  },
  closeText: {
    ...HitCraftFonts.poppins(14),
    color: HitCraftColors.accent,
  },
});