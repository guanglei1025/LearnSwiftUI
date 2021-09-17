//
//  CartView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/13/20.
//

import SwiftUI

struct CartView: View {

    @EnvironmentObject var modelData: ModelData

    var body: some View {
        if modelData.shoppingCart.orders.isEmpty {
            Text("Your cart is empty.")
                .font(.title)
                .fontWeight(.bold)
        } else {
            NavigationView {
                List {
                    ForEach(modelData.shoppingCart.orders) { order in
                        NavigationLink(destination: DetailsView(product: order.product)) {
                            OrderRow(order: order)
                        }
                    }
                    .onDelete(perform: deleteOrder)

                    HStack {
                        Spacer()
                        let amount = modelData.shoppingCart.totalAmount().stringValue
                        Text("Total Amount: $\(amount)")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.trailing)
                    }
                }
                .navigationTitle("Cart")
            }
        }
    }

    func deleteOrder(offsets: IndexSet) {
        modelData.shoppingCart.remove(at: offsets)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(ModelData())
    }
}
