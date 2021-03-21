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
    case allClear, clear, plusMinus, percent
    
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
        case .add: return "+"
        case .subtract: return "–"
        case .multiply: return "✕"
        case .divide: return "÷"
        case .equals: return "="
        case .allClear: return "AC"
        case .clear: return "C"
        case .plusMinus: return "+/–"
        case .percent: return "%"
        }
    }

    func calculate(firstNumber: Float, secondNumber: Float? = nil) -> Float {
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
        case .add, .subtract, .multiply, .divide, .equals:
            return .orange
        case .allClear, .clear, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .allClear, .clear, .plusMinus, .percent:
            return .black
        default:
            return .white
        }
    }
}
