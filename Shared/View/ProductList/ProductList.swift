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
                NavigationLink(destination: DetailsView(product: product)) {
                    ProductRow(product: product)
                }
            }
        }
        .navigationTitle(products[0].category.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        ProductList(products: ModelData().menu.drinks)
    }
}
