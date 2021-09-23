//
//  DrinkRow.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/11/20.
//

import SwiftUI

struct DrinkRow: View {
    var drinks: [Product]

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text("Drinks")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .padding(.top, 12)
                    .padding(.leading, 15)

                Spacer()

                Text("See all")
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding(.trailing, 10)
                    .padding(.bottom, 5)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(drinks) { drink in
                        NavigationLink(destination: ProductDetailsView(product: drink)) {
                            DrinkView(drink: drink)
                        }
                    }
                }
            }
        }
    }
}

struct DrinkRow_Previews: PreviewProvider {
    static var previews: some View {
        DrinkRow(drinks: ModelData().menu.drinks)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
