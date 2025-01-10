import SwiftUI

enum Destination: Hashable {
    case chatSummary
}

struct ContentView: View {
    @Binding var selectedMusician: Musician?
    @State private var navigationPath = NavigationPath()
    @State private var showingChat = false
    @State private var showingSidebar = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                HitCraftColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Top space with hamburger button
                    HStack {
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.3)) {
                                showingSidebar = true
                            }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                                .frame(width: 44, height: 44)
                        }
                        Spacer()
                        
                        if let musician = selectedMusician {
                            Text(musician.name)
                                .font(HitCraftFonts.poppins(16, weight: .medium))
                        }
                    }
                    .frame(height: 44)
                    .padding(.horizontal, 20)
                    
                    // Main Content
                    ChatMainView(showingChat: $showingChat, musician: selectedMusician)
                }
                
                // Custom sidebar transition from left
                if showingSidebar {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.3)) {
                                showingSidebar = false
                            }
                        }
                    
                    HStack(spacing: 0) {
                        SidebarView(isOpen: $showingSidebar, selectedMusician: $selectedMusician)
                            .frame(width: UIScreen.main.bounds.width * 0.85)
                            .background(Color.white)
                            .transition(.move(edge: .leading))
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $showingChat) {
                if let musician = selectedMusician {
                    ChatView(musician: musician)
                }
            }
        }
    }
}

#Preview {
    ContentView(selectedMusician: .constant(nil))
}
