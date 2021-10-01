//
//  ProductList.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/12/20.
//

import SwiftUI

struct ProductList: View {

    var products: [Item]

    var body: some View {
        List {
            ForEach(products) { product in
                NavigationLink(destination: ProductDetailsView(product: product)) {
                    ProductRow(product: product)
                }
            }
        }
        .navigationTitle(products[0].category)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        ProductList(products: ModelData().fakeItems)
    }
}
