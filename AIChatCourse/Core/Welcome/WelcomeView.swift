import SwiftUI

struct WelcomeView: View {
    @State private var imageName: String = Constants.randomImage
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                ImageLoaderView(urlString: imageName)
                    .ignoresSafeArea()

                titleSection
                    .padding(.top, 24)

                ctaButtons
                    .padding(16)

                policyLinks
            }
        }
    }

    private var titleSection: some View {
        VStack {
            Text("AI Chat 🤙")
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text("Youtube @ SwitfulThinking")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var ctaButtons: some View {
        VStack(spacing: 8) {
            NavigationLink {
                OnboardingIntroView()
            } label: {
                Text("Get started")
                    .callToActionButton()
            }

            Text("Already have an account? Sign in!")
                .underline()
                .font(.body)
                .padding(8)
                .tappableBackground()
                .onTapGesture {

                }
        }
    }

    private var policyLinks: some View {
        HStack(spacing: 8) {
            Link(destination: URL(string: Constants.termosOfServiceURL)!) {
                Text("Terms of Service")
            }

            Circle()
                .fill(.accent)
                .frame(width: 4, height: 4)

            Link(destination: URL(string: Constants.privacyPolicyURL)!) {
                Text("Privacy Policy")
            }
        }
    }
}

#Preview {
    WelcomeView()
}
