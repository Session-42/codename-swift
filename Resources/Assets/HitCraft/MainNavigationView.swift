import SwiftUI

struct MainNavigationView: View {
    @State private var showingSidebar = false
    @State private var showingChatSummary = false
    
    var body: some View {
        ZStack {
            ChatView() // We'll create this next
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if showingSidebar {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showingSidebar = false
                        }
                    }
                
                SidebarView(isOpen: $showingSidebar)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.85)
                    .transition(.move(edge: .leading))
                    .zIndex(2)
            }
            
            if showingChatSummary {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showingChatSummary = false
                        }
                    }
                
                ChatSummaryView(isOpen: $showingChatSummary)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.85)
                    .transition(.move(edge: .trailing))
                    .zIndex(2)
            }
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            showingSidebar = true
                        }
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(HitCraftColors.secondaryText)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            showingChatSummary = true
                        }
                    }) {
                        Image(systemName: "bubble.right")
                            .font(.title2)
                            .foregroundColor(HitCraftColors.secondaryText)
                    }
                }
                .padding()
                
                Spacer()
            }
            .zIndex(3)
        }
    }
}
