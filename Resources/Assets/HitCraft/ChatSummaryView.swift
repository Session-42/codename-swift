import SwiftUI

struct ChatSummaryView: View {
    @Binding var isOpen: Bool
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with close button
            HStack {
                Image(systemName: "bubble.left.fill")
                    .foregroundColor(HitCraftColors.accent)
                    .font(.system(size: 24))
                Text("SESSIONS SUMMARY")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                Button(action: {
                    withAnimation(.spring()) {
                        isOpen = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
            .padding(.bottom, 20)
            
            Divider()
            
            ScrollView {
                VStack(spacing: 16) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search chats...", text: $searchText)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(hex: "F4F4F5"))
                    .cornerRadius(25)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Chat List
                    VStack(spacing: 12) {
                        ForEach(sampleChats) { chat in
                            ChatSummaryCard(chat: chat)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ChatSummaryCard: View {
    let chat: ChatSummary
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: "bubble.left.fill")
                .foregroundColor(HitCraftColors.accent.opacity(0.3))
                .font(.system(size: 20))
            
            Text(chat.title)
                .font(.system(size: 16))
                .lineLimit(2)
            
            Spacer()
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: "D9D9DF"), lineWidth: 1)
        )
    }
}

let sampleChats = [
    ChatSummary(title: "Need help with my 2nd verse lyrics"),
    ChatSummary(title: "Catchy drop ideas"),
    ChatSummary(title: "Pop ballad production"),
    ChatSummary(title: "Sound design exploration"),
    ChatSummary(title: "Mixing advice needed")
]

struct ChatSummary: Identifiable {
    let id = UUID()
    let title: String
}
