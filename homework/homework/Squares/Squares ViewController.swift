//
//  Squares ViewController.swift
//  homework
//
//  Created by p h on 10.06.2022.
//

import Foundation
import UIKit

class Squares: UIViewController {
    
    // MARK: - Private Properties
    private let panGesture = UIPanGestureRecognizer()
    private let tapGesture = UITapGestureRecognizer()
    private let space: CGFloat = 10
    private let heightWithSpace: CGFloat = 150
    
    // MARK: - Outlets
    @IBOutlet weak var greenSquare: UIView!
    @IBOutlet weak var pinkSquare: UIView!
    @IBOutlet weak var yellowSquare: UIView!
    @IBOutlet weak var tealSquare: UIView!
    @IBOutlet weak var Stack: UIStackView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pinkWidth: NSLayoutConstraint!
    
    @IBOutlet weak var tealWidth: NSLayoutConstraint!
    @IBOutlet weak var yellowWidth: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture.addTarget(self, action: #selector(pan))
        view.addGestureRecognizer(panGesture)
        
        tapGesture.addTarget(self, action: #selector(tap))
        tealSquare.addGestureRecognizer(tapGesture)
        
        view.bringSubviewToFront(Stack)
    }
    
    // MARK: - Actions
    @objc private func pan() {
        greenSquare.frame.origin = CGPoint(x: panGesture.location(in: view).x - heightConstraint.constant - 10, y: panGesture.location(in: view).y - heightConstraint.constant - 10)
        pinkSquare.frame.origin = CGPoint(x: panGesture.location(in: view).x + space, y: panGesture.location(in: view).y - pinkWidth.constant - 10)
        yellowSquare.frame.origin = CGPoint(x: panGesture.location(in: view).x - heightWithSpace, y: panGesture.location(in: view).y + space)
        tealSquare.frame.origin = CGPoint(x: panGesture.location(in: view).x + space, y: panGesture.location(in: view).y + space)
    }
    
    @objc private func tap() {
        heightConstraint.constant = 150
        pinkWidth.constant = 100
        yellowWidth.constant = 100
        tealWidth.constant = 150
    }
    
    @IBAction func toHideRelocate(_ sender: Any) {
        hideSquares(true)
    }
    
    @IBAction func initialPosition(_ sender: Any) {
        hideSquares(false)
        backToLocation()
    }
    
    //MARK: - Private Funcs
    private func hideSquares(_ bool: Bool) {
        let squares = [greenSquare, pinkSquare, yellowSquare, tealSquare]
        for square in squares {
            if bool == true {
                square?.isHidden = true
            }
            else {
                square?.isHidden = false
            }
        }
    }
    
    private func backToLocation() {
        greenSquare.frame.origin = greenSquare.frame.origin
        pinkSquare.frame.origin = pinkSquare.frame.origin
        yellowSquare.frame.origin = yellowSquare.frame.origin
        tealSquare.frame.origin = tealSquare.frame.origin
        heightConstraint.constant = 140
        pinkWidth.constant = 140
        yellowWidth.constant = 140
        tealWidth.constant = 140
    }
}

