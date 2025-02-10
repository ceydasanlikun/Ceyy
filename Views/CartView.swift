import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cartItems: [Product] = []
    @Published var totalPrice: Double = 0.0
    
    func addToCart(product: Product) {
        cartItems.append(product)
        totalPrice += product.price
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