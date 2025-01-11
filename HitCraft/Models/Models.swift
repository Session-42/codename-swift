import Foundation

struct Musician: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let iconAsset: String
    var library: [Track] = []
    var chatHistory: [Message] = []
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Musician, rhs: Musician) -> Bool {
        lhs.id == rhs.id
    }
}

struct Message: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
}

struct ChatItem: Identifiable {
    let id = UUID()
    let title: String
    var details: ChatDetails?
}

struct ChatDetails {
    let pluginName: String
    let year: String
    let presetLink: String
}

// Sample data extensions
extension Musician {
    static let sampleMusicians = [
        Musician(name: "Hitcraft", iconAsset: "hiti2"),
        Musician(name: "The Chainsmokers", iconAsset: "Chainsmokers"),
        Musician(name: "Chamillionaire", iconAsset: "chamillionaire"),
        Musician(name: "Max Martin", iconAsset: "maxmartin"),
        Musician(name: "Yinon Yahel (DJ)", iconAsset: "yinonyahel")
    ]
    
    static let sample = sampleMusicians[1]
}

extension Message {
    static let sampleMessages = [
        Message(text: "I'm an AI music creation expert, specializing in music production, lyrics, and distribution. What can I help you with today?", isFromUser: false),
        Message(text: "Can you help me find some good house music loops with R&B influence from the early 90s?", isFromUser: true)
    ]
}
