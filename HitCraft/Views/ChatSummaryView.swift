import SwiftUI

struct ChatSummaryView: View {
    @Binding var isOpen: Bool
    let musician: Musician
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // New Musician Header
            MusicianHeader(musician: musician, showSwitchOption: true)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(HitCraftColors.secondaryText)
                        TextField("Search chats...", text: $searchText)
                            .font(HitCraftFonts.poppins(14, weight: .light))
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 13)
                    .background(HitCraftColors.background)
                    .clipShape(Capsule())
                    .padding(.horizontal, 18)
                    .padding(.top, 20)
                    
                    // Chat List
                    VStack(spacing: 15) {
                        ChatItem(title: "Need help with my 2nd verse lyrics")
                        ChatItem(title: "Catchy drop ideas")
                        ChatItem(title: "Pop ballad production")
                        ChatItem(title: "Sound design exploration")
                        ChatItem(title: "Mixing advice needed")
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 20)
                }
            }
        }
        .background(HitCraftColors.background)
        .navigationBarHidden(true)
    }
}

struct ChatItem: View {
    let title: String
    
    var body: some View {
        Button(action: {}) {
            VStack(alignment: .leading, spacing: 15) {
                Text(title)
                    .font(HitCraftFonts.poppins(15, weight: .light))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
            }
            .padding(17)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(HitCraftColors.border, lineWidth: 1)
            )
        }
    }
}

#Preview {
    ChatSummaryView(isOpen: .constant(true), musician: Musician.sampleMusicians[0])
}
