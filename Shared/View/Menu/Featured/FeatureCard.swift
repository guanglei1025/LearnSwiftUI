//
//  FeatureCard.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 12/11/20.
//

import SwiftUI

struct FeatureCard: View {
    var product: Product

    var body: some View {
        product.image
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay(TextOverlay(product: product))
    }
}

struct TextOverlay: View {
    var product: Product

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
            Text(product.name)
                .font(.title)
                .bold()
                .padding(.leading, 20)
                .padding(.bottom, 50)
        }
        .foregroundColor(.white)
    }
}


struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(product: ModelData().menu.foods[0])
    }
}
