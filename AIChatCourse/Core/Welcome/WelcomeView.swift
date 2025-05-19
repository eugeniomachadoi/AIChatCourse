import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome")
                    .frame(maxHeight: .infinity)

                NavigationLink {
                   OnboardingCompletedView()
                } label: {
                    Text("Get started")
                        .callToActionButton()
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    WelcomeView()
}
