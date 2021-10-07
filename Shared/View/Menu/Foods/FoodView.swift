//
//  FoodView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/29/21.
//

import SwiftUI

struct FoodView: View {
    let food: Product

    var body: some View {
        VStack(alignment: .leading) {
            CacheAsyncImage(url: URL(string: food.imageURL)!) { image in
                image
                    .resizable()
                    .frame(width: 250, height: 180)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
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
        FoodView(food: ProductStore.fakeItems().first!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
