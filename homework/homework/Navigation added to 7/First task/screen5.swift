//
//  screen5.swift
//  homework
//
//  Created by p h on 02.06.2022.
//

import Foundation
import UIKit

class Screen5: UIViewController {
    
    // MARK: - Public Properties
    var label = ""
    
    // MARK: - Outlets
    @IBOutlet weak var fifth: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fifth.text = label
    }
    
    
    // MARK: - Actions
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

