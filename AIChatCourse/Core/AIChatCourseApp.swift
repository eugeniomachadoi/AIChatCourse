import SwiftUI
import FirebaseCore

@main
struct AIChatCourseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            EnvironmentBuilderView {
                AppView()
                    .environment(delegate.dependencies.authManager)
                    .environment(delegate.dependencies.userManager)
                    .environment(delegate.dependencies.aiManager)
            }
        }
    }
}

struct EnvironmentBuilderView<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Dependencies!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        dependencies = Dependencies()
        return true
    }
}

@MainActor
struct Dependencies {
    let authManager: AuthManager
    let userManager: UserManager
    let aiManager: AIManager

    init() {
        authManager = AuthManager(service: FirebaseAuthService())
        userManager = UserManager(services: ProductionUserServices())
        aiManager = AIManager(service: OpenAIService())
    }
}
