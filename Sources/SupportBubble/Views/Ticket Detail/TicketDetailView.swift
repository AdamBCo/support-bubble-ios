import SwiftUI

@available(iOS 15.0, *)
struct TicketDetailView: View {
    @ObservedObject var viewModel: TicketDetailViewModel
    @State private var newMessage: String = ""
    @State private var isNearBottom = true // To check if the user is near the bottom
    @FocusState private var isInputFieldFocused: Bool
    
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
                        // Scroll only if isNearBottom is true
                        if isNearBottom {
                            withAnimation {
                                value.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                            }
                        }
                    }
                    // Track the scroll position to update isNearBottom
                    .onAppear {
                        value.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                    }
                }
            }
            .onAppear {
                isInputFieldFocused = true // Focus the TextField when the view appears
            }
            .coordinateSpace(name: "scrollViewSpace")
            .onPreferenceChange(ScrollPreferenceKey.self) { value in
                isNearBottom = value.isNearBottom
            }
            
            HStack {
                TextField("Enter message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isInputFieldFocused) // Bind the focus state to TextField
                    
                Button(action: sendMessage) {
                    Text("Send")
                }
            }.padding()
        }
        .task {
            try? await viewModel.loadMessages()
        }
        .onTapGesture {
            isInputFieldFocused = false // Dismiss keyboard on tap outside
        }
    }
    
    private func sendMessage() {
        if !newMessage.isEmpty {
            Task {
                do {
                    try await viewModel.sendMessage(message: newMessage)
                    newMessage = ""
                    isInputFieldFocused = true // Refocus on the TextField after sending
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
