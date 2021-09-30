//
//  NewFoodView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/29/21.
//

import SwiftUI

struct NewFoodView: View {
    let food: Item

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: food.imageURL)) { image in
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

struct NewFoodView_Previews: PreviewProvider {
    static var previews: some View {
        NewFoodView(food: ModelData().fakeItems.first!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
