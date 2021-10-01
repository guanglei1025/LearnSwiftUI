//
//  ProductRow.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/29/21.
//

import SwiftUI

struct ProductRow: View {
    let product: Item

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.imageURL)) { image in
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
                Text("$\(product.price)")
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: ModelData().fakeItems.first!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
