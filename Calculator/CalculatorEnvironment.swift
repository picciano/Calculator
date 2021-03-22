//
//  GlobalEnvironment.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/19/21.
//

import SwiftUI
import Combine

class CalculatorEnvironment: ObservableObject {
    
    @Published
    var displayText: String
    
    @Published
    var displayUpdate: Bool = true
    
    private var currentValue: Float {
        get { resultNumberFormatter.number(from: displayText)?.floatValue ?? 0 }
        set { displayText = resultNumberFormatter.string(from: NSNumber(value: newValue)) ?? "E" }
    }
    
    private var register: Float? = nil
    private var startNewEntry = true
    private var enteredDigits = false
    private var currentOperation: CalculatorButton? { didSet { startNewEntry = true } }
    private var lastOperation: CalculatorButton?
    private var rotationTask: AnyCancellable?
    private var resultNumberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 8
        return formatter
    }()
    
    private let defaultDisplay = CalculatorButton.zero.title
    
    init() {
        displayText = defaultDisplay
        rotationTask = NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .sink(receiveValue: { (notification) in
                self.displayUpdate.toggle()
            })
    }
    
    var isDefaultDisplay: Bool {
        displayText == defaultDisplay
    }
    
    func process(_ button: CalculatorButton) {
        var currentlyEnteringDigits = false
        
        switch button {
        case .decimal:
            if !displayText.contains(CalculatorButton.decimal.title) {
                displayText.append(button.title)
            }
        //        case .allClear:
        //            displayText = defaultDisplay
        //            register = 0
        //            currentOperation = nil
        case .clear:
            if isDefaultDisplay {
                register = 0
                currentOperation = nil
            }
            displayText = defaultDisplay
            startNewEntry = true
        case .plusMinus, .percent:
            let result = button.calculate(firstNumber: currentValue)
            register = result
            currentValue = result
        case .add, .subtract, .multiply, .divide:
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
        default:
            if startNewEntry || isDefaultDisplay {
                displayText = button.title
                startNewEntry = false
            } else {
                displayText.append(button.title)
            }
            
            currentlyEnteringDigits = true
        }
        
        enteredDigits = currentlyEnteringDigits
    }
}
