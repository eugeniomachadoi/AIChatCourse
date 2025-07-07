@MainActor
struct MockLocalAvatarPersistance: LocalAvatarPersistance {
    func addRecentAvatar(avatar: AvatarModel) throws {

    }

    func getRecentAvatars() throws -> [AvatarModel] {
        AvatarModel.mocks.shuffled()
    }
}
