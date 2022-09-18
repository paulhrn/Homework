//
//  Trimmed.swift
//  14.09 swiftUI
//
//  Created by p h on 15.09.2022.
//

import Foundation

@propertyWrapper
struct Trimmed {
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
