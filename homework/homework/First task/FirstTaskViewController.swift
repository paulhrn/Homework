//
//  FirstTaskViewController.swift
//  homework
//
//  Created by p h on 01.06.2022.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    
    // MARK: - Private Properties
    private let label = "Yay! You're gorgeous!"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "First" {
            let destination = segue.destination as! Screen2
            destination.label = label
        }
    }
    
    // MARK: - Actions
    @IBAction func first(_ sender: UIButton) {
        performSegue(withIdentifier: "First", sender: self)
    }
    
}
