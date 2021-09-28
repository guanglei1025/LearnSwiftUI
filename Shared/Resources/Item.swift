//
//  Products.swift
//  LearnSwiftUI (iOS)
//
//  Created by Lina Gao on 28/09/2021.
//

import Foundation

struct Item: Codable {
    let id: UUID
    let stockQuantity: String
    let price: String
    let imageURL: String
    let description: String
    let name: String
    var category: NewCategory.RawValue

    enum NewCategory: String, CaseIterable, Codable {
        case food = "food"
        case drink = "drink"
    }
}
