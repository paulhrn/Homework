//
//  screen4.swift
//  homework
//
//  Created by p h on 02.06.2022.
//

import Foundation
import UIKit

class Screen4: UIViewController {
    
    // MARK: - Public Properties
    var label = ""
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Fourth" {
            let destination = segue.destination as! Screen5
            destination.label = label
        }
    }
    
    // MARK: - Actions
    @IBAction func fourth(_ sender: UIButton) {
        performSegue(withIdentifier: "Fourth", sender: self)
    }
}
