//
//  EditShoppingCartView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/15/21.
//

import SwiftUI

// REVIEW: Small nit here but we could probably extract some of the view
// combinations into their own dedicated view to help consolidate complexity
// inside the ScrollView. Not a blocker or deal breaker.

struct EditShoppingCartView: View {
    @EnvironmentObject var shoppingCartStore: ShoppingCartStore
    @Environment(\.presentationMode) var presentationMode

    /// Current selected order to edit
    @State var order: Order
    @State private var isSaved = false
    @State private var quantityChanged = false

    var body: some View {
        ScrollView {
            // Current product in the order
            let product = order.product
            VStack {
                CacheAsyncImage(url: URL(string: product.imageURL)!) { image in
                    image
                        .resizable()
                        .aspectRatio(2 / 2, contentMode: .fit)
                        .cornerRadius(10)
                        .padding(50)
                } placeholder: {
                    ProgressView()
                }

                Text(product.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text(product.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()

                Text(LocalizedStringKey("Total: \(order.quantity)"))
                    .font(.title2)
                    .fontWeight(.bold)
                NumberPicker(totalNumber: $order.quantity)
                    .onChange(of: order.quantity) { _ in
                        // Enable the save button
                        quantityChanged = true
                    }

                Button(action: {
                    if quantityChanged {
                        isSaved = true
                        Task {
                            await shoppingCartStore.updateOrder(order)
                        }
                    }
                }) {
                    Text(LocalizedStringKey("Save"))
                        .fontWeight(.semibold)
                        .font(.title3)
                        .frame(width: 250, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .buttonStyle(DefaultButtonStyle(disabled: !quantityChanged))
                .alert(isPresented: $isSaved) { () -> Alert in
                    let button = Alert.Button.default(Text(LocalizedStringKey("OK"))) {
                        // Disable save button
                        quantityChanged = false
                        presentationMode.wrappedValue.dismiss()
                    }
                    return Alert(title: Text(LocalizedStringKey("Shopping cart is updated")),
                                 message: Text(LocalizedStringKey("Please continue check out from shopping cart.")),
                                 dismissButton: button)
                }
            }
        }
    }
}

struct DefaultButtonStyle: ButtonStyle {
    var disabled = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(disabled ? .gray : .blue)
            .foregroundColor(.white)
            .cornerRadius(40)
    }
}

struct EditShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        EditShoppingCartView(order: ProductStore.fakeOrder())
    }
}
