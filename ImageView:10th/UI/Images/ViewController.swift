//
//  ViewController.swift
//  UI copy
//
//  Created by p h on 18.05.22.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(changeImages), userInfo: nil, repeats: true)
        deo()
    }
    
    // MARK: - Actions
    @objc private func changeImages() {
        let images = [image1, image2, image3, image4, image5]
        imageView.image = images.randomElement() as? UIImage
    }
    
    // MARK: - Private Functions
    private func setupUI() {
        view.addSubview(imageView)
        
        imageViewTopAnchor = imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        imageViewLeadingAnchor = imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 700)
        imageViewTrailingAnchor = imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 700)
        imageViewBottomAnchor = imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        
        imageViewTopAnchor?.isActive = true
        imageViewLeadingAnchor?.isActive = true
        imageViewTrailingAnchor?.isActive = true
        imageViewBottomAnchor?.isActive = true
        
    }
    
    private func deo() {
        imageViewLeadingAnchor?.isActive = false
        imageViewTrailingAnchor?.isActive = false
        UIView.animate(withDuration: 3.5, delay: 0, options: [.repeat, .autoreverse], animations: { [weak self] in
            self?.imageView.transform = CGAffineTransform(translationX: -(self?.imageView.frame.width)! + (self?.view.bounds.width)!, y: 0)
        }, completion: { _ in
            self.imageViewLeadingAnchor?.constant = 10
            self.imageViewTrailingAnchor?.constant = -10
            self.imageViewLeadingAnchor?.isActive = true
            self.imageViewTrailingAnchor?.isActive = true
        })
    }
}
