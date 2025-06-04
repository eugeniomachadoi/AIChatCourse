import SwiftUI

struct ChatBubbleView: View {
    var text: String = "This is sample text."
    var textColor: Color = .primary
    var backgroundColor: Color = Color(uiColor: .systemGray6)
    var imageName: String?
    var showImage: Bool = true
    let offset: CGFloat = 14
    var onImagePressed: (() -> Void)?

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if showImage {
                ZStack {
                    if let imageName {
                        ImageLoaderView(urlString: imageName)
                            .anyButton {
                                onImagePressed?()
                            }
                    } else {
                        Rectangle()
                            .fill(.secondary)
                    }
                }
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .offset(y: 14)
            }

            Text(text)
                .font(.body)
                .foregroundStyle(textColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(backgroundColor)
                .cornerRadius(6)
        }
        .padding(.bottom, showImage ? offset : 0)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            ChatBubbleView()
            ChatBubbleView(text: "This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This ")

            ChatBubbleView()

            ChatBubbleView(showImage: true)

            ChatBubbleView(text: "This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This This ", backgroundColor: .accent, showImage: false)
        }
        .padding(8)
    }
}
