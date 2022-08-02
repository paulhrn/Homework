//
//  ViewController.swift
//  Photo storage
//
//  Created by p h on 14.07.2022.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    private let tap = UITapGestureRecognizer()
    @IBOutlet weak var viewForXib: ContentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tap.addTarget(self, action: #selector(didTap))
        viewForXib.label.addGestureRecognizer(tap)
    }
    
    @objc private func didTap() {
        let alert = UIAlertController(title: "Enter password:", message: "qq", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Password"
        }
        let action1 = UIAlertAction(title: "Submit", style: .default) { _ in
            if let passwordText = alert.textFields?[0].text {
                if passwordText == "qq" {
                    self.performSegue(withIdentifier: "First", sender: self)
                } else {
                    self.alertIfIncorrectPassword()
                }
            }
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
    }
    
    private func alertIfIncorrectPassword() {
        let alert = UIAlertController(title: "Get away!", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "You  👉🏽  😔", style: .destructive)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

