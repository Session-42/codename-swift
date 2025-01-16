import React from 'react';
import { View, Image, StyleSheet } from 'react-native';
import { HitCraftColors } from '../theme/colors';

export const AvatarView = ({ imageSource, size = 64, showStatus = false }) => {
  const containerStyle = {
    width: size,
    height: size,
    borderRadius: size / 2,
  };

  const statusSize = size * 0.25;

  return (
    <View style={[styles.container, containerStyle]}>
      {imageSource ? (
        <Image
          source={typeof imageSource === 'string' ? { uri: imageSource } : imageSource}
          style={[styles.image, containerStyle]}
        />
      ) : (
        <Image
          source={require('../assets/person-placeholder.png')}
          style={[styles.image, containerStyle]}
        />
      )}
      {showStatus && (
        <View 
          style={[
            styles.statusIndicator, 
            {
              width: statusSize,
              height: statusSize,
              borderRadius: statusSize / 2,
              right: -2,
              bottom: -2,
            }
          ]}
        />
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    borderWidth: 1,
    borderColor: HitCraftColors.border,
    overflow: 'hidden',
  },
  image: {
    resizeMode: 'cover',
  },
  statusIndicator: {
    position: 'absolute',
    backgroundColor: '#4CAF50',
    borderWidth: 2,
    borderColor: 'white',
  },
});