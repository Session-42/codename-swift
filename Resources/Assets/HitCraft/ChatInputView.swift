import SwiftUI

struct ChatInputView: View {
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .overlay(
                    HStack {
                        TextField("How can I help you make some music today?", text: $messageText)
                            .padding(.horizontal)
                        
                        Button(action: { /* Send message */ }) {
                            Circle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(hex: "8a44c8"),
                                        Color(hex: "df0c39")
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                                .frame(width: 37, height: 37)
                                .overlay(
                                    Image(systemName: "arrow.up")
                                        .foregroundColor(.white)
                                        .rotationEffect(.degrees(45))
                                )
                        }
                        .padding(.trailing, 6)
                    }
                )
                .frame(height: 49)
        }
    }
}
