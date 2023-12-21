import SwiftUI

struct InboxView: View {
    
    @State private var showMessageView = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                OnlineMembersView()
                List {
                    ForEach(0 ... 10, id: \.self) { message in
                        InboxRowView()
                    }
                }
                .listStyle(PlainListStyle())
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            .fullScreenCover(isPresented: $showMessageView, content: {
                NewMessageView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName:"person.circle.fill")
                        Text("Chats")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showMessageView.toggle()
                    }, label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    })
                }
            }
        }
    }
}

#Preview {
    InboxView()
}
