import SwiftUI

struct BrowseView: View {
    let musician: Musician
    @State private var selectedGenre = "All Genres"
    @State private var selectedMood = "All Moods"
    @State private var searchText = ""
    @State private var showingUploadDemo = false
    
    let genres = ["All Genres", "Hip-Hop", "R&B", "Pop", "Electronic"]
    let moods = ["All Moods", "Energetic", "Chill", "Dark", "Happy"]
    
    var tracks: [Track] {
        musician.library.isEmpty ? (1...20).map { index in
            Track(
                title: "Track \(index)",
                artist: musician.name,
                imageNumber: ((index - 1) % 6) + 1,
                verified: true
            )
        } : musician.library
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // New Musician Header
            MusicianHeader(musician: musician, showSwitchOption: true)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Text("Listen. Select. Produce")
                        .font(HitCraftFonts.poppins(32, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.top, 24)
                    
                    // Filter Menus
                    HStack(spacing: 12) {
                        Menu {
                            ForEach(genres, id: \.self) { genre in
                                Button(action: { selectedGenre = genre }) {
                                    if genre == selectedGenre {
                                        Label(genre, systemImage: "checkmark")
                                    } else {
                                        Text(genre)
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedGenre)
                                    .font(HitCraftFonts.poppins(14, weight: .regular))
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 12))
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(HitCraftColors.border, lineWidth: 1)
                            )
                        }
                        
                        Menu {
                            ForEach(moods, id: \.self) { mood in
                                Button(action: { selectedMood = mood }) {
                                    if mood == selectedMood {
                                        Label(mood, systemImage: "checkmark")
                                    } else {
                                        Text(mood)
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedMood)
                                    .font(HitCraftFonts.poppins(14, weight: .regular))
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 12))
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(HitCraftColors.border, lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Tracks Grid
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ],
                        spacing: 16
                    ) {
                        ForEach(tracks) { track in
                            TrackCard(track: track, showingUploadDemo: $showingUploadDemo)
                        }
                    }
                    .padding(20)
                }
            }
        }
        .background(HitCraftColors.background)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        BrowseView(musician: Musician.sampleMusicians[0])
    }
}
