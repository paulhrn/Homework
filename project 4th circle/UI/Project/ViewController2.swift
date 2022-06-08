//
//  ViewController2.swift
//  UI
//
//  Created by p h on 06.06.2022.
//

import Foundation
import UIKit

class Circle: UIViewController {
    
    // MARK: - Private Properties
    private let circle = UIView()
    private let tap = UIPanGestureRecognizer()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tap.addTarget(self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
        
        circle.frame = CGRect(x: view.frame.midX, y: view.frame.midY, width: 80, height: 80)
        circle.layer.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        view.addSubview(circle)
    }
    
    // MARK: - Actions
    @objc private func didTap() {
        circle.frame.origin = CGPoint(x: tap.location(in: view).x - circle.frame.height / 2, y: tap.location(in: view).y - circle.frame.width / 2)
        circle.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
}
