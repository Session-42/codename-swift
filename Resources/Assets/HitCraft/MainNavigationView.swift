import SwiftUI
struct MainNavigationView: View {
    @State private var showingSidebar = false
    @State private var showingChatSummary = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            ChatView()
            
            // Overlay when either panel is shown
            if showingSidebar || showingChatSummary {
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()
                    .animation(.easeInOut, value: showingSidebar)
                    .animation(.easeInOut, value: showingChatSummary)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            showingSidebar = false
                            showingChatSummary = false
                        }
                    }
                    .zIndex(1)
            }
            
            // Left Sidebar
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    SidebarView(isOpen: $showingSidebar)
                        .frame(width: geometry.size.width * 0.85)
                        .background(Color.white)
                        .offset(x: showingSidebar ? 0 : -geometry.size.width)
                }
            }
            .zIndex(2)
            
            // Right Summary Panel
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Spacer()
                    ChatSummaryView(isOpen: $showingChatSummary)
                        .frame(width: geometry.size.width * 0.85)
                        .background(Color.white)
                        .offset(x: showingChatSummary ? 0 : geometry.size.width)
                }
            }
            .zIndex(2)
            
            // Top Navigation Buttons
            VStack {
                HStack {
                    Button(action: { toggleSidebar() }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(HitCraftColors.secondaryText)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button(action: { toggleChatSummary() }) {
                        Image(systemName: "bubble.right")
                            .font(.title2)
                            .foregroundColor(HitCraftColors.secondaryText)
                    }
                    .padding()
                }
                Spacer()
            }
            .zIndex(3)
        }
    }
    
    private func toggleSidebar() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            showingSidebar.toggle()
            if showingSidebar {
                showingChatSummary = false
            }
        }
    }
    
    private func toggleChatSummary() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            showingChatSummary.toggle()
            if showingChatSummary {
                showingSidebar = false
            }
        }
    }
}
```
