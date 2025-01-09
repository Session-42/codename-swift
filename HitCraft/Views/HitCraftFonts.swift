import SwiftUI

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
