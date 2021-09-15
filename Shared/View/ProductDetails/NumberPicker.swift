//
//  NumberPicker.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 1/20/21.
//

import SwiftUI

struct NumberPicker: View {

    @Binding var totalNumber: String

    var body: some View {
        Picker(selection: $totalNumber, label: Spacer()) {
            ForEach(Product.possibleNumbers, id: \.self) {
                Text($0)
            }
        }
    }
}

struct NumberPicker_Previews: PreviewProvider {
    static var previews: some View {
        NumberPicker(totalNumber: .constant("4"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
