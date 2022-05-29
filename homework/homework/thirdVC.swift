//
//  thirdVC.swift
//  homework
//
//  Created by p h on 25.05.2022.

import UIKit

class thirdVC: UIViewController {
    
    let movingCircle = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8916817563, green: 0.9905012619, blue: 1, alpha: 1)
        movingCircle.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        movingCircle.frame = CGRect(x: view.frame.midX - 80 / 2, y: view.frame.midY - 80 / 2, width: 80, height: 80)
        movingCircle.layer.cornerRadius = movingCircle.frame.size.width / 2
        view.addSubview(movingCircle)
    }
    
    @IBAction func buttonUp(_ sender: Any) {
        if movingCircle.frame.maxY - movingCircle.frame.height >= 40 {
            movingCircle.center.y -= 10 }
    }
    @IBAction func buttonDown(_ sender: Any) {
        if movingCircle.frame.maxY - movingCircle.frame.height <= 580 {
            movingCircle.center.y += 10 }
    }
    @IBAction func buttonLeft(_ sender: Any) {
        if movingCircle.frame.maxX - movingCircle.frame.height >= 10 {
            movingCircle.center.x -= 10
        }
    }
    @IBAction func buttonRight(_ sender: Any) {
        if movingCircle.frame.maxX - movingCircle.frame.height <= 320 {
            movingCircle.center.x += 10
            
        }
    }
}

