import SwiftUI

@available(iOS 15.0, *)
struct TicketDetailView: View {
    @ObservedObject var viewModel: TicketDetailViewModel
    @State private var newMessage: String = ""
    
    init(id: Ticket.ID) {
        self.viewModel = TicketDetailViewModel(id: id)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { value in
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.messages, id: \.id) { message in
                            Text(message.message ?? "")
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .onChange(of: viewModel.messages.count) { _ in
                        value.scrollTo(viewModel.messages.count - 1, anchor: .bottom)
                    }
                }
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
            self.hideKeyboard()
        }
    }
    
    private func sendMessage() {
        if !newMessage.isEmpty {
            Task {
                try await viewModel.sendMessage(message: newMessage)
                newMessage = ""
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
