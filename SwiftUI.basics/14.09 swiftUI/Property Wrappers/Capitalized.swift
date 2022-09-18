//
//  Capitalized.swift
//  14.09 swiftUI
//
//  Created by p h on 15.09.2022.
//

import Foundation

@propertyWrapper
struct Capitalized {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get {
            return value
        }
        set {
            guard let val = newValue.firstIndex(of: ".") else { return }
            let someIndex = newValue.index(val, offsetBy: 2)
            let range = someIndex..<newValue.index(after: someIndex)
            value = newValue.replacingCharacters(in: range, with: newValue[range].capitalized)
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
