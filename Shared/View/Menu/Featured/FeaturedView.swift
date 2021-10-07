//
//  FeaturedView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/29/21.
//

import SwiftUI

struct FeaturedView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .padding(.bottom)
        }
    }
}

struct FeatureView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView(pages: ProductStore.fakeItems().map {
            FeaturedCard(product: $0)
        })
        .aspectRatio(3 / 2, contentMode: .fit)
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
