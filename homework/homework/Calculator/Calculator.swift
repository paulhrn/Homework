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
    func newNumber(_ newNumber: Float) {
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
    }
    
    // MARK: - Private Funcs
    private func plus(_ number1: Float ,_ number2: Float) {
        result = number1 + number2
    }
    
    private func minus(_ number1: Float ,_ number2: Float) {
        result = number1 - number2
    }
    
    private func multiply(_ number1: Float ,_ number2: Float) {
        result = number1 * number2
    }
    
    private func divides(_ number1: Float ,_ number2: Float) {
        result = number1 / number2
    }
    
    private func plusminus(_ number: Float) {
        result = -number
    }
    
    private func percent(_ number: Float) {
        result = number / 100
    }
}
