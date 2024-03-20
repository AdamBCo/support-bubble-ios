import Foundation
import SocketIO
import SwiftUI

@available(iOS 14.0.0, *)
class SocketClient {
    
    @AppStorage("token") private static var token: String?
    
    static let manager = SocketManager(
        socketURL: URL(string: "https://supportbubble-d48d6b6f228d.herokuapp.com")!, 
        config: [.log(true), .compress]
    )
    
    static func connect() {
        guard manager.defaultSocket.status != .connected, let token = token else { return }
        manager.defaultSocket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        manager.defaultSocket.connect(
            withPayload: [
                "token": token
            ]
        )
    }
    
}

