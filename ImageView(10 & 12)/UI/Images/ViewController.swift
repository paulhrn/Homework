//
//  ViewController.swift
//  UI copy
//
//  Created by p h on 18.05.22.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    private let image1 = UIImage(named: "first")
    private let image2 = UIImage(named: "second")
    private let image3 = UIImage(named: "third")
    private let image4 = UIImage(named: "fourth")
    private let image5 = UIImage(named: "fifth")
    private var imageViewTopAnchor: NSLayoutConstraint?
    private var imageViewLeadingAnchor: NSLayoutConstraint?
    private var imageViewTrailingAnchor: NSLayoutConstraint?
    private var imageViewBottomAnchor: NSLayoutConstraint?
    private let leftGesture = UISwipeGestureRecognizer()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addGradient(colors: [#colorLiteral(red: 0.7411764706, green: 0.9019607843, blue: 0.9215686275, alpha: 1).cgColor, #colorLiteral(red: 0.6862745098, green: 0.9333333333, blue: 0.9333333333, alpha: 1).cgColor, #colorLiteral(red: 0.4392156863, green: 0.6784313725, blue: 0.6901960784, alpha: 1).cgColor], locations: [0, 0.5, 1])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
        leftGesture.addTarget(self, action: #selector(swipeLeft))
        leftGesture.direction = .left
        view.addGestureRecognizer(leftGesture)
    }
    
    // MARK: - Actions
    @objc private func swipeLeft() {
        let images = [image1, image2, image3, image4, image5]
        imageView.image = images.randomElement() as? UIImage
        imageView.addShadow(shadowColor: .darkGray, offset: .init(width: 10, height: 10), radius: 20, opacity: 1)
        
        imageViewLeadingAnchor?.isActive = false
        imageViewTrailingAnchor?.isActive = false
        UIView.animate(withDuration: 4.5) {
            self.imageViewLeadingAnchor?.constant = 10
            self.imageViewTrailingAnchor?.constant = -10
            self.imageViewLeadingAnchor?.isActive = true
            self.imageViewTrailingAnchor?.isActive = true
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.imageViewLeadingAnchor?.isActive = false
            self.imageViewTrailingAnchor?.isActive = false
            UIView.animate(withDuration: 4.5) {
                self.imageViewLeadingAnchor?.constant = 600
                self.imageViewTrailingAnchor?.constant = 600
                self.imageViewLeadingAnchor?.isActive = true
                self.imageViewTrailingAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Private Functions
    private func setupUI() {
        view.addSubview(imageView)
        
        imageViewTopAnchor = imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        imageViewLeadingAnchor = imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 600)
        imageViewTrailingAnchor = imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 600)
        imageViewBottomAnchor = imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        
        imageViewTopAnchor?.isActive = true
        imageViewLeadingAnchor?.isActive = true
        imageViewTrailingAnchor?.isActive = true
        imageViewBottomAnchor?.isActive = true
    }
}

// MARK: - Extensions
extension UIView {
    func addShadow(shadowColor: UIColor = .red, offset: CGSize = .init(width: 4, height: 4), radius: CGFloat = 4, opacity: Float = 0.75) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func addGradient(type: CAGradientLayerType = .axial, colors: [CGColor] = [UIColor.red.cgColor, UIColor.purple.cgColor, UIColor.cyan.cgColor], locations: [NSNumber] = [0, 0.25, 1]) {
        let gradient = CAGradientLayer()
        gradient.type = type
        gradient.colors = colors
        gradient.locations = locations
        gradient.frame = layer.bounds
        layer.insertSublayer(gradient, at: 1)
    }
}
