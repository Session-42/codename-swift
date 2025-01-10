import SwiftUI

struct MessageBubble: View {
    let isFromUser: Bool
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                if isFromUser {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.gray)
                }
                
                Text(text)
                    .font(.custom("Poppins-Light", size: 15))
                    .foregroundColor(Color(hex: "424246"))
                    .lineSpacing(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if !isFromUser {
                    Spacer(minLength: 32)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(isFromUser ? Color(hex: "F1E4E9") : Color(hex: "EFE9F4"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 8)
    }
}
