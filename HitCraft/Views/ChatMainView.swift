import SwiftUI

struct ChatMainView: View {
    @Binding var showingChat: Bool
    @State private var messageText = ""
    @Binding var initialMessage: String?
    @Binding var selectedMusician: Musician
    @EnvironmentObject private var tabSelection: TabSelection
    @Binding var showingSidebar: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Using shared MusicianHeader with hamburger menu in overlay
            ZStack {
                MusicianHeader(
                    musician: selectedMusician,
                    showSwitchOption: true,
                    title: "TalentGPT™",
                    showTalentGPT: true,
                    selectedMusician: $selectedMusician
                )
                
                // Hamburger menu overlay
                HStack {
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.3)) {
                            showingSidebar.toggle()
                        }
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            
            ScrollView {
                VStack(spacing: 32) {
                    // Produce button now goes to Library tab
                    Button(action: {
                        tabSelection.switchTab(to: 2)  // Switch to Library tab
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
                    .padding(.top, 16)
                    
                    // Chat Input
                    HStack {
                        TextField("How can I help you make some music today?", text: $messageText)
                            .font(HitCraftFonts.poppins(15, weight: .light))
                            .padding(.leading, 16)
                            .foregroundColor(.gray)
                            .onSubmit {
                                sendMessageAndNavigate()
                            }
                        
                        Button(action: sendMessageAndNavigate) {
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
                            initialMessage = "I want to browse music and produce something new"
                            tabSelection.switchTab(to: 1)  // Navigate to chat with message
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        ActionCard(title: "Let's collaborate & make", subtitle: "your next song together") {
                            initialMessage = "I want to collaborate and make a new song. Can you help me?"
                            tabSelection.switchTab(to: 1)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        ActionCard(title: "Get guidance, help and", subtitle: "sounds for your project") {
                            initialMessage = "I need guidance and help finding sounds for my project"
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
                                tabSelection.switchTab(to: 3)  // Navigate to history
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
    
    private func sendMessageAndNavigate() {
        if !messageText.isEmpty {
            initialMessage = messageText
            messageText = ""
            tabSelection.switchTab(to: 1)  // Navigate to chat with typed message
        }
    }
}

#Preview {
    ChatMainView(
        showingChat: .constant(false),
        initialMessage: .constant(nil),
        selectedMusician: .constant(Musician.sampleMusicians[0]),
        showingSidebar: .constant(false)
    )
    .environmentObject(TabSelection())
}
