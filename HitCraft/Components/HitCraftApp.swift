import SwiftUI

@main
struct HitCraftApp: App {
    @StateObject private var tabSelection = TabSelection()
    
    var body: some Scene {
        WindowGroup {
            MainNavigationView()
                .environmentObject(tabSelection)
        }
    }
}
