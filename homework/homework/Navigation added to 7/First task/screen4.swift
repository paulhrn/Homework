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
    
    // MARK: - Actions
    @IBAction func fourth(_ sender: UIButton) {
        nextVC()
    }
    
    // MARK: - Private Functions
    private func nextVC() {
        let storyboard = UIStoryboard(name: "FirstTaskStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LabelText5") as! Screen5
        viewController.label = label
        navigationController?.pushViewController(viewController, animated: true)
    }
}
