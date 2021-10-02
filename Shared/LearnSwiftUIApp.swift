//
//  LearnSwiftUIApp.swift
//  Shared
//
//  Created by Guanglei Liu on 12/10/20.
//

import SwiftUI

@main
struct LearnSwiftUIApp: App {
    @StateObject private var modelData = ModelData()
    @StateObject private var shoppingCartStore = ShoppingCartStore(service: ShoppingCartAPI(webService: Service()))
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(shoppingCartStore)
        }
    }
}
