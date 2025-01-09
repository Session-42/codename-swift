import SwiftUI

struct ChatMainView: View {
    @Binding var showingChat: Bool
    @State private var messageText = ""
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 32) {
                    // Welcome Text - starts higher up
                    VStack(spacing: 8) {
                        Text("GOOD AFTERNOON,")
                            .font(HitCraftFonts.poppins(32, weight: .light))
                        Text("SANDMAN")
                            .font(HitCraftFonts.poppins(32, weight: .bold))
                    }
                    .padding(.top, geometry.safeAreaInsets.top)
                    
                    // Produce Button
                    Button(action: {}) {
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
                        
                        Button(action: {}) {
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
                        ActionCard(title: "Browse Music", subtitle: "& Produce") {}
                            .buttonStyle(PlainButtonStyle())
                        
                        ActionCard(title: "Let's collaborate & make", subtitle: "your next song together") {
                            showingChat = true
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        ActionCard(title: "Get guidance, help and", subtitle: "sounds for your project") {}
                            .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    
                    // Recent Chats
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Your recent chats")
                                .font(HitCraftFonts.poppins(14, weight: .medium))
                            Spacer()
                            Button("View all →") {}
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

// Keep existing RecentChatsGrid and RecentChatCard components unchanged
struct RecentChatsGrid: View {
    var body: some View {
        VStack(spacing: 12) {
            RecentChatCard(title: "Need help with my 2nd verse...", time: "1 day ago")
            RecentChatCard(title: "Catchy drop ideas", time: "3 days ago")
            RecentChatCard(title: "Pop ballad production", time: "4 days ago")
        }
    }
}

struct RecentChatCard: View {
    let title: String
    let time: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(HitCraftFonts.poppins(14, weight: .light))
            HStack {
                Image(systemName: "clock")
                Text(time)
            }
            .font(HitCraftFonts.poppins(12, weight: .light))
            .foregroundColor(.gray)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(HitCraftColors.border, lineWidth: 1)
        )
    }
}

#Preview {
    ChatMainView(showingChat: .constant(false))
}
