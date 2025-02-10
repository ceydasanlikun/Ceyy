import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var username: String = "Kullanıcı Adı"
    @Published var email: String = "ornek@mail.com"
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profil Bilgileri")) {
                    TextField("Kullanıcı Adı", text: $viewModel.username)
                    TextField("E-posta", text: $viewModel.email)
                }
            }
            .navigationTitle("Profil")
        }
    }
} 