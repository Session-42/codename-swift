import SwiftUI

struct ChatMainView: View {
    @Binding var showingChat: Bool
    @State private var messageText = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Circle with status
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Circle()
                            .fill(Color.green)
                            .frame(width: 8, height: 8)
                            .offset(x: 22, y: 22)
                    )
                    .padding(.top, 40)
                
                // Title
                HStack(spacing: 4) {
                    Text("Hiti")
                        .foregroundColor(HitCraftColors.accent)
                    Text("|")
                        .foregroundColor(HitCraftColors.accent)
                    Text("HitCraft's AI bot")
                        .foregroundColor(.black)
                }
                .font(HitCraftFonts.poppins(14, weight: .light))
                
                // Welcome Text
                Text("GOOD AFTERNOON,")
                    .font(HitCraftFonts.poppins(32, weight: .light))
                Text("SANDMAN")
                    .font(HitCraftFonts.poppins(32, weight: .bold))
                
                // Chat Input with embedded send button
                HStack {
                    ZStack {
                        HStack {
                            TextField("How can I help you make some music today?", text: $messageText)
                                .padding(.leading, 16)
                                .padding(.trailing, 50)
                                .padding(.vertical, 12)
                        }
                        
                        HStack {
                            Spacer()
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
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(HitCraftColors.border, lineWidth: 1)
                    )
                }
                .padding(.horizontal, 20)
                
                // Action Cards
                VStack(spacing: 12) {
                    Button {
                        print("Browse Music tapped")
                    } label: {
                        ActionCard(title: "Browse Music", subtitle: "& Produce") {}
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button {
                        print("Collaborating...")
                        showingChat = true
                    } label: {
                        ActionCard(title: "Let's collaborate & make", subtitle: "your next song together") {}
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button {
                        print("Get guidance tapped")
                    } label: {
                        ActionCard(title: "Get guidance, help and", subtitle: "sounds for your project") {}
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 20)
                
                // Recent Chats
                VStack(alignment: .leading) {
                    HStack {
                        Text("Your recent chats")
                            .font(HitCraftFonts.poppins(14, weight: .medium))
                        Spacer()
                        Button("View all →") {
                            // Action
                        }
                        .foregroundColor(HitCraftColors.accent)
                    }
                    
                    RecentChatsGrid()
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                Spacer(minLength: 40)
            }
        }
        .background(HitCraftColors.background)
        .ignoresSafeArea(.keyboard)
    }
}

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
