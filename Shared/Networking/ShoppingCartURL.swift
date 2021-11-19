//
//  ShoppingCartURL.swift
//  LearnSwiftUI (iOS)
//
//  Created by Guanglei Liu on 11/5/21.
//

import Foundation

enum ShoppingCartURL {
    case fetch
    case update
    case save
    case delete
    case submit
}

extension ShoppingCartURL {
    var url: URL {
        guard let url = URL(string: path, relativeTo: baseURL) else { fatalError("URL Error") }
        return url
    }
    
    private var baseURL: URL {
        URL(string: "http://127.0.0.1:8080/")!
    }
    
    private var path: String {
        switch self {
        case .fetch:
            return "shoppingCart"
        case .update:
            return "shoppingCart/update"
        case .save:
            return "shoppingCart/save"
        case .delete:
            return "shoppingCart/delete"
        case .submit:
            return "shoppingCart/submit"
        }
    }
}
