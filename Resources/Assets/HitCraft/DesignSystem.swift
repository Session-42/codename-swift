// DesignSystem.swift
import SwiftUI

extension Color {
    init(_ hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let g = Double((rgbValue & 0xff00) >> 8) / 255.0
        let b = Double(rgbValue & 0xff) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

struct HitCraftColors {
    static let background = Color("F4F4F5")
    static let border = Color("D9D9DF")
    static let primaryGradient = LinearGradient(
        colors: [Color("8A44C8"), Color("DF0C39")],
        startPoint: .leading,
        endPoint: .trailing
    )
    static let accent = Color("D91A5A")
    static let text = Color("343434")
    static let secondaryText = Color("666666")
}

struct HitCraftFonts {
    static func poppins(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom("Poppins", size: size).weight(weight)
    }
}

// Custom Components
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
        Image(imageName)
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

struct GradientButton: View {
    let title: String
    let icon: String?
    let action: () -> Void
    
    init(title: String, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 14))
                }
                Text(title)
                    .font(HitCraftFonts.poppins(14, weight: .medium))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(HitCraftColors.primaryGradient)
            .clipShape(Capsule())
        }
    }
}

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
                Image(systemName: "arrow.up")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 37, height: 37)
                    .background(HitCraftColors.primaryGradient)
                    .clipShape(Circle())
                    .rotationEffect(.degrees(45))
            }
        }
        .padding(.horizontal, 16)
    }
}

struct ActionCard: View {
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .center, spacing: 4) {
                Text(title)
                    .font(HitCraftFonts.poppins(14, weight: .light))
                    .foregroundColor(HitCraftColors.text)
                Text(subtitle)
                    .font(HitCraftFonts.poppins(12, weight: .light))
                    .foregroundColor(HitCraftColors.secondaryText)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(HitCraftColors.border, lineWidth: 1)
            )
        }
    }
}
