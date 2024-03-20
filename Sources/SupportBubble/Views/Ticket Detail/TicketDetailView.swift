import SwiftUI

@available(iOS 16.0, *)
struct TicketDetailView: View {
    @ObservedObject var viewModel: TicketDetailViewModel
    @State private var newMessage: String = ""
    @State private var isNearBottom = true // To check if the user is near the bottom
    
    init(id: Ticket.ID) {
        self.viewModel = TicketDetailViewModel(id: id)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { value in
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.messages, id: \.id) { chatMessage in
                            ChatMessageView(chatMessage: chatMessage)
                        }
                    }
                    .padding()
                    .onChange(of: viewModel.messages.count) { _ in
                        DispatchQueue.main.async {
                            if let lastMessageID = viewModel.messages.last?.id {
                                value.scrollTo(lastMessageID, anchor: .bottom)
                            }
                        }
                    }
                    // Track the scroll position to update isNearBottom
                    .onAppear {
                        DispatchQueue.main.async {
                            if let lastMessageID = viewModel.messages.last?.id {
                                value.scrollTo(lastMessageID, anchor: .bottom)
                            }
                        }
                    }
                }
            }
            .coordinateSpace(name: "scrollViewSpace")
            .onPreferenceChange(ScrollPreferenceKey.self) { value in
                isNearBottom = value.isNearBottom
            }
            
            HStack {
                TextField("Enter message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                Button(action: sendMessage) {
                    Text("Send")
                }
            }.padding()
        }
        .task {
            try? await viewModel.loadMessages()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func sendMessage() {
        if !newMessage.isEmpty {
            Task {
                do {
                    try await viewModel.sendMessage(message: newMessage)
                    newMessage = ""
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// Define a preference key to track the scroll view's position
struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: ScrollData = ScrollData(isNearBottom: true)
    
    static func reduce(value: inout ScrollData, nextValue: () -> ScrollData) {
        value = nextValue()
    }
    
    struct ScrollData: Equatable { // Make ScrollData conform to Equatable
        let isNearBottom: Bool
    }
}

@available(iOS 15.0, *)
extension ScrollView {
    func trackScrollPosition() -> some View {
        self.modifier(TrackScrollModifier())
    }
}

@available(iOS 15.0, *)
struct TrackScrollModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(key: ScrollPreferenceKey.self, value: ScrollPreferenceKey.ScrollData(isNearBottom: proxy.frame(in: .named("scrollViewSpace")).maxY > proxy.size.height - 50))
                }
            )
    }
}
