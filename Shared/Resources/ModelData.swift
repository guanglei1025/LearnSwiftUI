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

    let fakeItems = [Item(id: UUID(uuidString: "AAEDBCB7-D32C-4F1E-89F8-C41E2D93CA32")!,
                        stockQuantity: 10,
                        price: "3.99",
                        imageURL: "https://lovingitvegan.com/wp-content/uploads/2018/11/Vegan-Eggnog-8.jpg",
                        description: "description",
                        name: "Name",
                        category: "food")]

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
