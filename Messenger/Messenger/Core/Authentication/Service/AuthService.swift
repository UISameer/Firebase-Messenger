import Foundation
import Firebase

protocol AuthServiceProvider {
    func login(withEmail: String, password: String) async throws
    func createUser(withEmail: String, password: String, fullName: String) async throws
}


class AuthService: AuthServiceProvider {
    
    func login(withEmail: String, password: String) async throws {
        
        
    }
    
    func createUser(withEmail: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: withEmail, password: password)
            print("DEBUG: Created user: \(result.user.uid)")
        } catch  {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
    }
}
