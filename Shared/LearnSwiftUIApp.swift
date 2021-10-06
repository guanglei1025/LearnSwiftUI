//
//  LearnSwiftUIApp.swift
//  Shared
//
//  Created by Guanglei Liu on 12/10/20.
//

import SwiftUI

@main
struct LearnSwiftUIApp: App {
    @StateObject private var shoppingCartStore = ShoppingCartStore(service: ShoppingCartAPI(webService: Service()))
    @StateObject private var productStore = ProductStore(service: ProductAPI(webService: Service()))

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(shoppingCartStore)
                .environmentObject(productStore)
        }
    }
}
