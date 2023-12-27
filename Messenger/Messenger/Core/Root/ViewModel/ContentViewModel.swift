import Firebase
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setuSubscribers()
    }
    
    private func setuSubscribers() {
        
        AuthService().$userSession.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }
}
