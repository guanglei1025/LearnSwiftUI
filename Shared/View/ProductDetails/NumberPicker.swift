//
//  NumberPicker.swift
//  LearnSwiftUI
//
//  Created by Guanglei Liu on 1/20/21.
//

import SwiftUI

struct NumberPicker: View {

    @Binding var totalNumber: String

    private let pickerNumbers = 1...19
    private var pickerNumbersInString: [String] {
        pickerNumbers.map { String($0)}
    }

    var body: some View {
        Picker(selection: $totalNumber, label: Spacer()) {
            ForEach(pickerNumbersInString, id: \.self) {
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
