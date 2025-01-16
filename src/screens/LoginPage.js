import React, { useEffect } from 'react';
import {
  View,
  StyleSheet,
  ActivityIndicator,
  Image,
  TouchableOpacity,
  Text,
} from 'react-native';
import { useRouter } from 'expo-router';
import { useDescope, useSession } from '@descope/react-native-sdk';
import { HitCraftColors } from '../theme/colors';

const descopeProjectId = "P2c5c3JHvZ8w5oiRpMMZnRKRtP2e";

export default function LoginPage() {
  const router = useRouter();
  const { isAuthenticated, isSessionLoading } = useSession();
  const descope = useDescope();

  useEffect(() => {
    if (isAuthenticated) {
      router.push("/chat");
    }
  }, [isAuthenticated, router]);

  const handleSignIn = async () => {
    try {
      const resp = await descope.otp.email.signInOrUp('flow1', {
        loginId: '', // Will be entered by user in Descope's native UI
        redirectUrl: 'hitcraft://',
      });
      
      if (resp.data) {
        router.push("/chat");
      }
    } catch (error) {
      console.error("Authentication error:", error);
    }
  };

  if (isSessionLoading) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color={HitCraftColors.accent} />
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <View style={styles.content}>
        <Image
          source={require('../../assets/hitcraft.png')}
          style={styles.logo}
          resizeMode="contain"
        />

        <TouchableOpacity 
          style={styles.signInButton}
          onPress={handleSignIn}
        >
          <Text style={styles.signInButtonText}>Sign In / Sign Up</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: HitCraftColors.background,
  },
  loadingContainer: {
    flex: 1,
    backgroundColor: HitCraftColors.background,
    justifyContent: 'center',
    alignItems: 'center',
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  logo: {
    width: 150,
    height: 60,
    marginBottom: 30,
  },
  signInButton: {
    backgroundColor: HitCraftColors.accent,
    paddingHorizontal: 30,
    paddingVertical: 15,
    borderRadius: 8,
    width: '80%',
    alignItems: 'center',
  },
  signInButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
  },
});