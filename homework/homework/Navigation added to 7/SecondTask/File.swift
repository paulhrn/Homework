//
//  File.swift
//  homework
//
//  Created by p h on 02.06.2022.
//

import Foundation
import UIKit

class SecondV: UIViewController {
    
    // MARK: - Public Properties
    var variables = forLabels(name: "", action: "", money: "")
    
    // MARK: - Outlets
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelOne.text = variables.name
        labelTwo.text = variables.action
        labelThree.text = variables.money
    }
}
