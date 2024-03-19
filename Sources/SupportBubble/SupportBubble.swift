
class SupportBubble {
    
    static let shared = SupportBubble()
    
    func register(name: String, email: String) {
        print("register")
    }
    
    func showTicketsView() {
        print("showTicketsView")
    }
    
    func showTicket(_ ticketID: String) {
        print("showTicket")
    }
}
