//
//  MemoryModel.swift
//  Calculator
//
//  Created by Anthony Picciano on 3/23/21.
//

import Foundation

struct MemoryModel {

    private let memoryUserKey = "Calculator.memory"

    var hasValue: Bool {
        register != nil
    }

    var value: Double? {
        register
    }

    init() {
        let stored = UserDefaults.standard.double(forKey: memoryUserKey)
        if stored != 0 {
            register = stored
        }
    }

    private var register: Double? {
        didSet {
            UserDefaults.standard.setValue(register, forKey: memoryUserKey)
        }
    }

    mutating func add(value: Double) {
        register = (register ?? 0) + value
    }

    mutating func subtract(value: Double) {
        register = (register ?? 0) - value
    }

    mutating func clear() {
        register = nil
    }
}
