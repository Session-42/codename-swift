import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    AvatarView(imageName: "Hiti", size: 64, showStatus: true)
                        .padding(.top, 70)
                    
                    VStack(spacing: 4) {
                        Text("Hiti")
                            .font(HitCraftFonts.poppins(14, weight: .semibold))
                            .foregroundColor(HitCraftColors.accent)
                        + Text(" | ")
                            .foregroundColor(HitCraftColors.accent)
                        + Text("HitCraft's AI bot")
                            .font(HitCraftFonts.poppins(14, weight: .light))
                            .foregroundColor(HitCraftColors.text)
                    }
                    
                    // Messages will go here
                }
                .padding(.horizontal)
            }
            
            // Chat input at bottom
            VStack(spacing: 0) {
                Divider()
                ChatInputView()
                    .padding()
                    .background(Color.white)
            }
        }
        .background(HitCraftColors.background)
    }
}
