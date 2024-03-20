import Foundation
import SwiftUI
import UIKit

@available(iOS 16.0, *)
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
        // Assuming TicketsScreen conforms to View
        let ticketsView = TicketsListView()
        let hostingController = UIHostingController(rootView: ticketsView)
        
        // Ensure we're on the main thread since UI changes must be on the main thread
        DispatchQueue.main.async {
            if let topVC = self.topViewController() {
                topVC.present(hostingController, animated: true, completion: nil)
            } else {
                print("Error: Could not find top view controller.")
            }
        }
    }
    
    public func showTicket(_ ticketID: String) {
        print("showTicket")
    }
    
    public func logout() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.token.rawValue)
    }
    
    // MARK: - Private Methods
    private func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(selected)
        } else if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
    
}
