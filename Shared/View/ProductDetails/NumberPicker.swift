//
//  NumberPicker.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 1/20/21.
//

import SwiftUI

struct NumberPicker: View {

    @Binding var totalNumber: Int
    private let pickerNumbers = 1...19

    var body: some View {
        Picker(selection: $totalNumber, label: Spacer()) {
            ForEach(pickerNumbers, id: \.self) {
                Text(String($0))
            }
        }
    }
}

struct NumberPicker_Previews: PreviewProvider {
    static var previews: some View {
        NumberPicker(totalNumber: .constant(4))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
