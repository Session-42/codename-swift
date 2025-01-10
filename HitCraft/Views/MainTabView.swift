import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @Binding var selectedMusician: Musician?
    @State private var initialMessage: String?
    @State private var showingChat = false
    
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
                    ChatView(musician: Musician.sampleMusicians[0])
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
                    BrowseView(musician: Musician.sampleMusicians[0])
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
                    ChatSummaryView(isOpen: .constant(true), musician: Musician.sampleMusicians[0])
                }
            }
            .tabItem {
                Image(systemName: "clock")
                    .background(Color.white)
                Text("History")
            }
            .tag(3)
        }
        .environmentObject(TabSelection(selection: $selectedTab))
    }
}

class TabSelection: ObservableObject {
    @Binding var selection: Int
    
    init(selection: Binding<Int>) {
        self._selection = selection
    }
    
    func switchTab(to tab: Int) {
        selection = tab
    }
}
