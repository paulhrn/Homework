//
//  ViewController.swift
//  Sidebar + Alerts 
//
//  Created by p h on 06.07.2022.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Private Properties
    private var menuIsHidden = true
    
    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var string: UILabel!
    @IBOutlet weak var menu: UIView!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leading.constant = -100
        trailing.constant = view.frame.width
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons = [button1, button2, button3]
        buttons.forEach{ $0?.addShadow(shadowColor: .darkGray, offset: .init(width: 10, height: 5), radius: 7) }
        buttons.forEach{ $0?.addCornerRadius() }
        buttons.forEach{ $0?.backgroundColor = .red }
        buttons.forEach{ $0?.addGradientPoints(colors: [#colorLiteral(red: 0.7411764706, green: 0.9019607843, blue: 0.9215686275, alpha: 1).cgColor, #colorLiteral(red: 0.6862745098, green: 0.9333333333, blue: 0.9333333333, alpha: 1).cgColor, #colorLiteral(red: 0.4392156863, green: 0.6784313725, blue: 0.6901960784, alpha: 1).cgColor]) }
        attrString()
    }
    
    //MARK: - Actions
    @IBAction func loginButton(_ sender: Any) {
        alertTextFields()
    }
    
    @IBAction func rateButton(_ sender: Any) {
        let action1 = UIAlertAction(title: "Like", style: .default)
        let action2 = UIAlertAction(title: "Dislike", style: .destructive)
        let action3 = UIAlertAction(title: "Back", style: .cancel)
        self.addAlert(title: "Rate it", message: "Do you like it?", actions: [action1, action2, action3])
    }
    
    @IBAction func backButton(_ sender: Any) {
        let views = [imageView, label]
        leading.constant = -view.frame.width
        trailing.constant = view.frame.width
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        }
        views.forEach{ $0?.removeBlur() }
        string.text = "R O S E S"
        attrString()
    }
    
    @IBAction func hamburgerTpd(_ sender: Any) {
        let views = [imageView, label]
        if menuIsHidden {
            leading.constant = 0    //initial
            trailing.constant = 205 //initial
            views.forEach{ $0?.addBlur(style: .light) }
            string.text = ""
            view.bringSubviewToFront(menu)
            menuIsHidden = false
        } else {
            leading.constant = -view.frame.width
            trailing.constant = view.frame.width
            menuIsHidden = true
            views.forEach{ $0?.removeBlur() }
            string.text = "R O S E S"
            attrString()
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Private Funcs
    private func attrString() {
        let mainString = "R O S E S"
        let attrString = NSMutableAttributedString(string: mainString)
        let range = (mainString as NSString).range(of: "O")
        attrString.addAttribute(.foregroundColor, value: UIColor.white, range: range)
        let range1 = (mainString as NSString).range(of: "E")
        attrString.addAttribute(.foregroundColor, value: UIColor.white, range: range1)
        
        string.attributedText = attrString
    }
    
    private func alertTextFields() {
        let alert = UIAlertController(title: "Login", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField1) in
            textField1.placeholder = "Email"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        
        let getValuesAction = UIAlertAction(title: "Continue", style: .default) { _ in
            if let emailText = alert.textFields?[0].text, let passwordText = alert.textFields?[1].text {
                print("Email: \(emailText)")
                print("Password: \(passwordText)")
            }
        }
        
        alert.addAction(getValuesAction)
        present(alert, animated: true)
    }
}
