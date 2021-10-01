//
//  ModelData.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/10/20.
//

import Foundation
import Combine

// Single source of truth
final class ModelData: ObservableObject {
    @Published var menu: Menu = load("fakeData.json")
    @Published var shoppingCart: ShoppingCart

    init(shoppingCart: ShoppingCart = ShoppingCart()) {
        self.shoppingCart = shoppingCart
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
