//
//  Beer.swift
//  UI
//
//  Created by p h on 22.05.2022.
//

import Foundation

class Beer {
    
    // MARK: - Public Properties
    var brand, country: String
    var price, left, general: Int
    
    // MARK: - Life Cycle
    init(brand: String, country: String, price: Int, left: Int, general: Int) {
        self.brand = brand
        self.country = country
        self.price = price
        self.left = left
        self.general = general
    }
    
    // MARK: - Public funcs
    func show() -> String {
        return "'\(brand)', \(country). \(price)$/piece"
    }
}
