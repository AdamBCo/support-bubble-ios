import Foundation
import SocketIO

class SocketClient {
    
    static let manager = SocketManager(
        socketURL: URL(string: "https://supportbubble-d48d6b6f228d.herokuapp.com")!, 
        config: [.log(true), .compress]
    )
    
    static func connect() {
        manager.defaultSocket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        manager.defaultSocket.connect()
    }
    
}

