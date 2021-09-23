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
        HStack {
            order.product.image
                .resizable()
                .cornerRadius(6)
                .frame(width: 60, height: 60)
                .padding(.trailing, 5)
            VStack(alignment: .leading) {
                Text(order.product.name)
                    .font(.headline)
                    .padding(.bottom, 1)
                HStack {
                    Text("$\(order.product.price) × \(order.quantity)")
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
        OrderRow(order: Order(from: ModelData().menu.drinks[0], quantity: "3"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
