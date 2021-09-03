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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
