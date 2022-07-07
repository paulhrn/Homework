//
//  Extensions.swift
//  Sidebar + Alerts
//
//  Created by p h on 07.07.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func addAlert(title: String, message: String, preferredStyle: UIAlertController.Style = .alert, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}

extension UIView {
    func addBlur(style: UIBlurEffect.Style) {
        var blurEffectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: style)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        addSubview(blurEffectView)
    }
    
    func removeBlur() {
        for view in self.subviews {
            if let view = view as? UIVisualEffectView {
                view.removeFromSuperview()
            }
        }
    }
    
    func addShadow(shadowColor: UIColor = .red, offset: CGSize = .init(width: 5, height: 5), radius: CGFloat = 10, opacity: Float = 1) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func addCornerRadius() {
        layer.cornerRadius = layer.frame.height / 2
    }
    
    func addGradientPoints(type: CAGradientLayerType = .axial, colors: [CGColor] = [UIColor.red.cgColor, UIColor.purple.cgColor, UIColor.cyan.cgColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1)) {
        let gradient = CAGradientLayer()
        gradient.type = type
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = layer.bounds
        gradient.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradient, at: 1)
    }
}

