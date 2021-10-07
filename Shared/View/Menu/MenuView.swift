//
//  MenuView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/12/20.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var productStore: ProductStore

    var body: some View {
        NavigationView {
            List {
                let featuredItems = productStore.foods
                if featuredItems.count > 0 {
                    FeaturedView(pages: featuredItems.map {
                        FeaturedCard(product: $0)
                    })
                        .aspectRatio(3 / 2, contentMode: .fit)
                        .listRowInsets(EdgeInsets())
                }

                let foods = productStore.foods
                if foods.count > 0 {
                    NavigationLink(destination: ProductList(products: foods)) {
                        FoodRow(foods: foods)
                    }
                    .listRowInsets(EdgeInsets())
                }

                let drinks = productStore.drinks
                if drinks.count > 0 {
                    NavigationLink(destination: ProductList(products: drinks)) {
                        DrinkRow(drinks: drinks)
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Featured")
        }
        .task {
            await productStore.fetchProducts()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
