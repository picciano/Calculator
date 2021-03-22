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
    
    @Published
    var deviceOrientation: UIDeviceOrientation = UIDevice.current.orientation

    var interfaceOrientation: UIInterfaceOrientation {
        UIWindow.keyWindowInterfaceOrientation ?? .unknown
    }
    
    private var currentValue: Float {
        get { resultNumberFormatter.number(from: displayText)?.floatValue ?? 0 }
        set { displayText = resultNumberFormatter.string(from: NSNumber(value: newValue)) ?? "E" }
    }
    
    private var register: Float? = nil
    private var memoryRegister: Float? = nil
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
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        rotationTask = NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .sink(receiveValue: { (notification) in
                guard let device = notification.object as? UIDevice,
                      device.orientation != .unknown,
                      device.orientation != self.deviceOrientation else {
                    return
                }
                self.deviceOrientation = device.orientation
            })
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
