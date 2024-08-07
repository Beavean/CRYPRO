//
//  Double+Formatter.swift
//  Crypro
//
//  Created by Antomated on 02.04.2024.
//

import Foundation

extension Double {
    /// Converts a Double into a Currency with 2-6 decimal places
    ///  ```
    ///   Convert 1234.56 to $1,234.56
    ///   Convert 12.3456 to $12.3456
    ///   Convert 0.123456 to $0.123456
    ///  ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //        formatter.locale = .current // <- default value
        formatter.currencyCode = "usd" // <- change currency
        formatter.currencySymbol = "$ " // <- change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }

    /// Converts a Double into a Currency as a String with 2-6 decimal places
    ///  ```
    ///   Convert 1234.56 to "$1,234.56"
    ///   Convert 12.3456 to "$12.3456"
    ///   Convert 0.123456 to "$0.123456"
    ///  ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }

    /// Converts a Double into string representation
    ///  ```
    ///   Convert 1234.56 to "1234.56"
    ///  ```
    func asNumberString() -> String {
        String(format: "%.2f", self)
    }

    /// Converts a Double into string representation with percent symbol
    ///  ```
    ///   Convert 1234.56 to "1234.56%"
    ///  ```
    func asPercentString() -> String {
        asNumberString() + "%"
    }

    /// Convert a Double to a String with K, M, Bn, Tr abbreviations
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.445K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 12345678912 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let number = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        switch number {
        case 1_000_000_000_000...:
            let formatted = number / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted) \(LocalizationKey.trillionAbbreviation.localizedString)"
        case 1_000_000_000...:
            let formatted = number / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted) \(LocalizationKey.billionAbbreviation.localizedString)"
        case 1_000_000...:
            let formatted = number / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted) \(LocalizationKey.millionAbbreviation.localizedString)"
        case 1000...:
            let formatted = number / 1000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted) \(LocalizationKey.thousandAbbreviation.localizedString)"
        case 0...:
            return asNumberString()
        default:
            return "\(sign)\(self)"
        }
    }

    /// Converts a Double into a Currency with abbreviation
    ///  ```
    ///   Convert 12345678901234 to "$ 12.34 Tr"
    ///  ```
    func asCurrencyWithAbbreviations() -> String {
        return "$ " + formattedWithAbbreviations()
    }
}
