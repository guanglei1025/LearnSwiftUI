//
//  MenuView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/12/20.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var modelData: ModelData
    @StateObject private var productStore = ProductStore(
        service: ProductAPI(webService: Service()))

/*
    var body: some View {
        NavigationView {
            List {
//                PageView(pages: modelData.menu.foods.map {
//                    FeatureCard(product: $0)
//                })
//                .aspectRatio(3 / 2, contentMode: .fit)
//                .listRowInsets(EdgeInsets())
//
//                NavigationLink(destination: ProductList(products: ModelData().menu.foods)) {
//                    FoodRow(foods: ModelData().menu.foods)
//                }
//                .listRowInsets(EdgeInsets())
//
//                NavigationLink(destination: ProductList(products: ModelData().menu.drinks)) {
//                    DrinkRow(drinks: ModelData().menu.drinks)
//                }
//                .listRowInsets(EdgeInsets())
                Text("Fetch Successful")
            }
            .listStyle(InsetListStyle())
            .navigationTitle("Featured")
        }
        .task {
             await productStore.fetchProducts()
        }
    }
*/

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

                if productStore.foods.count > 0 {
                    NavigationLink(destination: ProductList(products: ModelData().menu.foods)) {
                        FoodRow(foods: productStore.foods)
                    }
                    .listRowInsets(EdgeInsets())
                }

//
//                NavigationLink(destination: ProductList(products: ModelData().menu.drinks)) {
//                    DrinkRow(drinks: ModelData().menu.drinks)
//                }
//                .listRowInsets(EdgeInsets())
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
            .environmentObject(ModelData())
    }
}
