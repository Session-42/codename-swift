import SwiftUI

struct ChatView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var messageText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 4) {
                Image("hiti") // Changed from hitcraft to hiti
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.top, 20)
                
                Text("Hiti | HitCraft's AI bot") // Changed to match design
                    .font(HitCraftFonts.poppins(14, weight: .regular))
                    .padding(.bottom, 20)
            }
            
            // New Chat Button
            Button(action: {}) {
                HStack {
                    Image(systemName: "bubble.left")
                        .foregroundColor(HitCraftColors.accent)
                    Text("New Chat")
                        .font(HitCraftFonts.poppins(14, weight: .medium))
                        .foregroundColor(HitCraftColors.text)
                    Image(systemName: "chevron.down")
                        .foregroundColor(HitCraftColors.secondaryText)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.05), radius: 2)
            }
            
            // Chat Messages
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Bot message - no avatar
                    HStack {
                        Text("Hey there! Looks like you're in the mood for a chat—I'm all about the music side of things! Whether it's songwriting, production tips, or mixing advice, let's dive into the world of sound. What musical project are you working on, or what can I help you with today? 🎵")
                            .font(HitCraftFonts.poppins(14, weight: .regular))
                            .foregroundColor(HitCraftColors.text)
                            .padding(16)
                            .background(Color(hex: "F8F6F9"))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Spacer(minLength: 60)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 20)
            }
            
            Spacer()
            
            // Message Input - Now docked to bottom
            VStack(spacing: 8) {
                // Divider line
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(HitCraftColors.border)
                    .opacity(0.5)
                
                // Message input field
                HStack {
                    TextField("Message Hiti...", text: $messageText)
                        .font(HitCraftFonts.poppins(14, weight: .regular))
                        .padding(.horizontal, 16)
                    
                    HStack(spacing: 12) {
                        Button(action: {}) {
                            Image(systemName: "keyboard")
                                .foregroundColor(HitCraftColors.secondaryText)
                        }
                        Button(action: {}) {
                            Image(systemName: "arrow.up.square")
                                .foregroundColor(HitCraftColors.secondaryText)
                        }
                    }
                    .padding(.trailing, 12)
                }
                .frame(height: 44)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(HitCraftColors.border, lineWidth: 1)
                )
                
                // Bottom controls
                HStack {
                    Menu("Hiti Assistant") {
                        Text("Option 1")
                        Text("Option 2")
                    }
                    .font(HitCraftFonts.poppins(12, weight: .regular))
                    
                    Spacer()
                    
                    Menu("Choose style") {
                        Text("Style 1")
                        Text("Style 2")
                    }
                    .font(HitCraftFonts.poppins(12, weight: .regular))
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Send")
                            .font(HitCraftFonts.poppins(14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(HitCraftColors.primaryGradient)
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal, 4)
            }
            .padding(16)
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(HitCraftColors.text)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
