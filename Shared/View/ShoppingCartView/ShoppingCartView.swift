//
//  CartView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/13/20.
//

import SwiftUI

struct ShoppingCartView: View {

    @EnvironmentObject var shoppingCartStore: ShoppingCartStore
    @EnvironmentObject var productStore: ProductStore

    var body: some View {

        let orders = shoppingCartStore.shoppingCart.orders

        if orders.isEmpty {
            NavigationView {
                EmptyShoppingCartView()
                    .navigationTitle("Cart")
            }
        } else {
            NavigationView {
                ZStack {
                    List {
                        ForEach(orders) { order in
                            NavigationLink(destination: EditShoppingCartView(order: order)) {
                                OrderRow(order: order)
                            }
                        }
                        .onDelete(perform: deleteOrder)
                        HStack {
                            Spacer()
                            let amount = totalAmount(in: shoppingCartStore.shoppingCart,
                                                     productStore: productStore)
                            Text("Total Amount: $\(amount)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.trailing)
                        }
                    }

                    VStack {
                        Spacer()
                        Button(action: {
                            shoppingCartStore.submitOrder()
                        }) {
                            Text("Submit order")
                                .fontWeight(.semibold)
                                .font(.title3)
                                .frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(DefaultButtonStyle())
                        .padding(.bottom, 50)
                    }
                }

                .toolbar {
                    EditButton()
                }
                .navigationTitle("Cart")
            }
        }
    }

    /// Get the total amount of the `shoppingCart`
    private func totalAmount(in shoppingCart: ShoppingCart, productStore: ProductStore) -> String {
        var sum: Decimal = 0
        for order in shoppingCart.orders {
            let product = productStore.getProduct(from: order.productId)
            sum = sum + amount(of: product, in: order)
        }
        return sum.stringValue
    }

    /// Delete order from `shoppingCart`
    private func deleteOrder(index: IndexSet) {
        shoppingCartStore.shoppingCart.remove(at: index)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}
