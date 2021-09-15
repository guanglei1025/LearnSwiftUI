//
//  FoodView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/11/20.
//

import SwiftUI

struct FoodView: View {
    let food: Product

    var body: some View {
        VStack(alignment: .leading) {
            food.image
                .resizable()
                .frame(width: 250, height: 180)
                .cornerRadius(10)
            Text(food.name)
                .font(.subheadline)
                .foregroundColor(.primary)
            Text(food.price)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.top, 1)
        }
        .padding(.leading, 15)
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView(food: ModelData().menu.foods[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
