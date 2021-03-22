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
        var buttonRadius: CGFloat = defaultRadius

        init(buttons: Buttons) {
            self.buttons = buttons
            self.buttonRadius = calculateButtonRadius()
        }

        private func calculateButtonRadius() -> CGFloat {
            guard let keyWindow = UIWindow.keyWindow else {
                return ButtonMetrics.defaultRadius
            }

            // Determine maximum radius based on available width
            let rowCount = CGFloat(buttons.first?.count ?? 0)
            let horizantalSpacerCount = CGFloat(rowCount + 1)
            let radiusBasedOnWidth = (keyWindow.bounds.width - horizantalSpacerCount * CalculatorView.Properties.spacing) / rowCount

            // Determine maximum radius based on available height
            let columnCount = CGFloat(buttons.count)
            let verticalSpacerCount = CGFloat(columnCount + 1)
            let spaceForDisplayText: CGFloat = 120
            let radiusBasedOnHeight = (keyWindow.bounds.height - spaceForDisplayText - verticalSpacerCount * CalculatorView.Properties.spacing) / columnCount

            // Select the smaller of the two
            let radius =  min(radiusBasedOnWidth, radiusBasedOnHeight)
            return radius
        }
    }

    var buttonMetrics: ButtonMetrics {
        if env.interfaceOrientation.isLandscape == true {
            return ButtonMetrics(buttons: Buttons.landscape)
        } else {
            return ButtonMetrics(buttons: Buttons.default)
        }
    }
}
