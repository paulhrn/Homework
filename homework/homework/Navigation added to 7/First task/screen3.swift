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
    
    // MARK: - Actions
    @IBAction func third(_ sender: UIButton) {
        nextVC()
    }
    
    // MARK: - Private Functions
    private func nextVC() {
        let storyboard = UIStoryboard(name: "FirstTaskStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Screen44") as! Screen4
        viewController.label = label
        navigationController?.pushViewController(viewController, animated: true)
    }
}
