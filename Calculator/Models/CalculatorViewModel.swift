//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/19/21.
//

import SwiftUI
import Combine

class CalculatorViewModel: ObservableObject {
    
    @Published
    var displayText: String
    
    private var currentValue: Double {
        get { resultNumberFormatter.number(from: displayText)?.doubleValue ?? 0 }
        set { displayText = resultNumberFormatter.string(from: NSNumber(value: newValue)) ?? "E" }
    }
    
    private var register: Double? = nil
    private var memoryRegister: Double? = nil
    private var startNewEntry = true
    private var enteredDigits = false
    private var currentOperation: CalculatorButton? { didSet { startNewEntry = true } }
    private var lastOperation: CalculatorButton?
    private var rotationTask: AnyCancellable?
    private var resultNumberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 15
        return formatter
    }()
    
    private let defaultDisplay = CalculatorButton.zero.title
    
    init() {
        displayText = defaultDisplay
    }
    
    var isDefaultDisplay: Bool {
        displayText == defaultDisplay
    }
    
    func process(_ button: CalculatorButton) {
        var currentlyEnteringDigits = false
        
        switch button {
        case .clear:
            if isDefaultDisplay {
                register = 0
                currentOperation = nil
            }
            displayText = defaultDisplay
            startNewEntry = true
        case _ where button.isOneParamterFunction:
            let result = button.calculate(firstNumber: currentValue)
            register = result
            currentValue = result
        case _ where button.isTwoParamterFunction:
            if let currentOperation = currentOperation, let currentRegister = register, enteredDigits {
                let result = currentOperation.calculate(firstNumber: currentRegister, secondNumber: currentValue)
                register = result
                currentValue = result
            } else {
                register = currentValue
            }
            currentOperation = button
        case .equals:
            guard let operation = currentOperation ?? lastOperation else {
                return
            }
            
            guard let currentRegister = register else {
                return
            }
            
            currentValue = operation.calculate(firstNumber: currentRegister, secondNumber: currentValue)
            lastOperation = operation
            currentOperation = nil
        case _ where button.isNumeric:
            if startNewEntry || isDefaultDisplay {
                displayText = button.title
                startNewEntry = false
            } else {
                displayText.append(button.title)
            }

            currentlyEnteringDigits = true
        case .decimal:
            if !displayText.contains(CalculatorButton.decimal.title) {
                displayText.append(button.title)
            }
        case .memoryRecall:
            break
        case .memoryClear:
            break
        case .memoryAdd:
            break
        case .memorySubtract:
            break
        default:
            break
        }
        
        enteredDigits = currentlyEnteringDigits
    }
}
