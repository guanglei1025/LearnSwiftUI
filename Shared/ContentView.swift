//
//  ContentView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/13/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .menu
    @EnvironmentObject var modelData: ModelData

    enum Tab {
        case menu
        case cart
    }

    var body: some View {
        TabView(selection: $selection) {
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "heart")
                }
                .tag(Tab.menu)
            ShoppingCartView()
                .environmentObject(modelData)
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .tag(Tab.cart)
//            MenuView()
//                .tabItem {
//                    Label("Menu", systemImage: "heart")
//                }
//                .tag(Tab.menu)
//            ShoppingCartView()
//                .environmentObject(modelData)
//                .tabItem {
//                    Label("Cart", systemImage: "cart")
//                }
//                .tag(Tab.cart)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
