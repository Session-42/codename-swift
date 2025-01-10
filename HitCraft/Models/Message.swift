import Foundation

struct Message: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
    
    // Required for Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
}

// Sample data
extension Message {
    static let sampleMessages = [
        Message(text: "I'm an AI music creation expert, specializing in music production, lyrics, and distribution. What can I help you with today?", isFromUser: false),
        Message(text: "Can you help me find some good house music loops with R&B influence from the early 90s?", isFromUser: true)
    ]
}
