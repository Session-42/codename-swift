import SwiftUI
struct ChatInputView: View {
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                TextField("How can I help you make some music today?", text: $messageText)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            .background(Color.white)
                    )
                
                Button(action: { /* Send message */ }) {
                    Circle()
                        .fill(HitCraftColors.primaryGradient)
                        .frame(width: 37, height: 37)
                        .overlay(
                            Image(systemName: "arrow.up")
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(45))
                        )
                }
            }
        }
        .padding(.bottom, 8)
    }
}
