import Foundation

struct RegisterResponse: Decodable {
    let id: String
    let token: String?
}
