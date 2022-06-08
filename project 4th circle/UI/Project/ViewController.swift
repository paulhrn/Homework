//
//  ViewController.swift
//  UI copy
//
//  Created by p h on 18.05.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9149525249, blue: 0.9359124907, alpha: 1)
    }
    
    // MARK: - Actions
    @IBAction func play(_ sender: UIButton) {
        nextVC()
    }
    
    // MARK: - Private Funcs
    private func nextVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Circle1") as! Circle
        navigationController?.pushViewController(viewController, animated: true)
    }
}
