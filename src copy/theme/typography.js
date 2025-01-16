import { Platform } from 'react-native';

export const HitCraftFonts = {
  poppins: (size, weight = 'Regular') => ({
    fontFamily: `Poppins-${weight}`,
    fontSize: size,
  }),

  // Predefined text styles
  displayLarge: {
    ...Platform.select({
      ios: { fontFamily: 'Poppins-Bold' },
      android: { fontFamily: 'Poppins-Bold' },
    }),
    fontSize: 32,
  },
  displayMedium: {
    ...Platform.select({
      ios: { fontFamily: 'Poppins-SemiBold' },
      android: { fontFamily: 'Poppins-SemiBold' },
    }),
    fontSize: 28,
  },
  bodyLarge: {
    ...Platform.select({
      ios: { fontFamily: 'Poppins-Regular' },
      android: { fontFamily: 'Poppins-Regular' },
    }),
    fontSize: 16,
  },
  bodyMedium: {
    ...Platform.select({
      ios: { fontFamily: 'Poppins-Regular' },
      android: { fontFamily: 'Poppins-Regular' },
    }),
    fontSize: 14,
  },
  bodySmall: {
    ...Platform.select({
      ios: { fontFamily: 'Poppins-Regular' },
      android: { fontFamily: 'Poppins-Regular' },
    }),
    fontSize: 12,
  }
};