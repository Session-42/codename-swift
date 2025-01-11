import SwiftUI

struct ChatSummaryView: View {
    @Binding var isOpen: Bool
    @Binding var selectedMusician: Musician
    @State private var searchText = ""
    @State private var expandedCardId: UUID? = nil
    
    // Sample data
    private let sampleChatItems = [
        ChatItem(title: "Need help with my 2nd verse lyrics"),
        ChatItem(
            title: "I need some help with good presets for my kick drum sound",
            details: ChatDetails(
                pluginName: "12/07/92",
                year: "2003",
                presetLink: "https://knightsoftheedit..."
            )
        ),
        ChatItem(title: "Catchy drop ideas"),
        ChatItem(title: "Pop ballad production"),
        ChatItem(title: "Recommend the right tempo for my song")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Using fixed MusicianHeader component
            MusicianHeader(
                musician: selectedMusician,
                showSwitchOption: true,
                title: "HISTORY",
                showTalentGPT: false,
                selectedMusician: $selectedMusician
            )
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search chats...", text: $searchText)
                    .font(HitCraftFonts.poppins(15, weight: .light))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(HitCraftColors.border, lineWidth: 1)
            )
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(sampleChatItems) { item in
                        ChatHistoryItem(
                            item: item,
                            isExpanded: expandedCardId == item.id,
                            onTap: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    if expandedCardId == item.id {
                                        expandedCardId = nil
                                    } else {
                                        expandedCardId = item.id
                                    }
                                }
                            }
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
        }
        .background(Color.white)
    }
}

struct ChatHistoryItem: View {
    let item: ChatItem
    let isExpanded: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title row with chat bubble
            Button(action: onTap) {
                HStack(alignment: .top, spacing: 12) {
                    Image("chatbubble")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text(item.title)
                        .font(.custom("Poppins", size: 14))
                        .fontWeight(.light)
                        .foregroundColor(Color(hex: "343434"))
                        .lineSpacing(6)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            // Expanded details
            if isExpanded, let details = item.details {
                VStack(alignment: .leading, spacing: 8) {
                    DetailRow(title: "Plugin name", value: details.pluginName)
                    DetailRow(title: "Year", value: details.year)
                    DetailRow(title: "link to preset", value: details.presetLink, isLink: true)
                    
                    Button(action: {}) {
                        HStack {
                            Text("Take me to this Chat")
                                .font(HitCraftFonts.poppins(14, weight: .medium))
                                .foregroundColor(HitCraftColors.accent)
                            Image(systemName: "arrow.right")
                                .foregroundColor(HitCraftColors.accent)
                        }
                    }
                    .padding(.top, 4)
                }
                .padding(.leading, 32)
            }
        }
        .padding(.vertical, 19)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "F4F4F5"))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(HitCraftColors.border, lineWidth: 1)
        )
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    var isLink: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(HitCraftFonts.poppins(12, weight: .light))
                .foregroundColor(.gray)
            Text(value)
                .font(HitCraftFonts.poppins(14, weight: .light))
                .foregroundColor(isLink ? .blue : .black)
        }
    }
}

#Preview {
    ChatSummaryView(
        isOpen: .constant(true),
        selectedMusician: .constant(Musician.sampleMusicians[0])
    )
}
