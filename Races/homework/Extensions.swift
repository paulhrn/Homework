//
//  Extensions.swift
//  homework
//
//  Created by p h on 01.07.2022.
//

import Foundation
import UIKit

extension UIView {
    func addShadow(shadowColor: UIColor = .red, offset: CGSize = .init(width: 5, height: 5), radius: CGFloat = 10, opacity: Float = 1) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func addGradientPoints(type: CAGradientLayerType = .axial, colors: [CGColor] = [UIColor.red.cgColor, UIColor.purple.cgColor, UIColor.cyan.cgColor], startPoint: CGPoint = CGPoint(x: 1, y: 0.9), endPoint: CGPoint = CGPoint(x: 0, y: 0.2)) {
        let gradient = CAGradientLayer()
        gradient.type = type
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = layer.bounds
        gradient.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradient, at: 1)
    }
    
    func addGradientLocation(type: CAGradientLayerType = .axial, colors: [CGColor] = [UIColor.red.cgColor, UIColor.purple.cgColor, UIColor.cyan.cgColor], locations: [NSNumber] = [0, 0.25, 1]) {
        let gradient = CAGradientLayer()
        gradient.type = type
        gradient.colors = colors
        gradient.locations = locations
        gradient.frame = layer.bounds
        layer.insertSublayer(gradient, at: 1)
    }
    
    func addCornerRadius() {
        layer.cornerRadius = layer.frame.height / 2
    }
    
    func attrStringUnderline() {
        let mainString = (self as? UIButton)?.titleLabel?.text
        guard let mainString = mainString else { return }
        let attrString = NSMutableAttributedString(string: mainString)
        let range = (mainString as NSString).range(of: mainString)
        attrString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range)
        (self as? UIButton)?.titleLabel?.attributedText = attrString
    }
    
    func addFont(font: UIFont) {
        (self as? UILabel)?.font = font
    }
}

extension NSLayoutConstraint {
    func isActive() {
        self.isActive = true
    }
    
    func isInactive() {
        self.isActive = false
    }
}

extension UIViewController {
    func addAlert(title: String, message: String, preferredStyle: UIAlertController.Style, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}
