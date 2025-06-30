struct MockUserPersistance: LocalUserPersistance {
    let currentUser: UserModel?

    init(user: UserModel? = nil) {
        self.currentUser = user
    }

    func getCurrentUser() -> UserModel? {
        currentUser
    }

    func saveCurrentUser(user: UserModel?) throws {

    }
}
