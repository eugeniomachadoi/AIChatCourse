import SwiftUI

struct AppView: View {
    @AppStorage("showTabbarView") var showTabBar: Bool = false

    var body: some View {
        AppViewBuilder(
            showTabBar: showTabBar,
            tabbarView: {
                ZStack {
                    Color.red.ignoresSafeArea()
                    Text("Tabbar")
                }
            },
            onboardingView: {
                ZStack {
                    Color.blue.ignoresSafeArea()
                    Text("Onboarding")
                }
            }
        )
    }
}

#Preview("AppView - Tabbar") {
    AppView(showTabBar: false)
}

#Preview("AppView - Onboarding") {
    AppView(showTabBar: true)
}
