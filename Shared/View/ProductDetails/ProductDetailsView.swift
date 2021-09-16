//
//  ProductDetailsView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/12/20.
//

import SwiftUI

struct ProductDetailsView: View {

    let product: Product
    @EnvironmentObject var modelData: ModelData
    @State var total = "1"

    var body: some View {
        ScrollView {
            VStack {
                product.image
                    .resizable()
                    .resizable()
                    .aspectRatio(2 / 2, contentMode: .fit)
                    .cornerRadius(10)
                    .padding(50)

                Text(product.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text("$\(product.price)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)

                Text(product.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()

                Text("Total: \(total)")
                    .font(.title2)
                    .fontWeight(.bold)
                NumberPicker(totalNumber: $total)
                Button(action: {
                    let totalInt = Int(total) ?? 0
                    modelData.shoppingCart.orders.append(Order(from: product, quantity: totalInt))
                }) {
                    HStack {
                        Image(systemName: "cart")
                            .font(.title)
                            .padding(.leading)
                            .padding(.trailing)
                        Text("Add to Cart")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .frame(minWidth: 0, maxWidth: 250)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                }
            }
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(product: ModelData().menu.foods[0])
    }
}
