//
//  DrinkView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/11/20.
//

import SwiftUI

struct DrinkView: View {
    let drink: Product

    var body: some View {
        VStack(alignment: .leading) {
            drink.image
                .resizable()
                .frame(width: 160, height: 200)
                .cornerRadius(10)
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

struct DrinkView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkView(drink: ModelData().menu.drinks[0])
    }
}
