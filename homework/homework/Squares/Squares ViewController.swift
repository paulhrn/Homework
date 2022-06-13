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
    private let panGestureGreen = UIPanGestureRecognizer()
    private let panGesturePink = UIPanGestureRecognizer()
    private let panGestureYellow = UIPanGestureRecognizer()
    private let panGestureTeal = UIPanGestureRecognizer()
    
    private let tapGestureGreen = UITapGestureRecognizer()
    private let tapGesturePink = UITapGestureRecognizer()
    private let tapGestureYellow = UITapGestureRecognizer()
    private let tapGestureTeal = UITapGestureRecognizer()
    
    private let swipeUpGreen = UISwipeGestureRecognizer()
    private let swipeUpPink = UISwipeGestureRecognizer()
    private let swipeUpYellow = UISwipeGestureRecognizer()
    private let swipeUpTeal = UISwipeGestureRecognizer()
    
    private let swipeDownGreen = UISwipeGestureRecognizer()
    private let swipeDownPink = UISwipeGestureRecognizer()
    private let swipeDownYellow = UISwipeGestureRecognizer()
    private let swipeDownTeal = UISwipeGestureRecognizer()
    
    // MARK: - Outlets
    @IBOutlet weak var greenSquare: UIView!
    @IBOutlet weak var pinkSquare: UIView!
    @IBOutlet weak var yellowSquare: UIView!
    @IBOutlet weak var tealSquare: UIView!
    @IBOutlet weak var Stack: UIStackView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintYellow: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintPink: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintGreen: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.bringSubviewToFront(Stack)
        
        // green square gestures
        panGestureGreen.addTarget(self, action: #selector(panGreen))
        greenSquare.addGestureRecognizer(panGestureGreen)
        tapGestureGreen.addTarget(self, action: #selector(tapGreen))
        greenSquare.addGestureRecognizer(tapGestureGreen)
        swipeUpGreen.addTarget(self, action: #selector (greenUp))
        swipeUpGreen.direction = .up
        greenSquare.addGestureRecognizer(swipeUpGreen)
        swipeDownGreen.addTarget(self, action: #selector (greenDown))
        swipeDownGreen.direction = .down
        greenSquare.addGestureRecognizer(swipeDownGreen)
        
        // pink square gestures
        panGesturePink.addTarget(self, action: #selector(panPink))
        pinkSquare.addGestureRecognizer(panGesturePink)
        tapGesturePink.addTarget(self, action: #selector(tapPink))
        pinkSquare.addGestureRecognizer(tapGesturePink)
        swipeUpPink.addTarget(self, action: #selector (pinkUp))
        swipeUpPink.direction = .up
        pinkSquare.addGestureRecognizer(swipeUpPink)
        swipeDownPink.addTarget(self, action: #selector (pinkDown))
        swipeDownPink.direction = .down
        pinkSquare.addGestureRecognizer(swipeDownPink)
        
        // yellow square gestures
        panGestureYellow.addTarget(self, action: #selector(panYellow))
        yellowSquare.addGestureRecognizer(panGestureYellow)
        tapGestureYellow.addTarget(self, action: #selector(tapYellow))
        yellowSquare.addGestureRecognizer(tapGestureYellow)
        swipeUpYellow.addTarget(self, action: #selector (yellowUp))
        swipeUpYellow.direction = .up
        yellowSquare.addGestureRecognizer(swipeUpYellow)
        
        // teal square gestures
        panGestureTeal.addTarget(self, action: #selector(panTeal))
        tealSquare.addGestureRecognizer(panGestureTeal)
        tapGestureTeal.addTarget(self, action: #selector(tapTeal))
        tealSquare.addGestureRecognizer(tapGestureTeal)
        swipeUpTeal.addTarget(self, action: #selector (tealUp))
        swipeUpTeal.direction = .up
        tealSquare.addGestureRecognizer(swipeUpTeal)
        swipeDownTeal.addTarget(self, action: #selector (tealDown))
        swipeDownTeal.direction = .down
        tealSquare.addGestureRecognizer(swipeDownTeal)
    }
    
    // MARK: - Actions
    // green square funcs
    @objc private func panGreen() {
        greenSquare.frame.origin = CGPoint(x: panGestureGreen.location(in: view).x - heightConstraintGreen.constant / 2, y: panGestureGreen.location(in: view).y - heightConstraintGreen.constant / 2)
        panGestureGreen.require(toFail: swipeUpGreen)
        panGestureGreen.require(toFail: swipeDownGreen)
    }
    @objc private func tapGreen() {
        greenSquare.isHidden = true
    }
    @objc private func greenUp() {
        heightConstraintGreen.constant = 140
    }
    @objc private func greenDown() {
        heightConstraintGreen.constant = 100
    }
    
    // pink square funcs
    @objc private func panPink() {
        pinkSquare.frame.origin = CGPoint(x: panGesturePink.location(in: view).x - heightConstraintPink.constant / 2, y: panGesturePink.location(in: view).y - heightConstraintPink.constant / 2)
        panGesturePink.require(toFail: swipeUpPink)
        panGesturePink.require(toFail: swipeDownPink)
    }
    @objc private func tapPink() {
        pinkSquare.isHidden = true
    }
    @objc private func pinkUp() {
        heightConstraintPink.constant = 140
    }
    @objc private func pinkDown() {
        heightConstraintPink.constant = 100
    }
    
    // yellow square funcs
    @objc private func panYellow() {
        yellowSquare.frame.origin = CGPoint(x: panGestureYellow.location(in: view).x - heightConstraintYellow.constant / 2, y: panGestureYellow.location(in: view).y - heightConstraintYellow.constant / 2)
        panGestureYellow.require(toFail: swipeUpYellow)
        panGestureYellow.require(toFail: swipeDownYellow)
    }
    @objc private func tapYellow() {
        yellowSquare.isHidden = true
    }
    @objc private func yellowUp() {
        heightConstraintYellow.constant = 140
    }
    @objc private func yellowDown() {
        heightConstraintYellow.constant = 100
    }
    
    // teal square funcs
    @objc private func panTeal() {
        tealSquare.frame.origin = CGPoint(x: panGestureTeal.location(in: view).x - heightConstraint.constant / 2, y: panGestureTeal.location(in: view).y - heightConstraint.constant / 2)
        panGestureTeal.require(toFail: swipeUpTeal)
        panGestureTeal.require(toFail: swipeDownTeal)
    }
    @objc private func tapTeal() {
        tealSquare.isHidden = true
    }
    @objc private func tealUp() {
        heightConstraint.constant = 140
    }
    @objc private func tealDown() {
        heightConstraint.constant = 100
    }
    
    @IBAction func initialPosition(_ sender: Any) {
        unhideSquares()
        backToLocation()
    }
    
    //MARK: - Private Funcs
    private func unhideSquares() {
        let squares = [greenSquare, pinkSquare, yellowSquare, tealSquare]
        for square in squares {
            square?.isHidden = false
        }
    }
    
    private func backToLocation() {
        greenSquare.frame.origin = greenSquare.frame.origin
        pinkSquare.frame.origin = pinkSquare.frame.origin
        yellowSquare.frame.origin = yellowSquare.frame.origin
        tealSquare.frame.origin = tealSquare.frame.origin
        heightConstraint.constant = 140
        heightConstraintGreen.constant = 140
        heightConstraintYellow.constant = 140
        heightConstraintPink.constant = 140
    }
}
