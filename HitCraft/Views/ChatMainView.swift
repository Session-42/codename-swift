import SwiftUI
struct ChatMainView: View {
    @Binding var showingChat: Bool
    @State private var messageText = ""
    @Binding var initialMessage: String?
    let musician: Musician?
    @EnvironmentObject private var tabSelection: TabSelection
    
    var body: some View {
        VStack(spacing: 0) {
            // Header - Keeping same style as other views
            MusicianHeader(musician: musician, showSwitchOption: true)
            
            ScrollView {
                VStack(spacing: 32) {
                    // Rest of the content remains the same
                    Button(action: {
                        tabSelection.switchTab(to: 2)
                    }) {
                        Circle()
                            .fill(HitCraftColors.primaryGradient)
                            .frame(width: 120, height: 120)
                            .overlay(
                                Text("Produce")
                                    .font(HitCraftFonts.poppins(22, weight: .semibold))
                                    .foregroundColor(.white)
                            )
                    }
                    .padding(.top, 16) // Reduced from 32 to match other views
                    
                    // Rest of your existing content...
                    
                    // Chat Input
                    HStack {
                        TextField("How can I help you make some music today?", text: $messageText)
                            .font(HitCraftFonts.poppins(15, weight: .light))
                            .padding(.leading, 16)
                            .foregroundColor(.gray)
                            .onSubmit {
                                if !messageText.isEmpty {
                                    initialMessage = messageText
                                    messageText = ""
                                    tabSelection.switchTab(to: 1)
                                }
                            }
                        
                        Button(action: {
                            if !messageText.isEmpty {
                                initialMessage = messageText
                                messageText = ""
                                tabSelection.switchTab(to: 1)
                            }
                        }) {
                            Circle()
                                .fill(HitCraftColors.primaryGradient)
                                .frame(width: 37, height: 37)
                                .overlay(
                                    Image(systemName: "arrow.up")
                                        .foregroundColor(.white)
                                        .rotationEffect(.degrees(45))
                                )
                        }
                        .padding(.trailing, 6)
                    }
                    .padding(.vertical, 6)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(HitCraftColors.border, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    
                    // Action Cards
                    VStack(spacing: 12) {
                        ActionCard(title: "Browse Music", subtitle: "& Produce") {
                            tabSelection.switchTab(to: 1)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        ActionCard(title: "Let's collaborate & make", subtitle: "your next song together") {
                            tabSelection.switchTab(to: 1)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        ActionCard(title: "Get guidance, help and", subtitle: "sounds for your project") {
                            tabSelection.switchTab(to: 1)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    
                    // Recent Chats
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Your recent chats")
                                .font(HitCraftFonts.poppins(14, weight: .medium))
                            Spacer()
                            Button("View all →") {
                                tabSelection.switchTab(to: 3)
                            }
                            .foregroundColor(HitCraftColors.accent)
                        }
                        
                        RecentChatsGrid()
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .background(HitCraftColors.background)
    }
}
