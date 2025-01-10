import SwiftUI

struct ChatView: View {
    let musician: Musician?
    @Environment(\.dismiss) private var dismiss
    @State private var messageText = ""
    @State private var messages: [Message] = [
        Message(text: "I'm an AI music creation expert, specializing in music production, lyrics, and distribution. What can I help you with today?", isFromUser: false),
        Message(text: "Can you help me find some good house music loops with R&B influence from the early 90s?", isFromUser: true)
    ]
    
    private var truncatedName: String {
        guard let name = musician?.name else { return "Hiti" }
        if name.count > 8 {
            return String(name.prefix(8)) + "..."
        }
        return name
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 4) {
                HStack {
                    Text(musician?.name ?? "Hiti")
                        .foregroundColor(HitCraftColors.accent)
                    Text("|")
                        .foregroundColor(HitCraftColors.accent)
                    Text("HitCraft's AI bot")
                        .foregroundColor(.black)
                }
                .font(.custom("Poppins-Regular", size: 14))
                .padding(.top, 16)
                .padding(.bottom, 12)
            }
            .background(Color.white)
            
            // Chat Messages
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(messages) { message in
                        MessageBubble(isFromUser: message.isFromUser, text: message.text)
                    }
                }
                .padding(.vertical, 16)
            }
            .background(Color(hex: "F4F4F5"))
            
            // Message Input Area
            VStack(spacing: 0) {
                Divider()
                    .background(Color(hex: "D9D9DF"))
                
                VStack(spacing: 0) {
                    TextField("Message \(truncatedName)...", text: $messageText)
                        .font(.custom("Poppins-Light", size: 15))
                        .foregroundColor(Color(hex: "323236"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                        )
                        .padding(16)
                    
                    HStack {
                        Menu {
                            Text("Option 1")
                            Text("Option 2")
                        } label: {
                            MenuButton(text: "\(truncatedName) Assistant", action: {}, isAssistant: true)
                        }
                        .padding(.leading, 14)
                        
                        Menu {
                            Text("Style 1")
                            Text("Style 2")
                        } label: {
                            MenuButton(text: "Choose style", action: {}, isAssistant: false)
                        }
                        .padding(.leading, 15)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 24)
                                .background(HitCraftColors.primaryGradient)
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                }
                .background(Color.white)
                .clipShape(CustomRoundedCorner(radius: 24))
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(HitCraftColors.text)
                }
            }
        }
    }
}

struct MessageBubble: View {
    let isFromUser: Bool
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                if isFromUser {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.gray)
                }
                
                Text(text)
                    .font(.custom("Poppins-Light", size: 15))
                    .foregroundColor(Color(hex: "424246"))
                    .lineSpacing(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if !isFromUser {
                    Spacer(minLength: 32)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(isFromUser ? Color(hex: "F1E4E9") : Color(hex: "EFE9F4"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 8)
    }
}

struct MenuButton: View {
    let text: String
    let action: () -> Void
    let isAssistant: Bool
    
    init(text: String, action: @escaping () -> Void, isAssistant: Bool) {
        self.text = text
        self.action = action
        self.isAssistant = isAssistant
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(text)
                    .font(.custom("Poppins-Light", size: 15))
                    .foregroundColor(Color(hex: isAssistant ? "D1B4B9" : "C1A4A9"))
                    .opacity(0.7)
                
                Image(systemName: "chevron.down")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: isAssistant ? "D1B4B9" : "C1A4A9"))
                    .opacity(0.7)
            }
        }
    }
}

struct CustomRoundedCorner: Shape {
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: radius))
        path.addQuadCurve(
            to: CGPoint(x: radius, y: 0),
            control: CGPoint(x: 0, y: 0)
        )
        path.addLine(to: CGPoint(x: rect.maxX - radius, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: radius),
            control: CGPoint(x: rect.maxX, y: 0)
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        return path
    }
}
