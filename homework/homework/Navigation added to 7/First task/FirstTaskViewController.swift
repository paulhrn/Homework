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
    
    // MARK: - Actions
    @IBAction func first(_ sender: UIButton) {
        nextVC()
    }
    
    // MARK: - Private Functions
    private func nextVC() {
        let storyboard = UIStoryboard(name: "FirstTaskStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Screen22") as! Screen2
        viewController.label = label
        navigationController?.pushViewController(viewController, animated: true)
    }
}
