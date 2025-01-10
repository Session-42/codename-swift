import SwiftUI

struct BrowseView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedGenre = "All Genres"
    @State private var selectedMood = "All Moods"
    @State private var searchText = ""
    @State private var showingUploadDemo = false
    
    let genres = ["All Genres", "Hip-Hop", "R&B", "Pop", "Electronic"]
    let moods = ["All Moods", "Energetic", "Chill", "Dark", "Happy"]
    
    let tracks: [Track] = (1...20).map { index in
        Track(
            title: "Track \(index)",
            artist: "Artist \(index)",
            imageNumber: ((index - 1) % 6) + 1,
            verified: true
        )
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                // Title Section
                VStack(spacing: 4) {
                    HStack {
                        Text("Hiti")
                            .foregroundColor(HitCraftColors.accent)
                        Text("|")
                            .foregroundColor(HitCraftColors.accent)
                        Text("HitCraft's AI bot")
                            .foregroundColor(.black)
                    }
                    .font(HitCraftFonts.poppins(14, weight: .regular))
                    
                    Text("Listen. Select. Produce")
                        .font(HitCraftFonts.poppins(32, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }
                .padding(.top, 16)
                
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
        .background(HitCraftColors.background)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(HitCraftColors.text)
                }
            }
        }
    }
}

// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var navigationPath = NavigationPath()
    @State private var showingChat = false
    @State private var showingSidebar = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                HitCraftColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Navigation Bar
                    HStack {
                        Button(action: {
                            showingSidebar = true
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                                .frame(width: 44, height: 44)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            navigationPath.append(Destination.chatSummary)
                        }) {
                            Image(systemName: "bubble.right")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                                .frame(width: 44, height: 44)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ChatMainView(showingChat: $showingChat)
                }
            }
            .sheet(isPresented: $showingSidebar) {
                NavigationStack {
                    SidebarView(isOpen: $showingSidebar)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    showingSidebar = false
                                }) {
                                    Text("Done")
                                }
                            }
                        }
                }
                .presentationDetents([.large])
            }
            .navigationDestination(for: Destination.self) { destination in
                if case .chatSummary = destination {
                    ChatSummaryView(isOpen: .constant(true))
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden(false)
                }
            }
            .navigationDestination(isPresented: $showingChat) {
                ChatView()
            }
        }
    }
}
