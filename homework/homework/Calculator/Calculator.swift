//
//  Calculator.swift
//  homework
//
//  Created by p h on 12.06.2022.
//

import Foundation

class Calculator {
    
    enum cases {
        case plus, minus, multiply, divide, plusminus, percent
    }
    
    // MARK: - Public Properties
    var result: Float = 0.0
    var input: Float = 0.0
    var eachCase: cases?
    
    // MARK: - Public Funcs
    func newNumber(_ newNumber: Float) -> Float {
        switch eachCase! {
        case .plus:
            plus(input, newNumber)
        case .minus:
            minus(input, newNumber)
        case .multiply:
            multiply(input, newNumber)
        case .divide:
            divides(input, newNumber)
        case .plusminus:
            plusminus(input)
        case .percent:
            percent(input)
        }
        return result
    }
    
    // MARK: - Private Funcs
    private func plus(_ number1: Float ,_ number2: Float) -> Float {
        result = number1 + number2
        return result
    }
    
    private func minus(_ number1: Float ,_ number2: Float) -> Float {
        result = number1 - number2
        return result
    }
    
    private func multiply(_ number1: Float ,_ number2: Float) -> Float {
        result = number1 * number2
        return result
    }
    
    private func divides(_ number1: Float ,_ number2: Float) -> Float {
        result = number1 / number2
        return result
    }
    
    private func plusminus(_ number: Float) -> Float {
        result = -number
        return result
    }
    
    private func percent(_ number: Float) -> Float {
        result = number / 100
        return result
    }
}
