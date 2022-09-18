//
//  DateWhenAccessed.swift
//  14.09 swiftUI
//
//  Created by p h on 19.09.2022.
//

import Foundation

@propertyWrapper
struct GetDate {
    var wrappedValue: Date {
        didSet {
            DateFormatter().string(from: wrappedValue)
        }
    }
    
    init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
    }
}
