import SwiftUI

struct ChatMainView: View {
    @Binding var showingChat: Bool
    @State private var messageText = ""
    @Binding var initialMessage: String?
    let musician: Musician?
    @EnvironmentObject private var tabSelection: TabSelection
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 4) {
                        HStack {
                            Spacer()
                            Text(musician?.name ?? "Hiti")
                                .foregroundColor(HitCraftColors.accent)
                            Spacer()
                        }
                        .font(.custom("Poppins-Regular", size: 14))
                    }
                    .padding(.top, geometry.safeAreaInsets.top + 16)
                    
                    // Produce Button
                    Button(action: {
                        tabSelection.switchTab(to: 2) // Switch to Library tab
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
            .background(HitCraftColors.background)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(HitCraftColors.background)
    }
}
