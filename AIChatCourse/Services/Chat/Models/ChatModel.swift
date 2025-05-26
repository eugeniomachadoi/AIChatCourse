import Foundation

struct ChatModel: Identifiable {
    let id: String
    let userId: String
    let avatarId: String
    let dateCreated: Date
    let dateModified: Date

    static var mock: ChatModel {
        mocks[0]
    }

    static var mocks: [ChatModel] {
        let now = Date()
        return [
            ChatModel(
                id: "chat_001",
                userId: "user_123",
                avatarId: "avatar_abc",
                dateCreated: now.addingTimeInterval(days: -1),
                dateModified: now
            ),
            ChatModel(
                id: "chat_002",
                userId: "user_456",
                avatarId: "avatar_def",
                dateCreated: now.addingTimeInterval(days: -2, hours: -3),
                dateModified: now.addingTimeInterval(hours: -1)
            ),
            ChatModel(
                id: "chat_003",
                userId: "user_789",
                avatarId: "avatar_ghi",
                dateCreated: now.addingTimeInterval(days: -3, hours: -6),
                dateModified: now.addingTimeInterval(hours: -2)
            ),
            ChatModel(
                id: "chat_004",
                userId: "user_101",
                avatarId: "avatar_jkl",
                dateCreated: now.addingTimeInterval(days: -4, hours: -12),
                dateModified: now.addingTimeInterval(hours: -3, minutes: -30)
            )
        ]
    }
}
