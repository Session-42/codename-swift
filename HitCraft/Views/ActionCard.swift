import SwiftUI

struct ActionCard: View {
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(title)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(HitCraftColors.text)
                .multilineTextAlignment(.center)
            Text(subtitle)
                .font(.custom("Poppins-Light", size: 12))
                .foregroundColor(HitCraftColors.secondaryText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(HitCraftColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(HitCraftColors.border, lineWidth: 1)
        )
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ActionCard(
            title: "Browse Music",
            subtitle: "& Produce"
        ) {
            print("Card tapped")
        }
        ActionCard(
            title: "Let's collaborate & make",
            subtitle: "your next song together"
        ) {
            print("Card tapped")
        }
    }
    .padding()
}
