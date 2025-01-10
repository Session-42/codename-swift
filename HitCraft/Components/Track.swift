import Foundation

struct Track: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let imageNumber: Int
    let verified: Bool
}
