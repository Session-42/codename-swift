import SwiftUI

struct SidebarView: View {
    @Binding var isOpen: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                
                VStack(alignment: .leading, spacing: 0) {
                    // Logo
                    Image("hitcraft")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 121)
                        .padding(.leading, 22)
                        .padding(.top, 25)
                        .padding(.bottom, 41)
                    
                    Divider()
                        .background(HitCraftColors.border.opacity(0.13))
                    
                    // Quick Production Button
                    GradientButton(
                        title: "Quick production",
                        icon: "plus"
                    ) {
                        // Quick production action
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 25)
                    .padding(.bottom, 25)
                    
                    // Search
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(HitCraftColors.secondaryText)
                        TextField("Search musicians...", text: .constant(""))
                            .font(HitCraftFonts.poppins(14, weight: .light))
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 13)
                    .background(HitCraftColors.background)
                    .clipShape(Capsule())
                    .padding(.horizontal, 18)
                    
                    Divider()
                        .background(HitCraftColors.border.opacity(0.13))
                        .padding(.top, 41)
                    
                    // Recommended Musicians Section
                    Text("Recommended Musicians")
                        .font(HitCraftFonts.poppins(11, weight: .light))
                        .padding(.leading, 32)
                        .padding(.top, 41)
                    
                    // Musicians List will go here
                    
                    Spacer()
                    
                    // User Profile
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
            .frame(width: min(geometry.size.width * 0.8, 320))
            .edgesIgnoringSafeArea(.vertical)
        }
    }
}
