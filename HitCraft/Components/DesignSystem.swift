import SwiftUI

struct HitCraftColors {
    static let background = Color(uiColor: UIColor(hex: "F4F4F5")!)
    static let border = Color(uiColor: UIColor(hex: "D9D9DF")!)
    static let cardBackground = Color(uiColor: UIColor(hex: "EFE9F4")!)
    static let primaryGradient = LinearGradient(
        colors: [Color(uiColor: UIColor(hex: "8A44C8")!), Color(uiColor: UIColor(hex: "DF0C39")!)],
        startPoint: .leading,
        endPoint: .trailing
    )
    static let accent = Color(uiColor: UIColor(hex: "D91A5A")!)
    static let text = Color(uiColor: UIColor(hex: "343434")!)
    static let secondaryText = Color(uiColor: UIColor(hex: "666666")!)
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

struct HitCraftFonts {
    static func poppins(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        switch weight {
        case .bold:
            return .custom("Poppins-Bold", size: size)
        case .semibold:
            return .custom("Poppins-SemiBold", size: size)
        case .medium:
            return .custom("Poppins-Medium", size: size)
        case .light:
            return .custom("Poppins-Light", size: size)
        default:
            return .custom("Poppins-Regular", size: size)
        }
    }
}
