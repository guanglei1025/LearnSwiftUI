//
//  ProductList.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/12/20.
//

import SwiftUI

struct ProductList: View {

    var products: [Product]

    var body: some View {
        List {
            ForEach(products) { product in
                NavigationLink(destination: ProductDetailsView(product: product)) {
                    ProductRow(product: product)
                }
            }
        }
        // REVIEW: We should capitalize the navigation title
        .navigationTitle(products[0].category.capitalized(with: .current))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        ProductList(products: ProductStore.fakeItems())
    }
}
