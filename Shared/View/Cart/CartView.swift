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
        if modelData.shoppingCart.products.isEmpty {
            Text("Your cart is empty.")
                .font(.title)
                .fontWeight(.bold)
        } else {
            NavigationView {
                List {
                    ForEach(modelData.shoppingCart.products) { product in
                        NavigationLink(destination: DetailsView(product: product)) {
                            ProductRow(product: product)
                        }
                    }
                    .onDelete(perform: deleteProduct)

                    HStack {
                        Spacer()
                        let amount = modelData.shoppingCart.totalAmount.stringValue
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

    func deleteProduct(offsets: IndexSet) {

    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(ModelData())
    }
}
