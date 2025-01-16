import { useEffect, useState } from 'react';
import {
  useFonts as useExpoPoppins,
  Poppins_300Light as PoppinsLight,
  Poppins_400Regular as PoppinsRegular,
  Poppins_500Medium as PoppinsMedium,
  Poppins_600SemiBold as PoppinsSemiBold,
  Poppins_700Bold as PoppinsBold,
} from '@expo-google-fonts/poppins';
import { Ionicons } from '@expo/vector-icons';

export function useFonts() {
  const [fontsLoaded] = useExpoPoppins({
    PoppinsLight,
    PoppinsRegular,
    PoppinsMedium,
    PoppinsSemiBold,
    PoppinsBold,
  });

  const [iconLoaded, setIconLoaded] = useState(false);

  useEffect(() => {
    async function loadIcons() {
      try {
        await Ionicons.loadAsync();
        setIconLoaded(true);
      } catch (error) {
        console.error('Error loading icons:', error);
        // In development, proceed without icons
        if (__DEV__) {
          setIconLoaded(true);
        }
      }
    }

    loadIcons();
  }, []);

  return fontsLoaded && iconLoaded;
}