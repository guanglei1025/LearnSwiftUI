//
//  ShoppingCartStore.swift
//  LearnSwiftUI (iOS)
//
//  Created by Guanglei Liu on 10/1/21.
//

import Foundation

class ShoppingCartStore: ObservableObject {
    @Published var shoppingCart: ShoppingCart?
    private let shoppingCartService: ShoppingCartService

    init(shoppingCartService: ShoppingCartService) {
        self.shoppingCartService = shoppingCartService
    }
}
