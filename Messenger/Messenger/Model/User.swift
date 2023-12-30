import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    
    @DocumentID var uid: String?
    let fullName: String
    let email: String
    var profileImageUrl: String?
    
    var id: String {
        return uid ?? UUID().uuidString
    }
}

extension User {
    static let MOCK_USER = User(fullName: "Sameer Jagtap", email: "jagtap.sameer@yahoo.com", profileImageUrl: "https://avatars.githubusercontent.com/u/16388831?v=4")
}
