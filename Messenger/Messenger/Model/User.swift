import Foundation

struct User: Codable, Identifiable, Hashable {
    
    var id = UUID().uuidString
    let fullName: String
    let email: String
    var profileImageUrl: String?
}

extension User {
    static let MOCK_USER = User(fullName: "Sameer Jagtap", email: "jagtap.sameer@yahoo.com", profileImageUrl: "https://avatars.githubusercontent.com/u/16388831?v=4")
}
