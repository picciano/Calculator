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
//        [ .allClear, .plusMinus, .percent, .divide ],
//        [ .seven, .eight, .nine, .multiply ],
//        [ .four, .five, .six, .subtract ],
//        [ .one, .two, .three, .add ],
//        [ .zero, .decimal, .equals ],
//    ]
//
//    static let defaultWithClear: Buttons = [
        [ .clear, .plusMinus, .percent, .divide ],
        [ .seven, .eight, .nine, .multiply ],
        [ .four, .five, .six, .subtract ],
        [ .one, .two, .three, .add ],
        [ .zero, .decimal, .equals ],
    ]

    static let landscape: Buttons = [
//        [ .seven, .eight, .nine, .divide, .allClear ],
//        [ .four, .five, .six, .multiply, .plusMinus ],
//        [ .one, .two, .three, .subtract, .percent ],
//        [ .zero, .decimal, .add, .equals ],
//    ]
//
//    static let landscapeWithClear: Buttons = [
        [ .seven, .eight, .nine, .divide, .clear ],
        [ .four, .five, .six, .multiply, .plusMinus ],
        [ .one, .two, .three, .subtract, .percent ],
        [ .zero, .decimal, .add, .equals ]
    ]
}
