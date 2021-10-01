//
//  NewDrinkView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/29/21.
//

import SwiftUI

struct DrinkView: View {
    let drink: Item

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: drink.imageURL)) { image in
                image
                    .resizable()
                    .frame(width: 160, height: 200)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            Text(drink.name)
                .font(.body)
                .foregroundColor(.primary)
            Text(drink.price)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.top, 1)
        }
        .padding(.leading, 15)
    }
}

struct NewDrinkView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkView(drink: ModelData().fakeItems.first!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
