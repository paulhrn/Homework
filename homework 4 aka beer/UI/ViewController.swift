//
//  ViewController.swift
//  UI copy
//
//  Created by p h on 18.05.22.
//

import UIKit


class ViewController: UIViewController {
    
    // MARK: - Public Properties
    var beer1 = Beer(brand: "Heineken", country: "Netherlands", price: 1, left: 70, general: 0)
    var beer2 = Beer(brand: "Guinness", country: "Ireland", price: 2, left: 65, general: 0)
    var beer3 = Beer(brand: "Bud", country: "Czech Republic", price: 1, left: 60, general: 0)
    
    // MARK: - Outlets
    @IBOutlet weak var calculations: UILabel!
    
    @IBOutlet weak var beer1Info: UIButton!
    
    @IBOutlet weak var beer2Info: UIButton!
    
    @IBOutlet weak var beer3Info: UIButton!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerShop.beershop.beer.append(contentsOf: [beer1, beer2, beer3])
        //buttons' text
        beer1Info.setTitle("\(beer1.show())", for: .normal)
        beer2Info.setTitle("\(beer2.show())", for: .normal)
        beer3Info.setTitle("\(beer3.show())", for: .normal)
        
    }
    // MARK: - Actions
    @IBAction func currentincome(_ sender: Any) {
        calculations.text = "Current income is \(beerShop.beershop.income())$"
    }
    @IBAction func beerleft(_ sender: Any) {
        
        calculations.text = "\(beerShop.beershop.beerleftbutton())"
    }
    @IBAction func startnewday(_ sender: Any) {
        beerShop.beershop.newDay()
        calculations.text = "Everything's ready for a new day"
    }
    @IBAction func beer1sell(_ sender: Any) {
        let index = beerShop.beershop.beer.firstIndex(where: { $0.brand == beer1.brand })
        beerShop.beershop.sell(n: index ?? 0)
    }
    @IBAction func beer2sell(_ sender: Any) {
        let index = beerShop.beershop.beer.firstIndex(where: { $0.brand == beer2.brand })
        beerShop.beershop.sell(n: index ?? 0)
    }
    @IBAction func beer3sell(_ sender: Any) {
        let index = beerShop.beershop.beer.firstIndex(where: { $0.brand == beer3.brand })
        beerShop.beershop.sell(n: index ?? 0)
    }
}

