//
//  beerShop.swift
//  UI
//
//  Created by p h on 22.05.2022.
//

import Foundation

class beerShop {
    
    static let beershop = beerShop(beer: [])
    var beer: [Beer] = []
    
    var index = 0
    
    private init(beer: [Beer]) {
        self.beer = beer
    }
    //SELL
    func sell(n: Int)  {
        if beerShop.beershop.beer[n].left >= 1 {
            beerShop.beershop.beer[n].left -= 1
            beerShop.beershop.beer[n].general += 1
        }
    }
    //INCOME
    func income() -> Int {
        return beer.map{ $0.general * $0.price }.reduce(0, { $0 + $1 })
    }
    // NEWDAY
    func newDay() {
        beer = beer.map{ Beer(brand: $0.brand, country: $0.country, price: $0.price, left: $0.left, general: $0.general * 0 ) }
    }
    //LEFT
    func beerleftbutton() -> String {
        return beer.map{ "\($0.brand) – \($0.left) left" }.joined(separator: " ")
    }
}
