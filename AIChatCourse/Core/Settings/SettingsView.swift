import SwiftUI

struct SettingsView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        NavigationStack {
            List {
                Button {
                    onSignoutPressed()
                } label: {
                    Text("Sign Out")
                }
            }
            .navigationTitle("Settings")
        }
    }

    func onSignoutPressed() {
        // do some logic to sign user out of app
        appState.updateViewState(showTabBarView: false)
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
