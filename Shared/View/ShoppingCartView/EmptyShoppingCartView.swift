//
//  EmptyShoppingCartView.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 9/14/21.
//

import SwiftUI

struct EmptyShoppingCartView: View {
    var body: some View {
        VStack {
            Image(systemName: "cart")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.secondary)
                .frame(width: 60.0, height: 50.0, alignment: .center)
                .padding(.bottom)
            Text("Your cart is empty.")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
        }
    }
}

struct EmptyShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyShoppingCartView()
        }
    }
}
