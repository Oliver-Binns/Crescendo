#if DEBUG
import SwiftUI

/// DevelopmentSettingsView is a view that offers controls for hidden settings.
/// This is a developer-only tool to temporarily hide certain key features of the app.
struct DevelopmentSettingsView: View {

    // MARK: - View

    var body: some View {
        NavigationView {
            settingsList
                .navigationBarTitle("Development Settings", displayMode: .inline)
        }
    }

    private var settingsList: some View {
        List {

        }
    }
}

// MARK: - Previews

struct DevelopmentSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DevelopmentSettingsView()
    }
}
#endif
