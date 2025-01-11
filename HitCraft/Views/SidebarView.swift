import SwiftUI

struct SidebarView: View {
    @Binding var isOpen: Bool
    @Binding var selectedMusician: Musician  // Removed optional
    @State private var searchText = ""
    
    let musicians = Musician.sampleMusicians
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(HitCraftColors.secondaryText)
                        .padding(.leading, 18)
                    
                    TextField("Search musicians...", text: $searchText)
                        .font(HitCraftFonts.poppins(16, weight: .light))
                        .padding(.vertical, 13)
                }
                .background(HitCraftColors.background)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(HitCraftColors.border, lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .padding(.top, 25)
                
                Divider()
                    .padding(.top, 25)
                    .padding(.bottom, 32)
                
                // Recommended Musicians Section
                Text("Recommended Musicians")
                    .font(HitCraftFonts.poppins(11, weight: .light))
                    .foregroundColor(.black)
                    .padding(.leading, 32)
                    .padding(.bottom, 32)
                
                VStack(spacing: 8) {
                    ForEach(musicians) { musician in
                        Button(action: {
                            selectedMusician = musician
                            isOpen = false
                        }) {
                            HStack(spacing: 17) {
                                // Icon
                                Image(musician.iconAsset)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 27, height: 27)
                                
                                // Text stack with exact specifications
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(musician.name)
                                        .font(.custom("Poppins-SemiBold", size: 13))
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                    
                                    Text("Music Producer & Artist")
                                        .font(.custom("Poppins-Light", size: 13))
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .frame(height: 58)
                            .background(
                                RoundedRectangle(cornerRadius: 23)
                                    .fill(selectedMusician.id == musician.id ? Color(hex: "E3E9F7").opacity(0.7) : Color.clear)
                            )
                            .padding(.horizontal, 20)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 0)
                
                Spacer()
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    SidebarView(
        isOpen: .constant(true),
        selectedMusician: .constant(Musician.sampleMusicians[0])
    )
}
