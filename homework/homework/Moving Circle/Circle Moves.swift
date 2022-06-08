//
//  Circle Moves.swift
//  homework
//
//  Created by p h on 06.06.2022.
//

import Foundation
import UIKit

class CircleMoves: UIViewController {
    
    // MARK: - Private Properties
    private let movingCircle = UIView()
    private let left = UISwipeGestureRecognizer()
    private let right = UISwipeGestureRecognizer()
    private let up = UISwipeGestureRecognizer()
    private let down = UISwipeGestureRecognizer()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        movingCircle.frame = CGRect(x: view.frame.midX - 80 / 2, y: view.frame.midY - 80 / 2, width: 80, height: 80)
        movingCircle.layer.cornerRadius = movingCircle.frame.size.width / 2
        color()
        view.addSubview(movingCircle)
        
        up.addTarget(self, action: #selector (move(with:)))
        up.direction = .up
        view.addGestureRecognizer(up)
        
        down.addTarget(self, action: #selector (move(with:)))
        down.direction = .down
        view.addGestureRecognizer(down)
        
        right.addTarget(self, action: #selector (move(with:)))
        right.direction = .right
        view.addGestureRecognizer(right)
        
        left.addTarget(self, action: #selector (move(with:)))
        left.direction = .left
        view.addGestureRecognizer(left)
    }
    
    // MARK: - Private Funcs
    private func color() {
        movingCircle.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
    
    @objc private func move(with: UISwipeGestureRecognizer) {
        switch with.direction {
        case .up:
            if movingCircle.frame.maxY - movingCircle.frame.height >= 55 {
                movingCircle.center.y -= 20
            }
        case .down:
            if movingCircle.frame.maxY - movingCircle.frame.height <= 790 {
                movingCircle.center.y += 20
            }
        case .right:
            if movingCircle.frame.maxX - movingCircle.frame.height <= 320 {
                movingCircle.center.x += 20
            }
        case .left:
            if movingCircle.frame.maxX - movingCircle.frame.height >= 10 {
                movingCircle.center.x -= 20
            }
        default: break
        }
        color()
    }
}
