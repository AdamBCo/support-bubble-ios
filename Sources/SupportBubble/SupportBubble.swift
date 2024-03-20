import Foundation

public class SupportBubble {
    
    public static let shared = SupportBubble()
    
    public var clientID: String = ""
    public var clientToken: String = ""
    
    enum UserDefaultKeys: String {
        case token
        case userID
    }
    
    static var userID: String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.userID.rawValue)
        } get {
            return UserDefaults.standard.string(forKey: UserDefaultKeys.userID.rawValue)
        }
    }
    
    static var userToken: String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.token.rawValue)
        } get {
            return UserDefaults.standard.string(forKey: UserDefaultKeys.token.rawValue)
        }
    }
    
    public func register(name: String, email: String) {
        print("register")
    }
    
    public func showTicketsView() {
        print("showTicketsView")
    }
    
    public func showTicket(_ ticketID: String) {
        print("showTicket")
    }
    
    public func logout() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.token.rawValue)
    }
    
}
