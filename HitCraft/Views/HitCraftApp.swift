import SwiftUI

@main
struct HitCraftApp: App {
    @State private var selectedMusician: Musician? = Musician.sampleMusicians[0] // Set Hiti as default
    
    var body: some Scene {
        WindowGroup {
            MainTabView(selectedMusician: $selectedMusician)
        }
    }
}
