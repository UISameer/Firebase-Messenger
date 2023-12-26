import Foundation


protocol AuthServiceProvider {
    func login(withEmail: String, password: String) async throws
    func createUser(withEmail: String, password: String, fullName: String) async throws
}


class AuthService: AuthServiceProvider {
    
    func login(withEmail: String, password: String) async throws {
        
        
    }
    
    func createUser(withEmail: String, password: String, fullName: String) async throws {
        
    }
}
