//
//  EditShoppingCartView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/15/21.
//

import SwiftUI

struct EditShoppingCartView: View {
    @EnvironmentObject var modelData: ModelData
    @State var order: Order

    var body: some View {
        ScrollView {
            VStack {
                order.product.image
                    .resizable()
                    .resizable()
                    .aspectRatio(2 / 2, contentMode: .fit)
                    .cornerRadius(10)
                    .padding(50)

                Text(order.product.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text(order.product.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()

                Text("Total: \(order.quantity)")
                    .font(.title2)
                    .fontWeight(.bold)
                NumberPicker(totalNumber: $order.quantity)
                
                Button(action: {
                    modelData.shoppingCart.updateOrder(order)
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                        .font(.title3)
                        .frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
        let order = Order.init(from: ModelData().menu.foods.first!, quantity: "4")
        EditShoppingCartView(order: order)
    }
}
