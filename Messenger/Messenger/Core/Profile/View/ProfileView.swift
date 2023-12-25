import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel()
    let user: User
    
    var body: some View {
        VStack {
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {                        
                        AsyncImage(url: URL(string: user.profileImageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    }
                }
                
                Text(user.fullName)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
                // List
            List {
                Section {
                    ForEach(SettingsOptionsViewModel.allCases) { option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(option.imageBackgroundColor)
                            
                            Text(option.title)
                                .font(.subheadline)
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        
                    }, label: {
                        Text("Log Out")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Delete Account")
                    })
                }
                .foregroundColor(.red)
            }
            
        }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USER)
}
