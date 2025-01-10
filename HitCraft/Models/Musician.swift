import Foundation

struct Musician: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let iconAsset: String
    var library: [Track] = []
    var chatHistory: [Message] = []
    
    // Required for Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Musician, rhs: Musician) -> Bool {
        lhs.id == rhs.id
    }
}

// Sample data
extension Musician {
    static let sampleMusicians = [
        Musician(name: "Hitcraft", iconAsset: "hiti2"),
        Musician(name: "The Chainsmokers", iconAsset: "Chainsmokers"),
        Musician(name: "Chamillionaire", iconAsset: "chamillionaire"),
        Musician(name: "Max Martin", iconAsset: "maxmartin"),
        Musician(name: "Yinon Yahel (DJ)", iconAsset: "yinonyahel")
    ]
    
    static let sample = sampleMusicians[1] // The Chainsmokers as default sample
}
