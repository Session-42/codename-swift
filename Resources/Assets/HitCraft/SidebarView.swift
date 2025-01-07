import SwiftUI

struct SidebarView: View {
    @Binding var isOpen: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.spring()) {
                                isOpen = false
                            }
                        }) {
                            Image(systemName: "xmark")
                                .font(.title3)
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    .padding(.top, 8)
                    
                    Image("hitcraft")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 121)
                        .padding(.leading, 22)
                        .padding(.bottom, 41)
                    
                    Divider().background(HitCraftColors.border.opacity(0.13))
                    
                    GradientButton(title: "Quick production", icon: "plus") {
                        // Action
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 25)
                    
                    SearchBar()
                        .padding(.horizontal, 18)
                    
                    Divider()
                        .padding(.top, 41)
                        .background(HitCraftColors.border.opacity(0.13))
                    
                    Text("Recommended Musicians")
                        .font(HitCraftFonts.poppins(11, weight: .light))
                        .padding(.leading, 32)
                        .padding(.top, 41)
                    
                    MusiciansList()
                    
                    Spacer()
                    
                    UserProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .edgesIgnoringSafeArea(.vertical)
        }
    }
}

struct SearchBar: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(HitCraftColors.secondaryText)
            TextField("Search musicians...", text: $searchText)
                .font(HitCraftFonts.poppins(14, weight: .light))
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 13)
        .background(HitCraftColors.background)
        .clipShape(Capsule())
    }
}

struct MusiciansList: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(["Hiti", "Yinon Yahel", "Stav Beger"], id: \.self) { musician in
                    MusicianRow(name: musician)
                }
            }
            .padding(.horizontal, 18)
            .padding(.top, 20)
        }
    }
}

struct MusicianRow: View {
    let name: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image("preset")
                .resizable()
                .frame(width: 27, height: 27)
                .opacity(0.3)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(HitCraftFonts.poppins(13, weight: .semibold))
                Text("Hitcraft's AI Bot")
                    .font(HitCraftFonts.poppins(13, weight: .light))
                    .foregroundColor(.black.opacity(0.5))
            }
            
            Spacer()
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(28)
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(HitCraftColors.border, lineWidth: 1)
        )
    }
}

struct UserProfileView: View {
    var body: some View {
        HStack(spacing: 12) {
            Image("oudi")
                .resizable()
                .frame(width: 47, height: 47)
                .clipShape(Circle())
            
            Text("Oudi Antebi")
                .font(HitCraftFonts.poppins(12, weight: .light))
            
            Spacer()
            
            Image(systemName: "chevron.down")
                .font(.system(size: 19))
                .opacity(0.6)
        }
        .padding(16)
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(HitCraftColors.border)
                .offset(y: -0.5),
            alignment: .top
        )
    }
}
