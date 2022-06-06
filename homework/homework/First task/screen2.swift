//
//  screen2.swift
//  homework
//
//  Created by p h on 02.06.2022.
//

import Foundation
import UIKit

class Screen2: UIViewController {
    
    // MARK: - Public Properties
    var label = ""
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Second" {
            let destination = segue.destination as! Screen3
            destination.label = label
        }
    }
    
    // MARK: - Actions
    @IBAction func second(_ sender: UIButton) {
        performSegue(withIdentifier: "Second", sender: self)
    }
}
