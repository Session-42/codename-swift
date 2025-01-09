import SwiftUI

// MARK: - HitCraftColors

struct HitCraftColors {
    static let background = Color(hex: "F4F4F5")
    static let border = Color(hex: "D9D9DF")
    static let cardBackground = Color(hex: "EFE9F4")
    static let primaryGradient = LinearGradient(
        colors: [Color(hex: "8A44C8"), Color(hex: "DF0C39")],
        startPoint: .leading,
        endPoint: .trailing
    )
    static let accent = Color(hex: "D91A5A")
    static let text = Color(hex: "343434")
    static let secondaryText = Color(hex: "666666")
}

// MARK: - Color Extension for Hex Initialization

extension Color {
    /// Initializes a Color from a hex string.
    /// - Parameter hex: The hex string to convert. It can optionally start with a `#` and support 6 or 8 characters.
    init(hex: String) {
        // Remove any characters that are not alphanumerics (e.g., '#')
        let cleanedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        var hexValue: UInt64 = 0
        let scanner = Scanner(string: cleanedHex)
        
        // Attempt to scan the hex string into an integer
        if !scanner.scanHexInt64(&hexValue) {
            print("Invalid hex string: \(hex). Defaulting to white color.")
            self = Color.white
            return
        }
        
        let r, g, b, a: Double
        switch cleanedHex.count {
        case 6:
            // RGB (24-bit)
            r = Double((hexValue & 0xFF0000) >> 16) / 255.0
            g = Double((hexValue & 0x00FF00) >> 8) / 255.0
            b = Double(hexValue & 0x0000FF) / 255.0
            a = 1.0
        case 8:
            // RGBA (32-bit)
            r = Double((hexValue & 0xFF000000) >> 24) / 255.0
            g = Double((hexValue & 0x00FF0000) >> 16) / 255.0
            b = Double((hexValue & 0x0000FF00) >> 8) / 255.0
            a = Double(hexValue & 0x000000FF) / 255.0
        default:
            print("Hex string should be either 6 or 8 characters long. Defaulting to white color.")
            self = Color.white
            return
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
}
