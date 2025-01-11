import SwiftUI

struct MusicianHeader: View {
    let musician: Musician?
    let showSwitchOption: Bool
    let title: String  // New parameter for the title
    let showTalentGPT: Bool // Whether to show TalentGPT™ instead of title
    @State private var showingMusicianPicker = false
    
    var body: some View {
        HStack(spacing: 8) {
            if showSwitchOption {
                Button(action: { showingMusicianPicker = true }) {
                    HStack(spacing: 8) {
                        Text(musician?.name ?? "Hiti")
                            .font(HitCraftFonts.poppins(18, weight: .medium))
                            .foregroundColor(HitCraftColors.accent)
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14))
                            .foregroundColor(HitCraftColors.accent)
                    }
                }
                
                Text("•")
                    .foregroundColor(HitCraftColors.accent)
            } else {
                Text(musician?.name ?? "Hiti")
                    .font(HitCraftFonts.poppins(18, weight: .medium))
                    .foregroundColor(HitCraftColors.accent)
            }
            
            Text(showTalentGPT ? "TalentGPT™" : title)
                .font(HitCraftFonts.poppins(18, weight: .light))
                .foregroundColor(.black)
        }
        .frame(height: 44)
        .padding(.horizontal, 20)
    }
}

// Usage examples for different views:

// In ChatMainView:
MusicianHeader(
    musician: musician,
    showSwitchOption: true,
    title: "TalentGPT™",
    showTalentGPT: true
)

// In ChatView:
MusicianHeader(
    musician: musician,
    showSwitchOption: true,
    title: "CHAT",
    showTalentGPT: false
)

// In BrowseView:
MusicianHeader(
    musician: musician,
    showSwitchOption: true,
    title: "LIBRARY",
    showTalentGPT: false
)

// In ChatSummaryView:
MusicianHeader(
    musician: musician,
    showSwitchOption: true,
    title: "HISTORY",
    showTalentGPT: false
)
