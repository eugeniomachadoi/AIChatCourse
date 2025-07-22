import Foundation

struct ChatMessageModel: Identifiable, Codable {
    let id: String
    let chatId: String
    let authorId: String?
    let content: AIChatModel?
    let seenByIds: [String]?
    let dateCreated: Date?

    init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: AIChatModel? = nil,
        seenByIds: [String]? = nil,
        dateCreated: Date? = nil
    ) {
        self.id = id
        self.chatId = chatId
        self.authorId = authorId
        self.content = content
        self.seenByIds = seenByIds
        self.dateCreated = dateCreated
    }

    func hasBeenSeenByCurrentUser(userId: String) -> Bool {
        guard let seenByIds else { return false }
        return seenByIds.contains(userId)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case chatId = "chat_id"
        case authorId = "author_id"
        case content
        case seenByIds = "seen_by_ids"
        case dateCreated = "date_created"
    }

    static func newUserMessage(chatId: String, userId: String, message: AIChatModel) -> Self {
        ChatMessageModel(
           id: UUID().uuidString,
           chatId: chatId,
           authorId: userId,
           content: message,
           seenByIds: [userId],
           dateCreated: .now
       )
    }

    static func newAIMessage(chatId: String, avatarId: String, message: AIChatModel) -> Self {
        ChatMessageModel(
            id: UUID().uuidString,
            chatId: chatId,
            authorId: avatarId,
            content: message,
            seenByIds: [],
            dateCreated: .now
        )
    }

    static var mock: ChatMessageModel {
        mocks[0]
    }

    static var mocks: [ChatMessageModel] {
        let now = Date()
        return [
            ChatMessageModel(
                id: "msg_001",
                chatId: "chat_001",
                authorId: UserAuthInfo.mock().uid,
                content: AIChatModel(role: .user, message: "Hello, how are you?"),
                seenByIds: ["user_123"],
                dateCreated: now.addingTimeInterval(hours: -3)
            ),
            ChatMessageModel(
                id: "msg_002",
                chatId: "chat_001",
                authorId: AvatarModel.mock.avatarId,
                content: AIChatModel(role: .assistant, message: "I'm doign well, thanks for asking!"),
                seenByIds: ["user_123", "user_456"],
                dateCreated: now.addingTimeInterval(hours: -2, minutes: -45)
            ),
            ChatMessageModel(
                id: "msg_003",
                chatId: "chat_002",
                authorId: UserAuthInfo.mock().uid,
                content: AIChatModel(role: .user, message: "Anyone up for a game tonight?"),
                seenByIds: ["user_789", "user_101"],
                dateCreated: now.addingTimeInterval(hours: -1, minutes: -15)
            ),
            ChatMessageModel(
                id: "msg_004",
                chatId: "2",
                authorId: AvatarModel.mock.avatarId,
                content: AIChatModel(role: .assistant, message: "Sure count me in!"),
                seenByIds: nil,
                dateCreated: now.addingTimeInterval(minutes: -30)
            )
        ]
    }
}
