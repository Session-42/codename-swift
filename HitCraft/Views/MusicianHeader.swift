import SwiftUI

struct MusicianHeader: View {
    let musician: Musician
    let showSwitchOption: Bool
    let title: String
    let showTalentGPT: Bool
    @State private var showingMusicianPicker = false
    @Binding var selectedMusician: Musician
    
    init(musician: Musician, showSwitchOption: Bool, title: String, showTalentGPT: Bool, selectedMusician: Binding<Musician>) {
        self.musician = musician
        self.showSwitchOption = showSwitchOption
        self.title = title
        self.showTalentGPT = showTalentGPT
        self._selectedMusician = selectedMusician
    }
    
    var body: some View {
        HStack {
            Spacer()
            if showSwitchOption {
                Button(action: { showingMusicianPicker = true }) {
                    HStack(spacing: 8) {
                        Text(musician.name)
                            .font(HitCraftFonts.poppins(18, weight: .medium))
                            .foregroundColor(HitCraftColors.accent)
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14))
                            .foregroundColor(HitCraftColors.accent)
                    }
                }
                .sheet(isPresented: $showingMusicianPicker) {
                    MusicianPickerView(selectedMusician: $selectedMusician, isPresented: $showingMusicianPicker)
                }
                
                Text("•")
                    .foregroundColor(HitCraftColors.accent)
            } else {
                Text(musician.name)
                    .font(HitCraftFonts.poppins(18, weight: .medium))
                    .foregroundColor(HitCraftColors.accent)
            }
            
            Text(showTalentGPT ? "TalentGPT™" : title)
                .font(HitCraftFonts.poppins(18, weight: .light))
                .foregroundColor(.black)
            Spacer()
        }
        .frame(height: 44)
        .padding(.horizontal, 20)
    }
}

struct MusicianPickerView: View {
    @Binding var selectedMusician: Musician
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            List(Musician.sampleMusicians) { musician in
                Button(action: {
                    selectedMusician = musician
                    isPresented = false
                }) {
                    HStack {
                        Text(musician.name)
                            .font(HitCraftFonts.poppins(18, weight: .medium))
                            .foregroundColor(.black)
                        
                        if musician.id == selectedMusician.id {
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(HitCraftColors.accent)
                        }
                    }
                }
                .listRowSeparator(.hidden)
                .padding(.vertical, 4)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Select Musician")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    MusicianHeader(
        musician: Musician.sampleMusicians[0],
        showSwitchOption: true,
        title: "CHAT",
        showTalentGPT: false,
        selectedMusician: .constant(Musician.sampleMusicians[0])
    )
}
