import SwiftUI

@MainActor
@Observable
class UserManager {
    private let remote: RemoteUserService
    private let local: LocalUserPersistance
    private(set) var currentUser: UserModel?
    private(set) var currentUserStream: AsyncThrowingStream<UserModel, Error>?
    private var currentUserListener: ListenerRegistration?

    init(services: UserServices) {
        self.remote = services.remote
        self.local = services.local
        self.currentUser = local.getCurrentUser()
    }

    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)

        try await remote.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid)

    }

    private func addCurrentUserListener(userId: String) {
        Task {
            do {
                let stream = remote.streamUser(userId: userId)
                for try await value in stream {
                    self.currentUser = value
                    self.saveCurrentUsrLocally()
                    print("Successfully listened to user: \(userId)")
                }
                currentUserStream = stream
            } catch {
                print("Error attaching user listener.", error)
            }
        }
    }

    private func saveCurrentUsrLocally() {
        Task {
            do {
                try local.saveCurrentUser(user: currentUser)
                print("Success saved current user locally")
            } catch {
                print("Error saving current user locally: \(error)")
            }
        }
    }

    func signOut() {
        currentUserListener?.remove()
        currentUserListener = nil
        currentUser = nil
    }

    func markOnboardingCompleteForCurrentUser(profileColorHex: String) async throws {
        let uid = try currentUserId()
        try await remote.markOnboardingCompleted(userId: uid,
                                                 profileColorHex: profileColorHex)
    }

    func deleteCurrentUser() async throws {
        let uid = try currentUserId()
        try await remote.deleteUser(userId: uid)
        signOut()
    }

    private func currentUserId() throws -> String {
        guard let uid = currentUser?.userId else {
            throw UserManagerError.noUserId
        }

        return uid
    }

    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
