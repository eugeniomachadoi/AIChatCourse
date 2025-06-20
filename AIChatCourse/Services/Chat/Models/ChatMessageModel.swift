import Foundation

struct ChatMessageModel: Identifiable {
    let id: String
    let chatId: String
    let authorId: String?
    let content: String?
    let seenByIds: [String]?
    let dateCreated: Date?

    init(
        id: String,
        chatId: String,
        authorId: String? = nil,
        content: String? = nil,
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

    static var mock: ChatMessageModel {
        mocks[0]
    }

    static var mocks: [ChatMessageModel] {
        let now = Date()
        return [
            ChatMessageModel(
                id: "msg_001",
                chatId: "chat_001",
                authorId: "1",
                content: "Hey, how's it going?",
                seenByIds: ["user_123"],
                dateCreated: now.addingTimeInterval(hours: -3)
            ),
            ChatMessageModel(
                id: "msg_002",
                chatId: "chat_001",
                authorId: "2",
                content: "All good! You?",
                seenByIds: ["user_123", "user_456"],
                dateCreated: now.addingTimeInterval(hours: -2, minutes: -45)
            ),
            ChatMessageModel(
                id: "msg_003",
                chatId: "chat_002",
                authorId: "1",
                content: "Meeting at 2pm confirmed.",
                seenByIds: ["user_789", "user_101"],
                dateCreated: now.addingTimeInterval(hours: -1, minutes: -15)
            ),
            ChatMessageModel(
                id: "msg_004",
                chatId: "2",
                authorId: "user_101",
                content: "Got it, thanks!",
                seenByIds: nil,
                dateCreated: now.addingTimeInterval(minutes: -30)
            )
        ]
    }
}
