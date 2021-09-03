//
//  MenuView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/12/20.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationView {
            List {
                PageView(pages: modelData.menu.foods.map {
                    FeatureCard(product: $0)
                })
                .aspectRatio(3 / 2, contentMode: .fit)
                .listRowInsets(EdgeInsets())

                NavigationLink(destination: ProductList(products: ModelData().menu.foods)) {
                    FoodRow(foods: ModelData().menu.foods)
                }
                .listRowInsets(EdgeInsets())

                NavigationLink(destination: ProductList(products: ModelData().menu.drinks)) {
                    DrinkRow(drinks: ModelData().menu.drinks)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Featured")
        }
    }

}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(ModelData())
    }
}
