import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favoriteProducts: [Product] = []
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