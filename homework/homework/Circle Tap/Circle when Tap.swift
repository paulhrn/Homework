//
//  Circle when Tap.swift
//  homework
//
//  Created by p h on 06.06.2022.
//

import Foundation
import UIKit

class Circle: UIViewController {
    
    // MARK: - Private Properties
    private let forCats = UIView()
    private let tapScreen = UITapGestureRecognizer()
    private let tapView = UITapGestureRecognizer()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapScreen.addTarget(self, action: #selector(didTap))
        view.addGestureRecognizer(tapScreen)
        
        tapView.addTarget(self, action: #selector(didTap2))
        forCats.addGestureRecognizer(tapView)
    }
    
    // MARK: - Actions
    @objc private func didTap() {
        forCats.frame = CGRect(x: tapScreen.location(in: view).x - forCats.frame.height / 2, y: tapScreen.location(in: view).y - forCats.frame.width / 2, width: 80, height: 80)
        forCats.layer.cornerRadius = forCats.frame.width / 2
        forCats.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        forCats.isHidden = false
        view.addSubview(forCats)
    }
    
    @objc private func didTap2() {
        forCats.isHidden = true
    }
}
