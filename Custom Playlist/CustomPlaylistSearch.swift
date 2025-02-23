import MusicKit
import SwiftUI

struct CustomPlaylistSearch: View {
    let didSelect: (MusicItemID) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var searchName: String = ""
    @State private var playlists: MusicItemCollection<Playlist> = []
    @State private var selection: MusicItemID?

    @State private var currentSearch: Task<(), Never>?

    var body: some View {
        NavigationView {
            VStack {
                if playlists.isEmpty,
                   searchName.count >= 3 {
                    ContentUnavailableView.search
                }

                List(playlists, id: \.id, selection: $selection) { playlist in
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text(playlist.name)
                            Text(playlist.curatorName ?? "")
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        if let url = playlist.artwork?.url(width: 180, height: 180) {
                            AsyncImage(url: url, scale: 3)
                                .aspectRatio(1, contentMode: .fill)
                                .frame(maxHeight: 60)
                        }
                    }.frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Playlist")
            .searchable(text: $searchName)
            .onChange(of: searchName) { _, newValue in
                performSearch(newValue)
            }
            .onChange(of: selection) { _, _ in
                print("selected")
                selection.flatMap(didSelect)
                dismiss()
            }
        }
    }

    /// Makes a new search request to MusicKit when the current search term changes.
    private func performSearch(_ search: String) {
        currentSearch?.cancel()

        guard searchName.count >= 3 else { return }

        currentSearch = Task {
            do {
                let request = MusicCatalogSearchRequest(term: search, types: [Playlist.self])
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
    private func apply(_ response: MusicCatalogSearchResponse) {
        self.playlists = response.playlists
    }
}
