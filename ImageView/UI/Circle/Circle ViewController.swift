//
//  Circle ViewController.swift
//  UI
//
//  Created by p h on 15.06.2022.
//

import Foundation
import UIKit

class Circle: UIViewController {
    
    // MARK: - Private Properties
    private var circle: UIView = {
        let circle = UIView()
        circle.backgroundColor = .red
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()
    private var circleTopAnchor: NSLayoutConstraint?
    private var circleLeadingAnchor: NSLayoutConstraint?
    private var circleTrailingAnchor: NSLayoutConstraint?
    private var circleBottomAnchor: NSLayoutConstraint?
    private var circleWidth: NSLayoutConstraint?
    private var circleHeight: NSLayoutConstraint?
    
    private var isTop = true
    private var isLeading = true
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCircle()
        createHorizontalTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        circle.layer.cornerRadius = circle.frame.height / 2
    }
    
    // MARK: - Private Funcs
    private func setupCircle() {
        view.addSubview(circle)
        
        circleTopAnchor = circle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5)
        circleLeadingAnchor = circle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5)
        circleTrailingAnchor = circle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        circleBottomAnchor = circle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        circleWidth = circle.widthAnchor.constraint(equalToConstant: 30)
        circleHeight = circle.heightAnchor.constraint(equalToConstant: 30)
        
        circleTopAnchor?.isActive = true
        circleLeadingAnchor?.isActive = true
        circleWidth?.isActive = true
        circleHeight?.isActive = true
    }
    
    private func createVerticalTimer() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] timer in
            if self!.isTop {
                self?.animateBottom()
            } else {
                self?.animateTop()
            }
        }
    }
    
    private func createHorizontalTimer() {
        Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true) { [weak self] timer in
            if self!.isLeading {
                self?.animateTrailing()
                self?.createVerticalTimer()
            } else {
                self?.animateLeading()
            }
        }
    }
    
    private func animateTop() {
        circleTopAnchor?.isActive = true
        circleBottomAnchor?.isActive = false
        UIView.animate(withDuration: 3.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.isTop = true
        }
    }
    
    private func animateLeading() {
        circleLeadingAnchor?.isActive = true
        circleTrailingAnchor?.isActive = false
        UIView.animate(withDuration: 3.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.isLeading = true
        }
    }
    
    private func animateTrailing() {
        circleLeadingAnchor?.isActive = false
        circleTrailingAnchor?.isActive = true
        UIView.animate(withDuration: 3.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.isLeading = false
        }
    }
    
    private func animateBottom() {
        circleTopAnchor?.isActive = false
        circleBottomAnchor?.isActive = true
        UIView.animate(withDuration: 3.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.isTop = false
        }
    }
}
