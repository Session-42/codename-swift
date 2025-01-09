import SwiftUI

struct AvatarView: View {
    let imageName: String
    let size: CGFloat
    let showStatus: Bool
    
    init(imageName: String, size: CGFloat = 64, showStatus: Bool = false) {
        self.imageName = imageName
        self.size = size
        self.showStatus = showStatus
    }
    
    var body: some View {
        Image(systemName: "person.circle.fill") // Temporary placeholder
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(HitCraftColors.border, lineWidth: 1)
            )
            .overlay(
                showStatus ? statusIndicator : nil,
                alignment: .bottomTrailing
            )
    }
    
    private var statusIndicator: some View {
        Circle()
            .fill(Color.green)
            .frame(width: size * 0.25, height: size * 0.25)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
            )
            .offset(x: -2, y: -2)
    }
}
