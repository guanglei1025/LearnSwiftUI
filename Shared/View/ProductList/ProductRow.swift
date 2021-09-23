//
//  ProductRow.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/12/20.
//

import SwiftUI

struct ProductRow: View {
    let product: Product

    var body: some View {
        HStack {
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
            }
            Spacer()
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: ModelData().menu.drinks[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
