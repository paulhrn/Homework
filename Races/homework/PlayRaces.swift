//
//  PlayRaces.swift
//  homework
//
//  Created by p h on 01.06.2022.
//

import Foundation
import UIKit

class PlayRacesVC: UIViewController {
    
    // MARK: - Private Properties
    private var sideToChoose: Bool = true
    private var brickTopConstraint: NSLayoutConstraint?
    private var brickCenterXConstraint: NSLayoutConstraint?
    private var brickBottomConstraint: NSLayoutConstraint?
    private var mainTimer: Timer?
    private var swipeOne = UISwipeGestureRecognizer()
    private var swipeTwo = UISwipeGestureRecognizer()
    
    // MARK: - Outlets
    @IBOutlet weak var road: UIView!
    @IBOutlet weak var roadWidth: NSLayoutConstraint!
    @IBOutlet weak var brick: UIImageView!
    @IBOutlet weak var car: UIImageView!
    @IBOutlet weak var carCenterX: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBrick()
        brickAnimation()
        
        swipeOne.addTarget(self, action: #selector(swipeLeft))
        swipeOne.direction = .left
        view.addGestureRecognizer(swipeOne)
        swipeTwo.addTarget(self, action: #selector(swipeRight))
        swipeTwo.direction = .right
        view.addGestureRecognizer(swipeTwo)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let mainTimer = mainTimer else { return }
        mainTimer.invalidate()
    }
    
    //MARK: - Actions
    @objc private func swipeLeft() {
        guard let carCenterX = carCenterX else { return }
        carCenterX.constant -= 25
        if carCenterX.constant <= -roadWidth.constant / 3 {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc private func swipeRight() {
        guard let carCenterX = carCenterX else { return }
        carCenterX.constant += 25
        if carCenterX.constant >= roadWidth.constant / 3 {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - Private Funcs
    private func setBrick() {
        brickTopConstraint = brick.topAnchor.constraint(equalTo: road.topAnchor, constant: -50)
        brickCenterXConstraint = brick.centerXAnchor.constraint(equalTo: road.centerXAnchor, constant: -roadWidth.constant / 3.5)
        brickBottomConstraint = brick.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100)
        
        if let brickTopConstraint = brickTopConstraint,
           let brickCenterXConstraint = brickCenterXConstraint,
           let brickBottomConstraint = brickBottomConstraint {
            brickTopConstraint.isActive = true
            brickCenterXConstraint.isActive = true
            brickBottomConstraint.isActive = false
        }
    }
    
    private func brickAnimation() {
        mainTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { [self] (timer1) in
            animateConstraints()
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] (timer2) in
                if brick.layer.presentation()?.frame.intersects(car.frame) == true {
                    navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    private func animateConstraints() {
        sideToChoose = Bool.random()
        guard let brickTopConstraint = brickTopConstraint,
              let brickBottomConstraint = brickBottomConstraint else { return }
        brickTopConstraint.isActive = false
        brickBottomConstraint.isActive = true
        UIView.animate(withDuration: 2.5, delay: 0, options: .repeat) {
            self.road.layoutIfNeeded()
        } completion: { [self] _ in
            if sideToChoose == true {
                brickCenterXConstraint?.constant = -roadWidth.constant / 3.5
            } else {
                brickCenterXConstraint?.constant = roadWidth.constant / 3.5
            }
        }
    }
}
