import MusicKit
import SwiftUI

struct ContentView: View {
    
    // MARK: - View
    
    @State private var isLoading: Bool = false
    @State private var isPlaying: Bool = false
    @State private var selectedPlaylist: PlaylistSelection = .party {
        didSet {
            fetchPlaylist(selectedPlaylist)
        }
    }
    
    var body: some View {
        rootView
            // Display the development settings view when appropriate.
            .sheet(isPresented: $isDevelopmentSettingsViewPresented) {
                DevelopmentSettingsView()
            }
        
            // Display the welcome view when appropriate.
            .welcomeSheet()
    }
    
    /// The top-level content view.
    private var rootView: some View {
        ScrollView {
            Text("Choose Playlist")
                .font(.largeTitle)
                .fontWeight(.black)
            
            Button {
                selectedPlaylist = .party
            } label: {
                Text("🥳 Party")
            }
            .buttonStyle(.prominent(isSelected: selectedPlaylist == .party))
            
            Button {
                selectedPlaylist = .kids
            } label: {
                Text("🧒 Kids")
            }
            .buttonStyle(.prominent(isSelected: selectedPlaylist == .kids))
            
            Button { 
                selectedPlaylist = .disney
            } label: {
                Text("🏰 Disney")
            }
            .buttonStyle(.prominent(isSelected: selectedPlaylist == .disney))
            
            Button {
                print("coming soon!") // - in app purchase required!
            } label: {
                Text("📋 Custom")
            }
            .buttonStyle(.prominent)

            Divider()
            
            Button {
                Task {
                    try await runMusic()
                }
            } label: {
                if isLoading {
                    ProgressView()
                } else if isPlaying {
                    Label("Pause", systemImage: "pause.fill")
                } else {
                    Label("Play", systemImage: "play.fill")
                }
            }
            .disabled(isLoading)
            .buttonStyle(.prominent)
            .cornerRadius(50)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .fontDesign(.rounded)
        .background(Color.accentColor)
        
        #if DEBUG
        .gesture(hiddenDevelopmentSettingsGesture)
        #endif
        .onAppear {
            fetchPlaylist(selectedPlaylist)
        }
    }
    
    private func runMusic() async throws {
        if !isPlaying {
            isPlaying = true
            try await ApplicationMusicPlayer.shared.play()
            try await Task.sleep(seconds: .random(in: 15...25))
        }
        isPlaying = false
        ApplicationMusicPlayer.shared.pause()
    }
    
    /// Makes a new search request to MusicKit when the current search term changes.
    private func fetchPlaylist(_ playlist: PlaylistSelection) {
        isLoading = true
        
        Task {
            do {
                let id = MusicItemID(rawValue: playlist.id)
                let request = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: id)
                let response = try await request.response()
                
                // Update the user interface with the search response.
                await self.apply(response)
            } catch {
                print("Search request failed with error: \(error).")
                // todo: show error
            }
        }
    }
    
    @MainActor
    private func apply(_ response: MusicCatalogResourceResponse<Playlist>) {
        guard let playlist = response.items.first else { return }
        ApplicationMusicPlayer.shared.state.shuffleMode = .songs
        ApplicationMusicPlayer.shared.queue = [playlist]
        isLoading = false
    }
    
    #if DEBUG
    // MARK: - Development settings
    
    /// `true` if the content view needs to display the development settings view.
    @State var isDevelopmentSettingsViewPresented = false
    
    /// A custom gesture that initiates the presentation of the development settings view.
    private var hiddenDevelopmentSettingsGesture: some Gesture {
        TapGesture(count: 3).onEnded {
            isDevelopmentSettingsViewPresented = true
        }
    }
    #endif
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
