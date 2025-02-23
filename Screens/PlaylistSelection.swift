enum PlaylistSelection {
    case kids
    case disney
    case party
    case custom(String)

    var id: String {
        switch self {
        case .kids:
            return "pl.17e8a3bf3f9f456fa02e52ccd620f003"
        case .disney:
            return "pl.78e6e438bf924405a321b5b72431dd10"
        case .party:
            return "pl.3982707ea63e414aafe1070fe2bb8f9f"
        case .custom(let id):
            return id
        }
    }
}

extension PlaylistSelection: Equatable { }
