import Foundation
import SwiftUI
import PhotosUI

enum SettingsOptionsViewModel: Int, CaseIterable, Identifiable {
    case darMode
    case activeStatus
    case accesibility
    case privacy
    case notifications
    
    var title: String {
        switch self {
            case .darMode:
                return "Dark Mode"
            case .activeStatus:
                return "Active Status"
            case .accesibility:
                return "Accesibility"
            case .privacy:
                return "Privacy"
            case .notifications:
                return "Notifications"
        }
    }
    
    var imageName: String {
        switch self {
            case .darMode:
                return "moon.circle.fill"
            case .activeStatus:
                return "message.badge.circle.fill"
            case .accesibility:
                return "person.circle.fill"
            case .privacy:
                return "lock.circle.fill"
            case .notifications:
                return "bell.circle.fill"
        }
    }
    
    var imageBackgroundColor: Color {
        switch self {
            case .darMode:
                return .black
            case .activeStatus:
                return Color(.systemGreen)
            case .accesibility:
                return .black
            case .privacy:
                return Color(.systemBlue)
            case .notifications:
                return Color(.systemPurple)
        }
    }
    
    var id: Int { return self.rawValue }
}

class ProfileViewModel: ObservableObject {
    
    @Published var selectedItem: PhotosPickerItem? {
        
        didSet {
            Task {
                try await loadImage()
            }
        }
    }
    
    @Published var profileImage: Image?
    
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let image = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: image)
    }
}
