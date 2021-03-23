//
//  Configuration.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/20/21.
//

import SwiftUI

struct Configuration {

    private static let regularFontSize: CGFloat = 100
    private static let compactFontSize: CGFloat = 50

    let buttons: Buttons
    var displayFontSize: CGFloat

    init(with horizontalSizeClass: UserInterfaceSizeClass, _ verticalSizeClass: UserInterfaceSizeClass) {
        let isHorizontalRegular = horizontalSizeClass == .regular
        let isVerticalRegular = verticalSizeClass == .regular
        let areBothDimensionsRegular = isVerticalRegular && isHorizontalRegular

        buttons = isHorizontalRegular ? Buttons.regular : Buttons.compact
        displayFontSize = areBothDimensionsRegular ? Configuration.regularFontSize : Configuration.compactFontSize
    }

    func buttonRadius(using metrics: GeometryProxy) -> CGFloat {
        print(metrics.size)

        // Determine maximum radius based on available width
        let rowCount = CGFloat(buttons.first?.count ?? 0)
        let horizantalSpacerCount = CGFloat(rowCount + 1)
        let radiusBasedOnWidth = (metrics.size.width - horizantalSpacerCount * CalculatorView.Properties.spacing) / rowCount

        // Determine maximum radius based on available height
        let columnCount = CGFloat(buttons.count)
        let verticalSpacerCount = CGFloat(columnCount + 1)
        let radiusBasedOnHeight = (metrics.size.height - verticalSpacerCount * CalculatorView.Properties.spacing) / columnCount

        // Select the smaller of the two
        let radius =  min(radiusBasedOnWidth, radiusBasedOnHeight)
        return radius
    }
}
