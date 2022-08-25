//
//  ViewController.swift
//  Photo storage
//
//  Created by p h on 14.07.2022.
//

import Foundation
import UIKit
import SwiftyKeychainKit

class ViewController: UIViewController {
    
    private let keychain = Keychain(service: "com.tms.pix")
    private let accessTokenKey = KeychainKey<String>(key: "accessToken")
    @IBOutlet weak var viewForXib: ContentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewForXib.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        setPassword()
    }
    
    @IBAction func changePasswordButton(_ sender: Any) {
        forPasswordChange()
    }
    
    @objc private func didTap() {
        let alert = UIAlertController(title: "Enter password:", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Your password"
            textField.isSecureTextEntry = true
        }
        let actionSubmit = UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            if let passwordText = alert.textFields?[0].text, let accessTokenKey = self?.accessTokenKey {
                if let token = try? self?.keychain.get(accessTokenKey) {
                    if passwordText == token {
                        self?.performSegue(withIdentifier: "First", sender: self)
                    } else {
                        self?.alert()
                    }
                }
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(actionSubmit)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
    
    private func setPassword() {
        if let token = try? keychain.get(accessTokenKey) {
            if token.isEmpty {
                let alert = UIAlertController(title: "Hi, user!", message: "Set password to use the app", preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.placeholder = "Your password"
                }
                let action = UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
                    if let passwordText = alert.textFields?[0].text, let accessTokenKey = self?.accessTokenKey {
                        try? self?.keychain.set(passwordText, for: accessTokenKey)
                    }
                }
                alert.addAction(action)
                present(alert, animated: true)
            }
        }
    }
    
    private func forPasswordChange() {
        let alert = UIAlertController(title: "Password change", message: "Enter you current and new passwords", preferredStyle: .alert)
        alert.addTextField { textfield in
            textfield.placeholder = "Current password"
        }
        alert.addTextField { textfield in
            textfield.placeholder = "New password"
        }
        let actionSubmit = UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            if let oldPasswordText = alert.textFields?[0].text, let newPasswordText = alert.textFields?[1].text, let accessTokenKey = self?.accessTokenKey {
                if let token = try? self?.keychain.get(accessTokenKey) {
                    if oldPasswordText == token {
                    try? self?.keychain.set(newPasswordText, for: accessTokenKey)
                        self?.alert(alertTitle: "Password is changed!", alertMessage: "", actionTitle: "OK", style: .cancel)
                    } else {
                        self?.alert(alertTitle: "Old password is incorrect", alertMessage: "Try again if it's your phone", actionTitle: "OK", style: .cancel)
                    }
                }
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(actionSubmit)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
    
    private func alert(alertTitle: String = "Get away!", alertMessage: String = "", actionTitle: String = "You  👉🏽  😔", style: UIAlertAction.Style = .destructive) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: style)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

