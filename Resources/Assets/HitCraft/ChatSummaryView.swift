import SwiftUI

struct ChatSummaryView: View {
    @Binding var isOpen: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    HStack(spacing: 8) {
                        Image("preset")
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text("SESSIONS")
                            .font(HitCraftFonts.poppins(16))
                        + Text(" SUMMARY")
                            .font(HitCraftFonts.poppins(16, weight: .bold))
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
                        TextField("Search chats...", text: .constant(""))
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
                            ForEach(1...5, id: \.self) { _ in
                                ChatSummaryCard()
                            }
                        }
                        .padding(.horizontal, 18)
                        .padding(.top, 30)
                    }
                }
            }
            .frame(width: min(geometry.size.width * 0.8, 320))
            .edgesIgnoringSafeArea(.vertical)
        }
    }
}

struct ChatSummaryCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image("preset")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .opacity(0.3)
                Text("Need help with my 2nd verse lyrics")
                    .font(HitCraftFonts.poppins(13, weight: .light))
                    .lineLimit(2)
            }
        }
        .padding(17)
        .frame(height: 66)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(HitCraftColors.border, lineWidth: 1)
        )
    }
}
