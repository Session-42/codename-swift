import SwiftUI

struct ChatInputField: View {
    @Binding var text: String
    let placeholder: String
    let onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            TextField(placeholder, text: $text)
                .font(HitCraftFonts.poppins(15, weight: .light))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
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
    ChatInputField(
        text: .constant(""),
        placeholder: "How can I help you make some music today?"
    ) {
        // Send action
    }
}
