
import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Chat header
            HStack {
                Image("hiti")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text("Hiti")
                        .foregroundColor(HitCraftColors.accent)
                    Text("HitCraft's AI bot")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.white)
            
            // Messages ScrollView
            ScrollView {
                VStack(spacing: 16) {
                    AvatarView(imageName: "Hiti", size: 64, showStatus: true)
                        .padding(.top, 70)
                    
                    HStack {
                        Text("GOOD AFTERNOON,")
                            .font(.system(size: 30, weight: .light))
                        Text("SANDMAN")
                            .font(.system(size: 30, weight: .bold))
                    }
                    .padding(.top, 20)
                    
                    // Action Cards
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 22) {
                        ActionCard(title: "Browse Music", subtitle: "& Produce")
                        ActionCard(title: "Let's collaborate & make", subtitle: "your next song together")
                        ActionCard(title: "Get guidance, help and", subtitle: "sounds for your project")
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 27)
                }
            }
            
            // Bottom Input
            ChatInputBar()
        }
        .background(HitCraftColors.background)
    }
}
```

