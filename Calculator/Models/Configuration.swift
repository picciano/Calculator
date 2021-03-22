//
//  Metrics.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/20/21.
//

import SwiftUI

struct Configuration {

    private static let defaultRadius: CGFloat = 60
    private static let defaultDisplayTextFontSize: CGFloat = 64

    let buttons: Buttons
    let horizontalAlignment: HorizontalAlignment
    var buttonRadius: CGFloat = defaultRadius
    var displayTextFontSize: CGFloat = defaultDisplayTextFontSize

    init(with interfaceOrientation: UIInterfaceOrientation) {
        buttons = interfaceOrientation.isLandscape ? Buttons.landscape : Buttons.default
        horizontalAlignment = interfaceOrientation.isLandscape ? .trailing : .center

        displayTextFontSize = calculateDisplayTextFontSize()
        buttonRadius = calculateButtonRadius()
    }

    private func calculateDisplayTextFontSize() -> CGFloat {
        guard let keyWindow = UIWindow.keyWindow else {
            return Configuration.defaultDisplayTextFontSize
        }

        if UIDevice.current.userInterfaceIdiom == .phone {
            return Configuration.defaultDisplayTextFontSize
        }

        return keyWindow.bounds.width / 10
    }

    private func calculateButtonRadius() -> CGFloat {
        guard let keyWindow = UIWindow.keyWindow else {
            return Configuration.defaultRadius
        }

        // Determine maximum radius based on available width
        let rowCount = CGFloat(buttons.first?.count ?? 0)
        let horizantalSpacerCount = CGFloat(rowCount + 1)
        let radiusBasedOnWidth = (keyWindow.bounds.width - horizantalSpacerCount * CalculatorView.Properties.spacing) / rowCount

        // Determine maximum radius based on available height
        let columnCount = CGFloat(buttons.count)
        let verticalSpacerCount = CGFloat(columnCount + 1)
        let spaceForDisplayText = displayTextFontSize + 56
        let radiusBasedOnHeight = (keyWindow.bounds.height - spaceForDisplayText - verticalSpacerCount * CalculatorView.Properties.spacing) / columnCount

        // Select the smaller of the two
        let radius =  min(radiusBasedOnWidth, radiusBasedOnHeight)
        return radius
    }
}
