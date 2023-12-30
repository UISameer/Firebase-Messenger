import Foundation
import Firebase
import FirebaseFirestoreSwift

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
        Task { try await UserService.shared.fetchCurrentUser() }
        print("DEBUG: User session id is: \(String(describing: userSession?.uid))")
    }
    
    // Login
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: Failed to sign in with error: \(error.localizedDescription)")
        }
    }
    
    // SignUp
    @MainActor
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("DEBUG: Created user: \(result.user.uid)")
            self.userSession = result.user
            // Upload user
            try await self.uploadUserData(email: email, fullName: fullName, id: result.user.uid)
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
    
    func uploadUserData(email: String, fullName: String, id: String) async throws {
        let user = User(fullName: fullName, email: email, profileImageUrl: nil)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
}
