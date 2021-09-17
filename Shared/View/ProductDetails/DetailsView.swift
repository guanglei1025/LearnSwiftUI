//
//  DetailsView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/12/20.
//

import SwiftUI

struct DetailsView: View {

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
                    .padding(20)

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
                            .font(.title2)
                            .padding(.trailing)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                }
                .padding(30)
                Text("Total: \(total)")
                    .font(.title)
                    .fontWeight(.bold)
                NumberPicker(totalNumber: $total)
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(product: ModelData().menu.foods[0])
    }
}
