//
//  EditShoppingCartView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/15/21.
//

import SwiftUI

struct EditShoppingCartView: View {
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

                Text(product.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()

                Text("Total: \(total)")
                    .font(.title)
                    .fontWeight(.bold)
                NumberPicker(totalNumber: $total)
                Button(action: {
                    modelData.shoppingCart.orders.append(product)
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                        .font(.title3)
                        .frame(width: 200, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .buttonStyle(DefaultButtonStyle())
            }
        }
    }
}

struct DefaultButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(40)
    }
}

struct EditShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        EditShoppingCartView(product: ModelData().menu.foods[0])
    }
}
