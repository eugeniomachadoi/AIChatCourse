import SwiftUI

protocol RemoteAvatarService: Sendable {
    func createAvatar(avatar: AvatarModel, image: UIImage) async throws
    func getAvatar(id: String) async throws -> AvatarModel
    func getFeaturedAvatars() async throws -> [AvatarModel]
    func getPopularAvatars() async throws -> [AvatarModel]
    func getAvatarsForCategory(category: CharacterOption) async throws -> [AvatarModel]
    func getAvatarsForAuthor(userId: String) async throws -> [AvatarModel]
}
