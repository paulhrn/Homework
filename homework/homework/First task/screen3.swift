//
//  screen3.swift
//  homework
//
//  Created by p h on 02.06.2022.
//

import Foundation
import UIKit

class Screen3: UIViewController {
    
    // MARK: - Public Properties
    var label = ""
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Third" {
            let destination = segue.destination as! Screen4
            destination.label = label
        }
    }
    
    // MARK: - Actions
    @IBAction func third(_ sender: UIButton) {
        performSegue(withIdentifier: "Third", sender: self)
    }
}
