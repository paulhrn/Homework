//
//  secondVC.swift
//  homework
//
//  Created by p h on 25.05.2022.


import UIKit

class secondVC: UIViewController {
    
    var square = UIView()
    let points = 15
    
    @IBOutlet weak var buttonLook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.8916817563, green: 0.9905012619, blue: 1, alpha: 1)
        
    }
    
    @IBAction func buttonDo(_ sender: UIButton) {
        for everyX in 0...Int(view.frame.maxX / CGFloat(points)) {
            
            for everyY in 0...Int(view.frame.maxY / CGFloat(points)) {
                
                let square = UIView()
                square.frame = CGRect(x: everyX * points, y: everyY * points, width: points, height: points)
                square.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
                
                view.addSubview(square)
            }
        }
        view.bringSubviewToFront(buttonLook)
    }
}
