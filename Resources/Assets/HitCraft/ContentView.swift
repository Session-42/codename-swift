import SwiftUI

struct ContentView: View {
    @State private var isSidebarOpen = false
    @State private var isChatSummaryOpen = false
    
    var body: some View {
        ZStack {
            // Main Content
            VStack(spacing: 0) {
                HStack {
                    // Menu Button
                    Button(action: { isSidebarOpen.toggle() }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(HitCraftColors.secondaryText)
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Chat Summary Button
                    Button(action: { isChatSummaryOpen.toggle() }) {
                        Image(systemName: "bubble.right")
                            .font(.title2)
                            .foregroundColor(HitCraftColors.secondaryText)
                    }
                    .padding()
                }
                
                // Main Chat Area
                ChatMainView()
                    .background(HitCraftColors.background)
            }
            
            // Sidebar
            SidebarView(isOpen: $isSidebarOpen)
                .offset(x: isSidebarOpen ? 0 : -UIScreen.main.bounds.width)
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isSidebarOpen)
            
            // Chat Summary
            ChatSummaryView(isOpen: $isChatSummaryOpen)
                .offset(x: isChatSummaryOpen ? 0 : UIScreen.main.bounds.width)
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isChatSummaryOpen)
        }
        .background(Color.white)
    }
}
