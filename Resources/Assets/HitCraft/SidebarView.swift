import SwiftUI

struct SidebarView: View {
    @Binding var isOpen: Bool
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 24) {
                // Quick Production Button
                Button(action: {}) {
                    HStack(spacing: 8) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                        Text("Quick production")
                            .foregroundColor(.white)
                            .font(HitCraftFonts.poppins(16, weight: .medium))
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(HitCraftColors.primaryGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                }
                .padding(.horizontal, 20)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search musicians...", text: $searchText)
                        .font(HitCraftFonts.poppins(16, weight: .light))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(hex: "F4F4F5"))
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.horizontal, 20)
                
                // Recommended Musicians Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Recommended Musicians")
                        .font(HitCraftFonts.poppins(16, weight: .medium))
                        .foregroundColor(.black)
                    
                    VStack(spacing: 16) {
                        RecommendedArtistRow(name: "Hiti", subtitle: "HitCraft's AI Bot")
                        RecommendedArtistRow(name: "Yinon Yahel", subtitle: "HitCraft's AI Bot")
                        RecommendedArtistRow(name: "Stav Beger", subtitle: "HitCraft's AI Bot")
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.top, 40)
        }
    }
}

struct RecommendedArtistRow: View {
    let name: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "music.note.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(HitCraftColors.accent)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(HitCraftFonts.poppins(16, weight: .medium))
                    .foregroundColor(.black)
                Text(subtitle)
                    .font(HitCraftFonts.poppins(14, weight: .light))
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    SidebarView(isOpen: .constant(true))
}
