//
//  Buttons.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/21/21.
//

import Foundation

typealias Buttons = [[CalculatorButton]]

extension Buttons {

    static let `default`: Buttons = [
        [ .clear, .plusMinus, .percent, .divide ],
        [ .seven, .eight, .nine, .multiply ],
        [ .four, .five, .six, .subtract ],
        [ .one, .two, .three, .add ],
        [ .zero, .decimal, .equals ],
    ]

    static let landscape: Buttons = [
        [ .memoryRecall, .seven, .eight, .nine, .divide, .clear ],
        [ .memoryClear, .four, .five, .six, .multiply, .plusMinus ],
        [ .memoryAdd, .one, .two, .three, .subtract, .percent ],
        [ .memorySubtract, .zero, .decimal, .add, .equals ]
    ]
}
