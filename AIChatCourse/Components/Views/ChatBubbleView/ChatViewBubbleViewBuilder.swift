import SwiftUI

struct ChatViewBubbleViewBuilder: View {
    var message: ChatMessageModel = .mock
    var isCurrentUser: Bool = false
    var imageName: String?
    var onImagePressed: (() -> Void)?

    var body: some View {
        ChatBubbleView(
            text: message.content?.message ?? "",
            textColor: isCurrentUser ? .white : .primary,
            backgroundColor: isCurrentUser ? .accent : Color(uiColor: .systemGray6),
            imageName: imageName,
            showImage: !isCurrentUser,
            onImagePressed: onImagePressed
        )
        .frame(maxWidth: .infinity,
               alignment: isCurrentUser ? .trailing : .leading)
        .padding(.leading, isCurrentUser ? 75 : 0)
        .padding(.trailing, isCurrentUser ? 0 : 75)
    }
}

#Preview {
    VStack(spacing: 24) {
        ChatViewBubbleViewBuilder()
        ChatViewBubbleViewBuilder(isCurrentUser: true)
        ChatViewBubbleViewBuilder(
            message: ChatMessageModel(
                id: UUID().uuidString,
                chatId: UUID().uuidString,
                authorId: UUID().uuidString,
                content: AIChatModel(role: .user, message: "This is some longer content that goes on to multiple lines and keeps on going to another line!"),
                seenByIds: nil,
                dateCreated: .now
            )
        )

        ChatViewBubbleViewBuilder(
            message: ChatMessageModel(
                id: UUID().uuidString,
                chatId: UUID().uuidString,
                authorId: UUID().uuidString,
                content: AIChatModel(role: .user, message: "This is some longer content that goes on to multiple lines and keeps on going to another line!"),
                seenByIds: nil,
                dateCreated: .now
            ),
            isCurrentUser: true
        )

    }
    .padding(12)
}
