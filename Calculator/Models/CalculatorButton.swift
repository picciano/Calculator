//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/19/21.
//

import SwiftUI

enum CalculatorButton {
    case zero, one, two, three, four, five, six, seven, eight, nine, decimal
    case add, subtract, multiply, divide, equals
    case clear, plusMinus, percent
    case memoryRecall, memoryClear, memoryAdd, memorySubtract

    var isNumeric: Bool {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return true
        default:
            return false
        }
    }

    var isOneParamterFunction: Bool {
        switch self {
        case .plusMinus, .percent:
            return true
        default:
            return false
        }
    }

    var isTwoParamterFunction: Bool {
        switch self {
        case .add, .subtract, .multiply, .divide:
            return true
        default:
            return false
        }
    }

    var isBasicFunction: Bool {
        switch self {
        case .add, .subtract, .multiply, .divide, .equals:
            return true
        default:
            return false
        }
    }

    var systemImageName: String? {
        switch self {
        case .add:
            return "plus"
        case .subtract:
            return "minus"
        case .multiply:
            return "multiply"
        case .divide:
            return "divide"
        case .equals:
            return "equal"
        case .plusMinus:
            return "plus.slash.minus"
        case .percent:
            return "percent"
        default:
            return nil
        }
    }
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .decimal: return "."
        case .clear: return "C"
        case .memoryRecall: return "MR"
        case .memoryClear: return "MC"
        case .memoryAdd: return "M+"
        case .memorySubtract: return "M–"
        default: return ""
        }
    }

    var altTitle: String {
        switch self {
        case .clear:
            return "AC"
        default:
            return title
        }
    }

    func calculate(firstNumber: Double, secondNumber: Double? = nil) -> Double {
        switch self {
        case .add:
            return firstNumber + (secondNumber ?? 0)
        case .subtract:
            return firstNumber - (secondNumber ?? 0)
        case .multiply:
            return firstNumber * (secondNumber ?? 1)
        case .divide:
            return firstNumber / (secondNumber ?? 1)
        case .percent:
            return firstNumber / 100
        case .plusMinus:
            return firstNumber * -1
        default:
            return secondNumber ?? firstNumber
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case _ where isBasicFunction:
            return Color("AccentColor")
        case .clear, .plusMinus, .percent, .memoryAdd, .memoryClear, .memorySubtract, .memoryRecall:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .clear, .plusMinus, .percent:
            return .black
        default:
            return .white
        }
    }
}
