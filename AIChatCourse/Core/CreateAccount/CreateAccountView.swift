import SwiftUI

struct CreateAccountView: View {
    @Environment(\.authService) private var authService
    @Environment(\.dismiss) private var dismiss
    var title: String = "Create account?"
    var subtitle: String = "Don't lose your data! Connect to an SSO provider to sabve your account."
    var onDidSignIn: ((_ isNewUser: Bool) -> Void)?

    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text(subtitle)
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            SignInWithAppleButtonView(
                type: .signIn,
                style: .black,
                cornerRadius: 10)
            .frame(height: 55)
            .anyButton(.press) {
                onSignInApplePressed()
            }

            Spacer()
        }
        .padding(16)
        .padding(.top, 40)
    }

    func onSignInApplePressed() {
        Task {
            do {
                let result = try await authService.signInApple()
                onDidSignIn?(result.isNewUser)
                dismiss()
            } catch {
                print("Error signing with apple!")
            }
        }
    }
}

#Preview {
    CreateAccountView()
}
