//
//  ProductDetailsView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/30/21.
//

import SwiftUI

struct ProductDetailsView: View {
    let product: Item
    @EnvironmentObject var modelData: ModelData
    @State var total = "1"
    @State private var isAdded = false
    @State private var totalQuantityChanged = true

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: product.imageURL)) { image in
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
                    .onChange(of: total) { _ in
                        // Enable `Add to cart` button
                        totalQuantityChanged = true
                    }

                Button(action: {
                    // Trigger alert
                    isAdded = true
                    // FIXME: Need to use Item next
//                    let order = Order(from: product, quantity: total)
//                    modelData.shoppingCart.addOrder(order)
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
                .disabled(!totalQuantityChanged)
                .alert(isPresented: $isAdded) { () -> Alert in
                    let button = Alert.Button.default(Text("OK")) {
                        // Disable `Add to cart` button
                        totalQuantityChanged = false
                    }
                    return Alert(title: Text("Added to cart"), dismissButton: button)
                }
            }
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(product: ModelData().fakeItems.first!)
    }
}
