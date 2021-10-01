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

struct TextOverlay: View {
    var name: String

    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle().fill(gradient)
            Text(name)
                .font(.title)
                .bold()
                .padding(.leading, 20)
                .padding(.bottom, 50)
        }
        .foregroundColor(.white)
    }
}

struct NewFeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedCard(product: ProductStore.fakeItems().first!)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
