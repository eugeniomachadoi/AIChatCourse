import SwiftData
import SwiftUI

struct SwiftDataLocalAvatarPersistance: LocalAvatarPersistance {
    private let container: ModelContainer
    private var mainContext: ModelContext {
        container.mainContext
    }

    init() {
        // swiftlint:disable:next force_try
        self.container = try! ModelContainer(for: AvatarEntity.self)
    }

    func addRecentAvatar(avatar: AvatarModel) throws {
        let entity = AvatarEntity(from: avatar)
        mainContext.insert(entity)
        try mainContext.save()
    }

    func getRecentAvatars() throws -> [AvatarModel] {
        let descriptor = FetchDescriptor<AvatarEntity>(sortBy: [SortDescriptor(\.dateAdded,
                                                                                order: .reverse)])
        let entities = try mainContext.fetch(descriptor)

        return entities.map { $0.toModel() }
    }
}
