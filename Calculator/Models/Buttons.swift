//
//  Buttons.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/21/21.
//

import Foundation

typealias Buttons = [[CalculatorButton]]

extension Buttons {

    static let compact: Buttons = [
        [ .clear, .plusMinus, .percent, .divide ],
        [ .seven, .eight, .nine, .multiply ],
        [ .four, .five, .six, .subtract ],
        [ .one, .two, .three, .add ],
        [ .zero, .decimal, .equals ],
    ]

    static let regular: Buttons = [
        [ .memoryClear, .seven, .eight, .nine, .divide, .clear ],
        [ .memoryAdd, .four, .five, .six, .multiply, .plusMinus ],
        [ .memorySubtract, .one, .two, .three, .subtract, .percent ],
        [ .memoryRecall, .zero, .decimal, .add, .equals ]
    ]
}
