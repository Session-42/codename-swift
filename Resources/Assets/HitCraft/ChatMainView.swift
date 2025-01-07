import SwiftUI

struct ChatMainView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Image
                AvatarView(imageName: "Hiti", size: 64, showStatus: true)
                    .padding(.top, 70)
                
                // Artist Info
                VStack(spacing: 4) {
                    Text("Hiti")
                        .font(HitCraftFonts.poppins(14, weight: .semibold))
                        .foregroundColor(HitCraftColors.accent)
                    + Text(" | ")
                        .foregroundColor(HitCraftColors.accent)
                    + Text("HitCraft's AI bot")
                        .font(HitCraftFonts.poppins(14, weight: .light))
                        .foregroundColor(HitCraftColors.text)
                }
                
                // Welcome Text
                HStack(spacing: 4) {
                    Text("GOOD AFTERNOON,")
                        .font(HitCraftFonts.poppins(30, weight: .light))
                    Text("SANDMAN")
                        .font(HitCraftFonts.poppins(30, weight: .bold))
                }
                .foregroundColor(HitCraftColors.text)
                .padding(.top, 20)
                
                // Chat Input
                ChatInputField(
                    text: .constant(""),
                    placeholder: "How can I help you make some music today?"
                ) {
                    // Send message action
                }
                .padding(.horizontal, 20)
                .padding(.top, 27)
                
                // Action Cards Grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 22) {
                    ActionCard(
                        title: "Browse Music",
                        subtitle: "& Produce"
                    ) { }
                    ActionCard(
                        title: "Let's collaborate & make",
                        subtitle: "your next song together"
                    ) { }
                    ActionCard(
                        title: "Get guidance, help and",
                        subtitle: "sounds for your project"
                    ) { }
                }
                .padding(.horizontal, 20)
                .padding(.top, 27)
                
                // Recent Chats Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image("preset")
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text("Your recent chats")
                            .font(HitCraftFonts.poppins(14, weight: .light))
                        Spacer()
                        Text("View all →")
                            .font(HitCraftFonts.poppins(14, weight: .light))
                            .foregroundColor(HitCraftColors.accent)
                    }
                    
                    RecentChatsGrid()
                }
                .padding(.horizontal, 20)
                .padding(.top, 89)
            }
            .padding(.bottom, 65)
        }
    }
}

struct RecentChatsGrid: View {
    let recentChats = [
        RecentChat(user: "Yinon Yahel", message: "Need help with my 2nd verse lyrics", time: "1 day ago"),
        RecentChat(user: "Stav Beger", message: "Catchy drop ideas", time: "3 days ago"),
        RecentChat(user: "Yinon Yahel", message: "Pop ballad production", time: "4 days ago")
    ]
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            ForEach(recentChats, id: \.message) { chat in
                RecentChatCard(chat: chat)
            }
        }
    }
}

struct RecentChat {
    let user: String
    let message: String
    let time: String
}

struct RecentChatCard: View {
    let chat: RecentChat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 12) {
                Image("preset")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .opacity(0.3)
                Text(chat.user)
                    .font(HitCraftFonts.poppins(13, weight: .light))
                    .foregroundColor(HitCraftColors.text)
            }
            
            Text(chat.message)
                .font(HitCraftFonts.poppins(13))
                .foregroundColor(HitCraftColors.secondaryText)
            
            HStack(spacing: 10) {
                Image(systemName: "clock")
                    .font(.system(size: 12))
                Text(chat.time)
                    .font(HitCraftFonts.poppins(10, weight: .semibold))
            }
            .foregroundColor(HitCraftColors.text)
        }
        .padding(17)
        .frame(height: 144)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(HitCraftColors.border, lineWidth: 1)
        )
    }
}
