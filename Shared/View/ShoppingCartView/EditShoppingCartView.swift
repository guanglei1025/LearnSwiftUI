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
    @State private var isSaved = false
    @State private var totalQuantityChanged = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: order.product.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(2 / 2, contentMode: .fit)
                        .cornerRadius(10)
                        .padding(50)
                } placeholder: {
                    ProgressView()
                }

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
                    .onChange(of: order.quantity) { _ in
                        // Enable the save button
                        totalQuantityChanged = true
                    }
                
                Button(action: {
                    // Trigger alert once value is true
                    isSaved = true
                    modelData.shoppingCart.updateOrder(order)
                }) {
                    Text("Save")
                        .fontWeight(.semibold)
                        .font(.title3)
                        .frame(minWidth: 0, maxWidth: 250)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                }
                .disabled(!totalQuantityChanged)
                .alert(isPresented: $isSaved) { () -> Alert in
                    let button = Alert.Button.default(Text("OK")) {
                        // Disable save button
                        totalQuantityChanged = false
                    }
                    return Alert(title: Text("Order is updated"), dismissButton: button)
                }
            }
        }
    }
}

struct EditShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        let order = Order(from: ProductStore.fakeItems().first!, quantity: "4")
        EditShoppingCartView(order: order)
    }
}
