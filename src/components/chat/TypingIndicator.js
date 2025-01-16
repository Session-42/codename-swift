import React, { useRef, useEffect } from 'react';
import { View, Animated, StyleSheet } from 'react-native';

export const TypingIndicator = () => {
  const dotOffset = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    const animation = Animated.loop(
      Animated.sequence([
        Animated.timing(dotOffset, {
          toValue: -5,
          duration: 500,
          useNativeDriver: true,
        }),
        Animated.timing(dotOffset, {
          toValue: 0,
          duration: 500,
          useNativeDriver: true,
        }),
      ])
    );
    animation.start();
    return () => animation.stop();
  }, []);

  return (
    <View style={styles.typingContainer}>
      {[0, 1, 2].map((index) => (
        <Animated.View
          key={index}
          style={[
            styles.dot,
            {
              transform: [{
                translateY: dotOffset.interpolate({
                  inputRange: [-5, 0],
                  outputRange: [-5, 0],
                  extrapolate: 'clamp',
                })
              }]
            }
          ]}
        />
      ))}
    </View>
  );
};

const styles = StyleSheet.create({
  typingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 4,
    gap: 4,
  },
  dot: {
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: 'gray',
  },
});