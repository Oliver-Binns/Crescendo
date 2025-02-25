@testable import Crescendo
import Foundation
import Testing

struct PlaylistSelectionTests {
    @Test("Playlist IDs are correct")
    func playlistSelectionIDs() async throws {
        #expect(
            PlaylistSelection.kids.id ==
            "pl.17e8a3bf3f9f456fa02e52ccd620f003"
        )
        #expect(
            PlaylistSelection.disney.id ==
            "pl.78e6e438bf924405a321b5b72431dd10"
        )
        #expect(
            PlaylistSelection.party.id ==
            "pl.3982707ea63e414aafe1070fe2bb8f9f"
        )
    }

    @Test("Custom Playlist exposes correct ID")
    func customPlaylistSelectionID() async throws {
        let id = UUID().uuidString
        #expect(PlaylistSelection.custom(id).id == id)
    }
}
