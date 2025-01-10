import SwiftUI

struct MusicianHeader: View {
    let musician: Musician?
    let showSwitchOption: Bool
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
            
            Text("TalentGPT™")
                .font(HitCraftFonts.poppins(18, weight: .light))
                .foregroundColor(.black)
        }
        .frame(height: 44)
        .padding(.horizontal, 20)
    }
}
