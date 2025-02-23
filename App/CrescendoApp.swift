import SwiftUI

@main
struct CrescendoApp: App {

    // MARK: - Object lifecycle

    /// Configures the app when it launches.
    init() {
        adjustVisualAppearance()
    }

    // MARK: - App

    /// The app’s root view.
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 400.0, minHeight: 200.0)
        }
    }

    // MARK: - Methods

    /// Configures the UI appearance of the app.
    private func adjustVisualAppearance() {
        var navigationBarLayoutMargins: UIEdgeInsets = .zero
        navigationBarLayoutMargins.left = 26.0
        navigationBarLayoutMargins.right = navigationBarLayoutMargins.left
        UINavigationBar.appearance().layoutMargins = navigationBarLayoutMargins

        var tableViewLayoutMargins: UIEdgeInsets = .zero
        tableViewLayoutMargins.left = 28.0
        tableViewLayoutMargins.right = tableViewLayoutMargins.left
        UITableView.appearance().layoutMargins = tableViewLayoutMargins
    }
}
