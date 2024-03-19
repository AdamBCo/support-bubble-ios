import Foundation

struct ChatMessageRequest: Encodable {
    let clientID: String
    let message: String
    let ticketID: String
}
