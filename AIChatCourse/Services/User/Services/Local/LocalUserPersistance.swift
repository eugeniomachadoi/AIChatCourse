protocol LocalUserPersistance {
    func getCurrentUser() -> UserModel?
    func saveCurrentUser(user: UserModel?) throws
}
