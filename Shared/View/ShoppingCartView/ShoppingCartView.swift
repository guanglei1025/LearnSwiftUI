//
//  CartView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/13/20.
//

import SwiftUI

struct ShoppingCartView: View {

    @EnvironmentObject var modelData: ModelData

    var body: some View {
        if modelData.shoppingCart.products.isEmpty {
            NavigationView {
                EmptyShoppingCartView()
                .navigationTitle("Cart")
            }
        } else {
            NavigationView {
                List {
                    ForEach(modelData.shoppingCart.orders) { order in
                        NavigationLink(destination: DetailsView(product: order.product)) {
                            OrderRow(order: order)
                        }
                    }
                    .onDelete(perform: deleteProduct)

                    HStack {
                        Spacer()
                        let amount = modelData.shoppingCart.totalAmount().stringValue
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

    func deleteProduct(offsets: IndexSet) {
        // FIXME: Delete order from shopping cart
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
            .environmentObject(ModelData())
    }
}
