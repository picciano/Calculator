//
//  Color+Brightness.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/22/21.
//

import SwiftUI

extension Color {

    func lighter(by percentage: Float = 20) -> Color? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: Float = 20) -> Color? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: Float = 20) -> Color? {
        let orig = UIColor(self)
        if let adjusted = orig.adjust(by: CGFloat(percentage)) {
            return Color(adjusted)
        }

        return self
    }
}

fileprivate extension UIColor {

    func lighter(by percentage: CGFloat) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
