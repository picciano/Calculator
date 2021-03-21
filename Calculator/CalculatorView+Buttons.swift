//
//  CalculatorView+Buttons.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/20/21.
//

import SwiftUI

extension CalculatorView {

    typealias Buttons = [[CalculatorButton]]

    struct ButtonMetrics {
        let buttons: Buttons
        var buttonRadius: CGFloat

        init(buttons: Buttons) {
            self.buttons = buttons
            self.buttonRadius = calculateButtonRadius(for: buttons)
        }
    }

    var buttonMetrics: ButtonMetrics {
        if horizontalSizeClass == .regular {
            return ButtonMetrics(buttons: env.isDefaultDisplay ? CalculatorView.landscapeButtons : CalculatorView.landscapeButtonsWithClear)
        } else {
            return ButtonMetrics(buttons: env.isDefaultDisplay ? CalculatorView.defaultButtons : CalculatorView.defaultButtonsWithClear)
        }
    }

    private static let keyWindow = UIApplication.shared.connectedScenes
        .filter({ $0.activationState == .foregroundActive })
        .map({ $0 as? UIWindowScene })
        .compactMap({ $0 })
        .first?.windows
        .filter({ $0.isKeyWindow }).first

    private static func calculateButtonRadius(for buttons: Buttons) -> CGFloat {
        guard let keyWindow = keyWindow else {
            return 60
        }

        let rowCount = CGFloat(buttons.first?.count ?? 0)
        let horizantalSpacerCount = CGFloat(rowCount + 1)
        let radiusBasedOnWidth = (keyWindow.bounds.width - horizantalSpacerCount * CalculatorView.Properties.spacing) / rowCount

        let columnCount = CGFloat(buttons.count)
        let verticalSpacerCount = CGFloat(columnCount + 1)
        let spaceForDisplayText: CGFloat = 120
        let radiusBasedOnHeight = (keyWindow.bounds.height - spaceForDisplayText - verticalSpacerCount * CalculatorView.Properties.spacing) / columnCount

        let radius =  min(radiusBasedOnWidth, radiusBasedOnHeight)
        return radius
    }

    private static let defaultButtons: Buttons = [
        [ .allClear, .plusMinus, .percent, .divide ],
        [ .seven, .eight, .nine, .multiply ],
        [ .four, .five, .six, .subtract ],
        [ .one, .two, .three, .add ],
        [ .zero, .decimal, .equals ],
    ]

    private static let defaultButtonsWithClear: Buttons = [
        [ .clear, .plusMinus, .percent, .divide ],
        [ .seven, .eight, .nine, .multiply ],
        [ .four, .five, .six, .subtract ],
        [ .one, .two, .three, .add ],
        [ .zero, .decimal, .equals ],
    ]

    private static let landscapeButtons: Buttons = [
        [ .seven, .eight, .nine, .divide, .allClear ],
        [ .four, .five, .six, .multiply, .plusMinus ],
        [ .one, .two, .three, .subtract, .percent ],
        [ .zero, .decimal, .add, .equals ],
    ]

    private static let landscapeButtonsWithClear: Buttons = [
        [ .seven, .eight, .nine, .divide, .clear ],
        [ .four, .five, .six, .multiply, .plusMinus ],
        [ .one, .two, .three, .subtract, .percent ],
        [ .zero, .decimal, .add, .equals ]
    ]
}
