import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var selectedMusician: Musician?
    
    var body: some View {
        TabView(selection: $selectedTab) {
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
                if let musician = selectedMusician {
                    ChatView(musician: musician)
                } else {
                    Text("Please select a musician from the sidebar")
                }
            }
            .tabItem {
                Image(systemName: "message")
                    .background(Color.white)
                Text("Chat")
            }
            .tag(1)
            
            // Library tab
            NavigationStack {
                if let musician = selectedMusician {
                    BrowseView(musician: musician)
                } else {
                    Text("Please select a musician from the sidebar")
                }
            }
            .tabItem {
                Image(systemName: "music.note.list")
                    .background(Color.white)
                Text("Library")
            }
            .tag(2)
            
            // History tab
            NavigationStack {
                if let musician = selectedMusician {
                    ChatSummaryView(isOpen: .constant(true), musician: musician)
                } else {
                    Text("Please select a musician from the sidebar")
                }
            }
            .tabItem {
                Image(systemName: "clock")
                    .background(Color.white)
                Text("History")
            }
            .tag(3)
        }
    }
}

#Preview {
    MainTabView()
}
