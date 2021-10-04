//
//  CartView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/13/20.
//

import SwiftUI

struct ShoppingCartView: View {

    @EnvironmentObject var shoppingCartStore: ShoppingCartStore

    var body: some View {

        let orders = shoppingCartStore.shoppingCart.orders

        if orders.isEmpty {
            NavigationView {
                EmptyShoppingCartView()
                    .navigationTitle("Cart")
            }
        } else {
            NavigationView {
                List {
                    ForEach(orders) { order in
                        NavigationLink(destination: EditShoppingCartView(order: order)) {
                            OrderRow(order: order)
                        }
                    }
                    .onDelete(perform: deleteOrder)
                    HStack {
                        Spacer()
                        let amount = shoppingCartStore.shoppingCart.totalAmount().stringValue
                        Text("Total Amount: $\(amount)")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.trailing)
                    }
                }
                .toolbar {
                    EditButton()
                }
                .navigationTitle("Cart")
            }
        }
    }

    func deleteOrder(index: IndexSet) {
        shoppingCartStore.shoppingCart.remove(at: index)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}
