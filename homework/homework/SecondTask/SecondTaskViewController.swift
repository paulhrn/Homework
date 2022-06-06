//
//  SecondTaskViewController.swift
//  homework
//
//  Created by p h on 01.06.2022.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Actions
    @IBAction func showLabels(_ sender: UIButton) {
        passData()
    }
    
    // MARK: - Private Funcs
    private func passData() {
        let storyboard = UIStoryboard(name: "SecondTaskStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SecondView3") as! SecondV
        viewController.variables = forLabels(name: "You", action: "win", money: "1,000$")
        present(viewController, animated: true)
    }
}

