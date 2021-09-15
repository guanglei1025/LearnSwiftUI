//
//  OrderRow.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/14/21.
//

import SwiftUI

struct OrderRow: View {

//    let order: Order
    let product: Product

    @State var username: String = "9"

    var body: some View {
        HStack {
//            order.product.image
            product.image
                .resizable()
                .cornerRadius(6)
                .frame(width: 60, height: 60)
                .padding(.trailing, 5)
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                    .padding(.bottom, 1)
                Text("$\(product.price)")
                    .foregroundColor(.secondary)
                HStack {
                    Text("Quantity")
                        .foregroundColor(.secondary)
                        .padding(.trailing)
                    TextField("", text: $username)
                        .frame(width: 30, height: 30, alignment: .center)
                        .keyboardType(.numberPad)
                        .foregroundColor(.white)
                        .background(Color.gray)
                }
            }
            Spacer()
        }
    }
}

struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
//        let order = Order(
//            product: ModelData().menu.drinks.first!,
//            quantity: 3
//        )
        OrderRow(product: ModelData().menu.drinks.first!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
