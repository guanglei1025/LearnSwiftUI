// Copyright © 2019 Banno. All rights reserved.

import Foundation

// MARK: - "Amount" formatter

extension Decimal {
    /// Always formats currency values with a decimal point and two decimal places.
    /// Example: Decimal(1) -> "$1.00"

    private static var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = NSLocale.current
        formatter.numberStyle = .currency
        formatter.generatesDecimalNumbers = true
        formatter.currencyCode = "USD"
        formatter.isLenient = true
        return formatter
    }

    /// Returns a value like "$1,234.00"
    var currencyFormattedString: String {
        guard let formattedString = Decimal.currencyFormatter.string(for: self) else {
            let currencySymbol = Decimal.currencyFormatter.currencySymbol ?? "$"
            return "\(currencySymbol)0.00"
        }
        return formattedString
    }

    /// Formats and parses values like "1234.00". The decimal separator is always `.`, and no grouping separators are used.
    static var apiFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.roundingMode = .halfEven

        // This shouldn't come into play, given that we're directly setting values that would normally be drawn from the locale, but best to be safe.
        formatter.locale = Locale(identifier: "en_US_POSIX")

        // Force the expected separator and minus sign, rather than drawing from the locale.
        formatter.decimalSeparator = "."
        formatter.minusSign = "-"

        // Hardcode the format strings to match what APIs expect.
        formatter.negativeFormat = "-0.00"
        formatter.positiveFormat = "0.00"
        return formatter
    }

    /// Returns a value like 1234.00.
    var apiFormattedString: String {
        guard let transportFormattedString = Decimal.apiFormatter.string(from: self as NSNumber)
        else {
            print(
                "WARNING: NumberFormatter failed to format Decimal value=\(self). Falling back to raw string value."
            )
            return String(describing: self)
        }
        return transportFormattedString
    }

    static func decimalValueOrZero(fromString string: String?) -> Decimal {
        guard let baseString = string else {
            return .zero
        }
        guard let decimal = currencyFormatter.number(from: baseString) as? Decimal else {
            return .zero
        }
        return decimal
    }
}

extension Decimal {
    var doubleValue: Double {
        return (self as NSDecimalNumber).doubleValue
    }
    var stringValue: String {
        // returns string value with no formatting
        return (self as NSDecimalNumber).stringValue
    }
}
