//
//  ViewController.swift
//  homework
//
//  Created by p h on 06.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let forCats = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forCats.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        forCats.frame = CGRect(x: 100, y: 100, width: 80, height: 80)
        forCats.layer.cornerRadius = 15
        forCats.layer.cornerRadius = forCats.frame.size.width / 2
        view.addSubview(forCats)
        forCats.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }
    
    @objc func didTap() {
        color()
        place()
    }
    func color() {
        
        forCats.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
    func place() {
        
        self.forCats.frame = CGRect(x: .random(in: 10...view.frame.maxX - forCats.frame.width), y: .random(in: 40...view.frame.maxY - forCats.frame.height), width: forCats.frame.width, height: forCats.frame.height)
    }
}
