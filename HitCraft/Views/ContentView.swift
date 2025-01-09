import SwiftUI

struct ContentView: View {
    @State private var navigationPath = NavigationPath()
    @State private var showingChat = false
    @State private var showingSidebar = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                HitCraftColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Navigation Bar
                    HStack {
                        Button(action: {
                            showingSidebar = true
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                                .frame(width: 44, height: 44)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            navigationPath.append(Destination.chatSummary)
                        }) {
                            Image(systemName: "bubble.right")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                                .frame(width: 44, height: 44)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ChatMainView(showingChat: $showingChat)
                }
            }
            .sheet(isPresented: $showingSidebar) {
                NavigationStack {
                    SidebarView(isOpen: $showingSidebar)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    showingSidebar = false
                                }) {
                                    Text("Done")
                                }
                            }
                        }
                }
                .presentationDetents([.large])
            }
            .navigationDestination(for: Destination.self) { destination in
                if case .chatSummary = destination {
                    ChatSummaryView(isOpen: .constant(true))
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden(false)
                }
            }
            .navigationDestination(isPresented: $showingChat) {
                ChatView()
            }
        }
    }
}

enum Destination: Hashable {
    case chatSummary
}
