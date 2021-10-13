//
//  OrderRow.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 14/09/2021.
//

import SwiftUI

struct OrderRow: View {
    let order: Order

    var body: some View {
        // Current product in the order
        let product = order.product
        
        HStack {
            CacheAsyncImage(url: URL(string: product.imageURL)!) { image in
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
                    let amount = amount(of: product, in: order)
                    Text("$\(amount.stringValue)")
                }
            }
            Spacer()
        }
    }
}

/// Calculate the amount of an `order`, which contains the `product`
func amount(of product: Product, in order: Order) -> Decimal {
    product.priceInDecimal * Decimal(order.quantity)
}


struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderRow(order: ProductStore.fakeOrder())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
