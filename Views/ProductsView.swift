import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = [
        Product(name: "iPhone 15", price: 999.99),
        Product(name: "MacBook Pro", price: 1999.99),
        Product(name: "AirPods Pro", price: 249.99)
    ]
}

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