import SwiftUI

struct ContentView: View {
    @State private var isSidebarOpen = false
    @State private var isChatSummaryOpen = false
    @State private var showingChat = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Main Content
                VStack(spacing: 0) {
                    // Top Navigation Bar
                    HStack {
                        // Left Menu Button
                        Button(action: {
                            withAnimation {
                                isSidebarOpen.toggle()
                            }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                                .frame(width: 44, height: 44)
                                .contentShape(Rectangle())
                        }
                        
                        Spacer()
                        
                        // Right Chat Summary Button
                        Button(action: {
                            withAnimation {
                                isChatSummaryOpen.toggle()
                            }
                        }) {
                            Image(systemName: "bubble.right")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                                .frame(width: 44, height: 44)
                                .contentShape(Rectangle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, getSafeAreaInsets().top + 8)
                    .padding(.bottom, 8)
                    .background(Color.white)
                    
                    // Main Chat Area
                    ChatMainView(showingChat: $showingChat)
                        .background(HitCraftColors.background)
                }
                
                // Overlays
                if isSidebarOpen || isChatSummaryOpen {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isSidebarOpen = false
                                isChatSummaryOpen = false
                            }
                        }
                }
                
                // Left Sidebar
                if isSidebarOpen {
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            isSidebarOpen = false
                                        }
                                    }) {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                            .frame(width: 44, height: 44)
                                            .contentShape(Rectangle())
                                    }
                                }
                                .padding(.top, getSafeAreaInsets().top)
                                
                                SidebarView(isOpen: $isSidebarOpen)
                            }
                            .frame(width: min(geometry.size.width * 0.9, 400))
                            .background(Color.white)
                            
                            Spacer()
                        }
                    }
                    .transition(.move(edge: .leading))
                }
                
                // Right Chat Summary
                if isChatSummaryOpen {
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            Spacer()
                            
                            VStack(spacing: 0) {
                                HStack {
                                    Button(action: {
                                        withAnimation {
                                            isChatSummaryOpen = false
                                        }
                                    }) {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                            .frame(width: 44, height: 44)
                                            .contentShape(Rectangle())
                                    }
                                    Spacer()
                                }
                                .padding(.top, getSafeAreaInsets().top)
                                
                                ChatSummaryView(isOpen: $isChatSummaryOpen)
                            }
                            .frame(width: min(geometry.size.width * 0.9, 400))
                            .background(Color.white)
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $showingChat) {
                ChatView()
            }
        }
    }
    
    // Helper to get safe area insets
    private func getSafeAreaInsets() -> EdgeInsets {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first
        else {
            return EdgeInsets()
        }
        return EdgeInsets(
            top: window.safeAreaInsets.top,
            leading: window.safeAreaInsets.left,
            bottom: window.safeAreaInsets.bottom,
            trailing: window.safeAreaInsets.right
        )
    }
}

#Preview {
    ContentView()
}
