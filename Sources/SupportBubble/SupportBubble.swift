
public class SupportBubble {
    
    public static let shared = SupportBubble()
    
    var clientID: String = ""
    var clientToken: String = ""
    
    public func register(name: String, email: String) {
        print("register")
    }
    
    public func showTicketsView() {
        print("showTicketsView")
    }
    
    public func showTicket(_ ticketID: String) {
        print("showTicket")
    }
    
}
