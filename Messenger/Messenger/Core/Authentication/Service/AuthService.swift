import Foundation
import Firebase


protocol AuthServiceProvider {
    func login(withEmail: String, password: String) async throws
    func createUser(withEmail: String, password: String, fullName: String) async throws
    func signOut()
}

class AuthService: AuthServiceProvider {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    private init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: User session id is: \(String(describing: userSession?.uid))")
    }
    
    // Login
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: Failed to sign in with error: \(error.localizedDescription)")
        }
    }
    
    // SignUp
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("DEBUG: Created user: \(result.user.uid)")
        } catch  {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    // SignOut
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch  {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
}
