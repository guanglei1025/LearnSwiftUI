//
//  ShoppingCartProductRow.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 14/09/2021.
//

import SwiftUI

struct ShoppingCartProductRow: View {
    
    /// Current product in the row
    let product: Product
    
    var body: some View {
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
                    Text("$\(product.price) × \(product.selectedQuantity)")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("$\(product.selectedAmountInDecimal.stringValue)")
                }
            }
            Spacer()
        }
    }
}

struct ShoppingCartProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartProductRow(product: ProductStore.fakeProduct())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
