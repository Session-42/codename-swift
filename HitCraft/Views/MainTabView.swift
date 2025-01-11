import SwiftUI

class TabSelection: ObservableObject {
    @Published var selection: Int = 0
    
    func switchTab(to tab: Int) {
        selection = tab
    }
}

struct MainTabView: View {
    @StateObject private var tabSelection = TabSelection()
    @State private var selectedMusician = Musician.sampleMusicians[0]
    @State private var initialMessage: String?
    @State private var showingChat = false
    @State private var showingSidebar = false
    
    var body: some View {
        TabView(selection: $tabSelection.selection) {
            // Home tab
            ContentView(selectedMusician: $selectedMusician)
                .tabItem {
                    Image(systemName: "house.fill")
                        .background(Color.white)
                    Text("Home")
                }
                .tag(0)
            
            // Chat tab
            NavigationStack {
                ChatView(selectedMusician: $selectedMusician)
            }
            .tabItem {
                Image(systemName: "message")
                    .background(Color.white)
                Text("Chat")
            }
            .tag(1)
            
            // Library tab
            NavigationStack {
                BrowseView(selectedMusician: $selectedMusician)
            }
            .tabItem {
                Image(systemName: "music.note.list")
                    .background(Color.white)
                Text("Library")
            }
            .tag(2)
            
            // History tab
            NavigationStack {
                ChatSummaryView(
                    isOpen: .constant(true),
                    selectedMusician: $selectedMusician
                )
            }
            .tabItem {
                Image(systemName: "clock")
                    .background(Color.white)
                Text("History")
            }
            .tag(3)
        }
        .environmentObject(tabSelection)
    }
}

#Preview {
    MainTabView()
}
