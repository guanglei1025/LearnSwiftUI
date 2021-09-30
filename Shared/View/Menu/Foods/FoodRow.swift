//
//  FoodRow.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/11/20.
//

import SwiftUI

struct FoodRow: View {
    var foods: [Item]

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text("Foods")
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
//                    ForEach(foods) { food in
//                        NavigationLink(destination: ProductDetailsView(product: food)) {
//                            FoodView(food: food)
//                        }
//                    }
                    ForEach(foods) { food in
                        NewFoodView(food: food)
                    }
                }
            }
        }
    }
}

struct FoodRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodRow(foods: ModelData().fakeItems)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
