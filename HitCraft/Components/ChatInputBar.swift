import SwiftUI

struct ChatInputBar: View {
    @State private var messageText = ""
    var onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("How can I help you make some music today?", text: $messageText)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(HitCraftColors.border, lineWidth: 1)
                )
            
            Button(action: onSend) {
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
        .padding(.horizontal, 16)
    }
}

#Preview {
    ChatInputBar(onSend: {})
}
