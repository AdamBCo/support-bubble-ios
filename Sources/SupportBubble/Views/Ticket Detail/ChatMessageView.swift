import SwiftUI

@available(iOS 15.0, *)
struct ChatMessageView: View {
    
    private let chatMessage: ChatMessage
    
    init(chatMessage: ChatMessage) {
        self.chatMessage = chatMessage
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(chatMessage.message ?? "Unknown")
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
}
