import SwiftUI
import FirebaseFirestore
import SwiftfulFirestore

protocol UserService: Sendable {
    func saveUser(user: UserModel) async throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(userId: String) async throws
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws
}

struct MockUserService: UserService {

    let currentUser: UserModel?

    init(user: UserModel? = nil) {
        self.currentUser = user
    }

    func saveUser(user: UserModel) async throws {
}
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, any Error> {
        AsyncThrowingStream { continuation in
            if let currentUser {
                continuation.yield(currentUser)
            }
        }
    }
    
    func deleteUser(userId: String) async throws {}
    
    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {}
}

struct FirebaseUserService: UserService {

    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }

    func markOnboardingCompleted(userId: String, profileColorHex: String) async throws {
        try await collection.document(userId).updateData([
            UserModel.CodingKeys.didCompleteOnboarding.rawValue: true,
            UserModel.CodingKeys.profileColorHex.rawValue: profileColorHex
        ])
    }

    func saveUser(user: UserModel) async throws {
        try collection.document(user.userId).setData(from: user, merge: true)
    }

    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        collection.streamDocument(id: userId)
    }

    func deleteUser(userId: String) async throws {
        try await collection.document(userId).delete()
    }
}

@MainActor
@Observable
class UserManager {
    private let service: UserService
    private(set) var currentUser: UserModel?
    private(set) var currentUserStream: AsyncThrowingStream<UserModel, Error>?
    private var currentUserListener: ListenerRegistration?

    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }

    func logIn(auth: UserAuthInfo, isNewUser: Bool) async throws {
        let creationVersion = isNewUser ? Utilities.appVersion : nil
        let user = UserModel(auth: auth, creationVersion: creationVersion)

        try await service.saveUser(user: user)
        addCurrentUserListener(userId: auth.uid)
    }

    private func addCurrentUserListener(userId: String) {
        Task {
            do {
                let stream = service.streamUser(userId: userId)
                for try await value in stream {
                    self.currentUser = value
                    print("User(\(userId)) did change.")
                }
                currentUserStream = stream
            } catch {
                print("Error attaching user listener.", error)
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
        try await service.markOnboardingCompleted(userId: uid,
                                                  profileColorHex: profileColorHex)
    }

    func deleteCurrentUser() async throws {
        let uid = try currentUserId()
        try await service.deleteUser(userId: uid)
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
