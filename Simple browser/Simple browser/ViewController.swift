//
//  ViewController.swift
//  Simple browser
//
//  Created by p h on 21.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    static var search: String = ""
    private let notificationCenter = NotificationCenter.default
    
    // MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        attrText()
        keyboardAnimation()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    // MARK: - Funcs
    @objc private func didTapView() {
        view.endEditing(true)
    }
    
    private func setTextField() {
        guard let textField = textField else { return }
        textField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        textField.backgroundColor = .white
        textField.delegate = self
        view.bringSubviewToFront(textField)
    }
    
    private func attrText() {
        let text = "Search in Google"
        let attrString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "Google")
        attrString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range)
        attrString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range)
        if let label = label {
            label.attributedText = attrString
        }
    }
    
    private func keyboardAnimation() {
        let showNotifiction = UIResponder.keyboardWillShowNotification
        notificationCenter.addObserver(forName: showNotifiction, object: nil, queue: .main) { notification in
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.bottomConstraint?.constant = keyboardSize.height + 60
                UIView.animate(withDuration: 5.0) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        
        let hideNotification = UIResponder.keyboardWillHideNotification
        notificationCenter.addObserver(forName: hideNotification, object: nil, queue: .main) { _ in
            self.bottomConstraint?.constant = 0
            UIView.animate(withDuration: 5.0) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - Extensions
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: "Google", sender: self)
        ViewController.search = textField.text ?? ""
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
