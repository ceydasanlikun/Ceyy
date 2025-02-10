import SwiftUI

// MARK: - ViewModels
class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = [
        Product(name: " 15", price: 999.99),
        Product(name: "MacBook Pro", price: 1999.99),
        Product(name: "AirPods Pro", price: 249.99)
    ]
}

class FavoritesViewModel: ObservableObject {
    @Published var favoriteProducts: [Product] = []
}

class CartViewModel: ObservableObject {
    @Published var cartItems: [Product] = []
    @Published var totalPrice: Double = 0.0
    
    func addToCart(product: Product) {
        cartItems.append(product)
        totalPrice += product.price
    }
}

class ProfileViewModel: ObservableObject {
    @Published var username: String = "Kullanıcı Adı"
    @Published var email: String = "ornek@mail.com"
}

// MARK: - Models
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

// MARK: - AppViewModel ve ContentView
class AppViewModel: ObservableObject {
    @Published var selectedTab: Tab = .products
    
    enum Tab {
        case products
        case favorites
        case cart
        case profile
    }
}

struct ContentView: View {
    @StateObject private var viewModel = AppViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.selectedTab {
            case .products:
                ProductsView()
            case .favorites:
                FavoritesView()
            case .cart:
                CartView()
            case .profile:
                ProfileView()
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    viewModel.selectedTab = .products
                }) {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Ürünler")
                    }
                }
                .foregroundColor(viewModel.selectedTab == .products ? .blue : .gray)
                
                Spacer()
                
                Button(action: {
                    viewModel.selectedTab = .favorites
                }) {
                    VStack {
                        Image(systemName: "heart")
                        Text("Favoriler")
                    }
                }
                .foregroundColor(viewModel.selectedTab == .favorites ? .blue : .gray)
                
                Spacer()
                
                Button(action: {
                    viewModel.selectedTab = .cart
                }) {
                    VStack {
                        Image(systemName: "cart")
                        Text("Sepet")
                    }
                }
                .foregroundColor(viewModel.selectedTab == .cart ? .blue : .gray)
                
                Spacer()
                
                Button(action: {
                    viewModel.selectedTab = .profile
                }) {
                    VStack {
                        Image(systemName: "person")
                        Text("Profil")
                    }
                }
                .foregroundColor(viewModel.selectedTab == .profile ? .blue : .gray)
            }
            .padding()
            .background(Color(.systemGray6))
        }
    }
}

// MARK: - Views
struct ProductsView: View {
    @StateObject private var viewModel = ProductsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                    Text("$\(product.price, specifier: "%.2f")")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Ürünler")
        }
    }
}

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.favoriteProducts.isEmpty {
                Text("Favori ürününüz yok")
                    .foregroundColor(.gray)
            } else {
                List(viewModel.favoriteProducts) { product in
                    Text(product.name)
                }
            }
        }
        .navigationTitle("Favoriler")
    }
}

struct CartView: View {
    @StateObject private var viewModel = CartViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.cartItems) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text("$\(item.price, specifier: "%.2f")")
                    }
                }
                
                Text("Toplam: $\(viewModel.totalPrice, specifier: "%.2f")")
                    .font(.headline)
                    .padding()
            }
            .navigationTitle("Sepet")
        }
    }
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
