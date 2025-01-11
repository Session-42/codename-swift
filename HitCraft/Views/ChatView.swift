import SwiftUI

struct ChatView: View {
    @Binding var selectedMusician: Musician
    @Environment(\.dismiss) private var dismiss
    @State private var messageText = ""
    @State private var isTyping = false
    
    @State private var messages: [Message] = [
        Message(text: "I'm an AI music creation expert, specializing in music production, lyrics, and distribution. What can I help you with today?", isFromUser: false),
        Message(text: "Can you help me find some good house music loops with R&B influence from the early 90s?", isFromUser: true)
    ]
    
    private var truncatedName: String {
        if selectedMusician.name.count > 8 {
            return String(selectedMusician.name.prefix(8)) + "..."
        }
        return selectedMusician.name
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Using updated MusicianHeader
            MusicianHeader(
                musician: selectedMusician,
                showSwitchOption: true,
                title: "CHAT",
                showTalentGPT: false,
                selectedMusician: $selectedMusician
            )
            
            // Chat Messages
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(messages) { message in
                        MessageBubble(isFromUser: message.isFromUser, text: message.text)
                    }
                    if isTyping {
                        HStack {
                            Text("Typing")
                                .font(HitCraftFonts.poppins(12, weight: .light))
                                .foregroundColor(.gray)
                            TypingIndicator()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 24)
                    }
                }
                .padding(.vertical, 16)
            }
            .background(Color(hex: "F4F4F5"))
            
            // Message Input Area
            VStack(spacing: 0) {
                Divider()
                    .background(Color(hex: "D9D9DF"))
                
                VStack(spacing: 0) {
                    TextField("Message \(truncatedName)...", text: $messageText)
                        .font(.custom("Poppins-Light", size: 15))
                        .foregroundColor(Color(hex: "323236"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(HitCraftColors.border, lineWidth: 1.5)
                                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        )
                        .padding(16)
                        .onSubmit {
                            sendMessage()
                        }
                    
                    HStack {
                        Menu {
                            Button("General Assistant", action: {})
                            Button("Music Producer", action: {})
                            Button("Lyricist", action: {})
                            Button("Sound Engineer", action: {})
                        } label: {
                            MenuButton(text: "\(truncatedName) Assistant", action: {}, isAssistant: true)
                        }
                        .padding(.leading, 14)
                        
                        Menu {
                            Button("Professional", action: {})
                            Button("Casual", action: {})
                            Button("Technical", action: {})
                            Button("Creative", action: {})
                        } label: {
                            MenuButton(text: "Choose style", action: {}, isAssistant: false)
                        }
                        .padding(.leading, 15)
                        
                        Spacer()
                        
                        Button(action: sendMessage) {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 24)
                                .background(HitCraftColors.primaryGradient)
                                .clipShape(Capsule())
                        }
                        .disabled(messageText.isEmpty)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                }
                .background(Color.white)
                .clipShape(CustomRoundedCorner(radius: 24))
            }
        }
        .background(HitCraftColors.background)
        .navigationBarHidden(true)
    }
    
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        
        let userMessage = Message(text: messageText, isFromUser: true)
        messages.append(userMessage)
        let userMessageText = messageText
        messageText = ""
        
        // Show typing indicator
        isTyping = true
        
        // Simulate AI response with typing delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isTyping = false
            
            // AI response based on user message
            let aiResponse: String
            if userMessageText.lowercased().contains("help") {
                aiResponse = "I'll be happy to help! Could you tell me more about what you're looking to achieve?"
            } else if userMessageText.lowercased().contains("music") {
                aiResponse = "Music is what I do best! Let's explore some ideas together. What genre or style interests you?"
            } else {
                let responses = [
                    "That's interesting! Let's explore this idea further. What specific aspects would you like to focus on?",
                    "I understand what you're looking for. Here's what we can do...",
                    "Great question! Let me help you with that. First, let's consider...",
                    "I can definitely assist with that. Would you like to try a specific approach?"
                ]
                aiResponse = responses.randomElement() ?? responses[0]
            }
            
            let aiMessage = Message(text: aiResponse, isFromUser: false)
            messages.append(aiMessage)
        }
    }
}

#Preview {
    ChatView(selectedMusician: .constant(Musician.sampleMusicians[0]))
}
