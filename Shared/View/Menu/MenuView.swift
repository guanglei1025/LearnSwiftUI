//
//  MenuView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/12/20.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var productStore: ProductStore
    @EnvironmentObject var shoppingCartStore: ShoppingCartStore
    @State var hasServerError = false
    @State var alertMessage: String = ""
    
    var body: some View {
        NavigationView {
            List {
                // REVIEW: I'm not against creating local constants like this.
                // It can stay or be changed to just use `productStore.foods.count` or `.map`
                // See my example below
                // let featuredItems = productStore.foods
                if productStore.foods.count > 0 {
                    FeaturedView(pages: productStore.foods.map {
                        FeaturedCard(product: $0)
                    })
                        .aspectRatio(3 / 2, contentMode: .fit)
                        .listRowInsets(EdgeInsets())
                }

                // REVIEW: Isn't this a duplicate of `featuredItems`?
                // In general I prefer to juse have the data model handle properties
                // like this.
                // let foods = productStore.foods
                if productStore.foods.count > 0 {
                    NavigationLink(destination: ProductList(products: productStore.foods)) {
                        FoodRow(foods: productStore.foods)
                    }
                    .listRowInsets(EdgeInsets())
                }

                // REVIEW: Same comment for drinks
                // let drinks = productStore.drinks
                if productStore.drinks.count > 0 {
                    NavigationLink(destination: ProductList(products: productStore.drinks)) {
                        DrinkRow(drinks: productStore.drinks)
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(InsetListStyle())
            // REVIEW: In keeping with BNR's standards we should localize all our strings
            .navigationTitle(LocalizedStringKey("Featured"))
        }
        .navigationViewStyle(.stack)
        .task {
            await loadProductsAndShoppingCart()
        }
        .alert(isPresented: $hasServerError) { () -> Alert in
            let button = Alert.Button.default(Text(LocalizedStringKey("OK")))
            return Alert(title: Text(LocalizedStringKey("Server Error")),
                         message: Text(alertMessage),
                         dismissButton: button)
        }
    }
    
    enum FeatchDataError: Error {
        case loadProducts(ProductStoreError?)
        case loadShoppingCart(ShoppingCartStoreError?)
    }
    
    func loadProductsAndShoppingCart() async {
        await withTaskGroup(of: FeatchDataError.self) { group in
            group.addTask {
                .loadProducts(await productStore.fetchProducts())
            }
            
            group.addTask {
                .loadShoppingCart(await shoppingCartStore.fetchShoppingCart())
            }
            
            var productError: ProductStoreError?
            var shoppingCartError: ShoppingCartStoreError?
            for await result in group {
                switch result {
                case .loadProducts(let error):
                    productError = error
                    hasServerError = true
                case .loadShoppingCart(let error):
                    shoppingCartError = error
                    hasServerError = true
                }
            }
            
            if productError != nil && shoppingCartError != nil {
                alertMessage = "Unable to load products and shopping cart"
            } else if productError != nil {
                alertMessage = "Unable to load products"
            } else if shoppingCartError != nil {
                alertMessage = "Unable to load shopping cart"
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
