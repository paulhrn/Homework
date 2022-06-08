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
    
    // MARK: - Actions
    @IBAction func second(_ sender: UIButton) {
        nextVC()
    }
    
    // MARK: - Private Functions
    private func nextVC() {
        let storyboard = UIStoryboard(name: "FirstTaskStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Screen33") as! Screen3
        viewController.label = label
        navigationController?.pushViewController(viewController, animated: true)
    }
}