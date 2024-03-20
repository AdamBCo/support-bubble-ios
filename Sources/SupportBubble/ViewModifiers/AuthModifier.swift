import SwiftUI

@available(iOS 16.0, *)
public struct AuthModifier: ViewModifier {
    
    @AppStorage("token") private var token: String?
    
    public init() {
        
    }

    public func body(content: Content) -> some View {
        ZStack {
            if token == nil {
                RegisterView()
            } else {
                content
            }
        }
    }
}
@available(iOS 16.0, *)
extension View {
    func applyAuthGuard() -> some View {
        self.modifier(AuthModifier())
    }
}

