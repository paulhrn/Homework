//
//  thirdVC.swift
//  homework
//
//  Created by p h on 25.05.2022.

import UIKit

class thirdVC: UIViewController {
    
    // MARK: - Private Properties
    private let movingCircle = UIView()
    
    private enum Moves {
        case up
        case down
        case right
        case left
    }
    
    // MARK: - Outlets
    @IBOutlet weak var mainLabel: UILabel!
    
    // MARK: - Life Cycle
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
    
    // MARK: - Actions
    @IBAction func buttonUp(_ sender: Any) {
        move(direction: .up)
    }
    @IBAction func buttonDown(_ sender: Any) {
        move(direction: .down)
    }
    @IBAction func buttonLeft(_ sender: Any) {
        move(direction: .left)
        
    }
    @IBAction func buttonRight(_ sender: Any) {
        move(direction: .right)
        
    }
    // MARK: - Private Funcs
    private func move(direction: Moves) {
        switch direction {
        case Moves.up: if movingCircle.frame.maxY - movingCircle.frame.height >= 40 {
            movingCircle.center.y -= 10
            mainLabel.text = "Going up"
        }
            else {
                mainLabel.text = "Error"
                mainLabel.textColor = .red
                mainLabel.font = mainLabel.font.withSize(30)
            }
        case Moves.down:  if movingCircle.frame.maxY - movingCircle.frame.height <= 580 {
            movingCircle.center.y += 10
            mainLabel.text = "Going down"
        }
            else {
                mainLabel.text = "Error"
                mainLabel.textColor = .red
                mainLabel.font = mainLabel.font.withSize(30)
            }
        case Moves.right:   if movingCircle.frame.maxX - movingCircle.frame.height <= 320 {
            movingCircle.center.x += 10
            mainLabel.text = "Going right"
        }
            else {
                mainLabel.text = "Error"
                mainLabel.textColor = .red
                mainLabel.font = mainLabel.font.withSize(30)
            }
        case Moves.left:  if movingCircle.frame.maxX - movingCircle.frame.height >= 10 {
            movingCircle.center.x -= 10
            mainLabel.text = "Going left"
        }
            else {
                mainLabel.text = "Error"
                mainLabel.textColor = .red
                mainLabel.font = mainLabel.font.withSize(30)
            }
        }
    }
}
