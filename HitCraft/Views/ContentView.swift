import SwiftUI

struct ContentView: View {
    @Binding var selectedMusician: Musician
    @State private var navigationPath = NavigationPath()
    @State private var showingChat = false
    @State private var showingSidebar = false
    @State private var initialMessage: String?
    
    var body: some View {
        NavigationStack {
            ZStack {
                HitCraftColors.background
                    .ignoresSafeArea()
                
                // Main Content
                ChatMainView(
                    showingChat: $showingChat,
                    initialMessage: $initialMessage,
                    selectedMusician: $selectedMusician,
                    showingSidebar: $showingSidebar
                )
                
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
                        SidebarView(
                            isOpen: $showingSidebar,
                            selectedMusician: $selectedMusician
                        )
                        .frame(width: UIScreen.main.bounds.width * 0.85)
                        .background(Color.white)
                        .transition(.move(edge: .leading))
                        
                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedMusician: .constant(Musician.sampleMusicians[0]))
    }
}
