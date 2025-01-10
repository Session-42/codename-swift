import SwiftUI

struct ActionCard: View {
    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(title)
                .font(HitCraftFonts.poppins(14, weight: .regular))
                .foregroundColor(HitCraftColors.text)
                .multilineTextAlignment(.center)
            Text(subtitle)
                .font(HitCraftFonts.poppins(12, weight: .light))
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

struct ActionCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ActionCard(
                title: "Browse Music",
                subtitle: "& Produce",
                action: {
                    print("Browse Music tapped")
                }
            )
            ActionCard(
                title: "Let's collaborate & make",
                subtitle: "your next song together",
                action: {
                    print("Collaborate tapped")
                }
            )
            ActionCard(
                title: "Get guidance, help and",
                subtitle: "sounds for your project",
                action: {
                    print("Get guidance tapped")
                }
            )
        }
        .padding()
    }
}
