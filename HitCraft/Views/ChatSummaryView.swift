import SwiftUI

struct ChatSummaryView: View {
    @Binding var isOpen: Bool
    let musician: Musician
    @State private var searchText = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 0) {
                    // Title
                    HStack(spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(musician.name)
                                .foregroundColor(HitCraftColors.accent)
                            Text("SESSIONS SUMMARY")
                                .font(HitCraftFonts.poppins(16, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.top, 37)
                    .padding(.bottom, 41)
                    .padding(.horizontal, 22)
                    
                    Divider()
                        .background(HitCraftColors.border.opacity(0.13))
                    
                    // Search
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
                    .padding(.top, 32)
                    
                    // Chat List
                    ScrollView {
                        VStack(spacing: 15) {
                            ChatItem(title: "Need help with my 2nd verse lyrics")
                            ChatItem(title: "Catchy drop ideas")
                            ChatItem(title: "Pop ballad production")
                            ChatItem(title: "Sound design exploration")
                            ChatItem(title: "Mixing advice needed")
                        }
                        .padding(.horizontal, 18)
                        .padding(.top, 30)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
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
