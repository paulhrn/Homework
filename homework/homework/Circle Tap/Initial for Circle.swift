//
//  Initial for Circle.swift
//  homework
//
//  Created by p h on 06.06.2022.
//

import Foundation
import UIKit

class CircleInitial: UIViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9149525249, blue: 0.9359124907, alpha: 1)
    }
    
    // MARK: - Actions
    @IBAction func Play(_ sender: UIButton) {
        nextVC()
    }
    
    // MARK: - Private Funcs
    private func nextVC() {
        let storyboard = UIStoryboard(name: "CircleWhenTap", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Circle1") as! Circle
        navigationController?.pushViewController(viewController, animated: true)
    }
}
