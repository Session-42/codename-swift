import SwiftUI

struct ChatSummaryView: View {
    @Binding var isOpen: Bool
    let musician: Musician
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                // Title Section
                VStack(spacing: 4) {
                    HStack {
                        Text(musician.name)
                            .foregroundColor(HitCraftColors.accent)
                        Text("|")
                            .foregroundColor(HitCraftColors.accent)
                        Text("History")
                            .foregroundColor(.black)
                    }
                    .font(HitCraftFonts.poppins(14, weight: .regular))
                }
                .padding(.top, 16)
                
                // Search bar instead of subtitle
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
        .background(HitCraftColors.background)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(HitCraftColors.text)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { dismiss() }) {
                    Text("Done")
                        .foregroundColor(.blue)
                        .font(HitCraftFonts.poppins(17, weight: .regular))
                }
            }
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
