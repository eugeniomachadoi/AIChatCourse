import SwiftUI

struct FileManagerUserPersistence: LocalUserPersistance {
    private let userDocumentKey = "current_user"

    func getCurrentUser() -> UserModel? {
        try? FileManager.getDocument(key: "current_user")
    }

    func saveCurrentUser(user: UserModel?) throws {
        try FileManager.saveDocument(key: "current_user", value: user)
    }
}
