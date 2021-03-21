//
//  CalculatorView+ButtonMetrics.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/20/21.
//

import SwiftUI

extension CalculatorView {

    struct ButtonMetrics {
        static let defaultRadius: CGFloat = 60

        let buttons: Buttons
        let isLandscape = UIWindow.keyWindowScene?.interfaceOrientation.isLandscape == true
        var buttonRadius: CGFloat = defaultRadius

        init(buttons: Buttons) {
            self.buttons = buttons
            self.buttonRadius = calculateButtonRadius()
        }

        private func calculateButtonRadius() -> CGFloat {
            guard let keyWindow = UIWindow.keyWindow else {
                return ButtonMetrics.defaultRadius
            }

            let rowCount = CGFloat(buttons.first?.count ?? 0)
            let horizantalSpacerCount = CGFloat(rowCount + 1)
            let radiusBasedOnWidth = (keyWindow.bounds.width - horizantalSpacerCount * CalculatorView.Properties.spacing) / rowCount

            let columnCount = CGFloat(buttons.count)
            let verticalSpacerCount = CGFloat(columnCount + 1)
            let spaceForDisplayText: CGFloat = 120
            let radiusBasedOnHeight = (keyWindow.bounds.height - spaceForDisplayText - verticalSpacerCount * CalculatorView.Properties.spacing) / columnCount

            let radius =  min(radiusBasedOnWidth, radiusBasedOnHeight)
            print("Radius: \(radius)")
            return radius
        }
    }

    var buttonMetrics: ButtonMetrics {
        if UIWindow.keyWindowScene?.interfaceOrientation.isLandscape == true {
            return ButtonMetrics(buttons: env.isDefaultDisplay ? Buttons.landscape : Buttons.landscapeWithClear)
        } else {
            return ButtonMetrics(buttons: env.isDefaultDisplay ? Buttons.default : Buttons.defaultWithClear)
        }
    }
}
