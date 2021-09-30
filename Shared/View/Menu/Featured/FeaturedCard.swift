//
//  FeaturedCard.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/29/21.
//

import SwiftUI

struct FeaturedCard: View {
    var product: Item

    var body: some View {
        AsyncImage(url: URL(string: product.imageURL)) { image in
            image
                .resizable()
                .aspectRatio(3 / 2, contentMode: .fit)
                .overlay(TextOverlay(name: product.name))
        } placeholder: {
            ProgressView()
        }
    }
}

struct NewFeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedCard(product: ModelData().fakeItems.first!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
