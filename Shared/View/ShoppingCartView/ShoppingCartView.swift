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
                    .navigationTitle(LocalizedStringKey("Cart"))
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
                            let amount = shoppingCartStore.shoppingCart.totalAmount().stringValue
                            Text(LocalizedStringKey("Total Amount: $\(amount)"))
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.trailing)
                        }
                    }

                    VStack {
                        Spacer()
                        Button(action: {
                            submitShoppingCart()
                        }) {
                            Text(LocalizedStringKey("Submit order"))
                                .fontWeight(.semibold)
                                .font(.title3)
                                .frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        .buttonStyle(DefaultButtonStyle())
                        .padding(.bottom)
                    }
                }

                .toolbar {
                    EditButton()
                }
                .navigationTitle(LocalizedStringKey("Cart"))
            }
        }
    }

    /// Delete order from `shoppingCart`
    private func deleteOrder(index: IndexSet) {
        var shoppingCart = shoppingCartStore.shoppingCart
        let isLastOrderInCart = shoppingCart.orders.count == 1
        if isLastOrderInCart {
            Task {
                await shoppingCartStore.deleteShoppingCart()
            }
        } else {
            shoppingCart.remove(at: index)
        }
    }
    
    private func submitShoppingCart() {
        Task {
            await shoppingCartStore.submitShoppingCart()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}
