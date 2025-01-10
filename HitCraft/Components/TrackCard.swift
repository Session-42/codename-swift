import SwiftUI

struct TrackCard: View {
    let track: Track
    @Binding var showingUploadDemo: Bool
    
    var body: some View {
        Button(action: { showingUploadDemo = true }) {
            VStack(alignment: .leading, spacing: 8) {
                Image("\(track.imageNumber)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                HStack {
                    Text(track.title)
                        .font(HitCraftFonts.poppins(14, weight: .medium))
                    if track.verified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(HitCraftColors.accent)
                            .font(.system(size: 12))
                    }
                }
                
                Text(track.artist)
                    .font(HitCraftFonts.poppins(12, weight: .light))
                    .foregroundColor(.gray)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
