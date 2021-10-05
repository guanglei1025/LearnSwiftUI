//
//  OrderRow.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 14/09/2021.
//

import SwiftUI

struct OrderRow: View {
    let order: Order
    @EnvironmentObject var productStore: ProductStore

    var body: some View {
        // Current product in the order
        let product = productStore.getProduct(from: order.productId)

        HStack {
            AsyncImage(url: URL(string: product.imageURL)) { image in
                image
                    .resizable()
                    .cornerRadius(6)
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 5)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                    .padding(.bottom, 1)
                HStack {
                    Text("$\(product.price) × \(order.quantity)")
                        .foregroundColor(.secondary)
                    Spacer()
                    let amount = order.totalAmount().stringValue
                    Text("$\(amount)")
                }
            }
            Spacer()
        }
    }
}

struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderRow(order: ProductStore.fakeOrder())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
