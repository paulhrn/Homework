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
    private var score: Int = 0
    private var brickTopConstraint: NSLayoutConstraint?
    private var brickCenterXConstraint: NSLayoutConstraint?
    private var brickBottomConstraint: NSLayoutConstraint?
    private var mainTimer: Timer?
    private var swipeOne = UISwipeGestureRecognizer()
    private var swipeTwo = UISwipeGestureRecognizer()
    var selectedSetting: enumSettings?
    
    // MARK: - Outlets
    @IBOutlet weak var road: UIView!
    @IBOutlet weak var roadWidth: NSLayoutConstraint!
    @IBOutlet weak var brick: UIImageView! {
        didSet { brickAnimation() }
    }
    @IBOutlet weak var car: UIImageView!
    @IBOutlet weak var carCenterX: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBrick()
        swipeOne.addTarget(self, action: #selector (swipeLeft))
        swipeOne.direction = .left
        view.addGestureRecognizer(swipeOne)
        swipeTwo.addTarget(self, action: #selector(swipeRight))
        //        swipeTwo.direction = .right
        view.addGestureRecognizer(swipeTwo)
        
        forCar()
        forObstacle()
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
            brickTopConstraint.isActive()
            brickCenterXConstraint.isActive()
            brickBottomConstraint.isInactive()
        }
    }
    
    private func brickAnimation() {
        forTimer()
        mainTimer = Timer.scheduledTimer(withTimeInterval: Settings.set.speed, repeats: true) { [weak self] _ in
            self?.animateConstraints()
            self?.score += 1
            UserDefaults.standard.set(self?.score, forKey: "Score")
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                guard let carFrame = self?.car.frame else { return }
                if self?.brick.layer.presentation()?.frame.intersects(carFrame) == true {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    private func animateConstraints() {
        sideToChoose = Bool.random()
        guard let brickTopConstraint = brickTopConstraint,
              let brickBottomConstraint = brickBottomConstraint else { return }
        brickTopConstraint.isInactive()
        brickBottomConstraint.isActive()
        UIView.animate(withDuration: Settings.set.speed, delay: 0, options: .repeat) {
            self.road.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let widthConstant = self?.roadWidth.constant else { return }
            if self?.sideToChoose == true {
                self?.brickCenterXConstraint?.constant = -widthConstant / 3.5
            } else {
                self?.brickCenterXConstraint?.constant = widthConstant / 3.5
            }
        }
    }
    
    private func forCar() {
        if UserDefaults.standard.value(forKey: "CarColor") as? String == enumSettings.yellow.rawValue {
            selectedSetting = .yellow
        } else if UserDefaults.standard.value(forKey: "CarColor") as? String == enumSettings.white.rawValue {
            selectedSetting = .white
        }
        switch selectedSetting {
        case .yellow:
            Settings.set.carColor = UIImage(named: "car")!
        case .white:
            Settings.set.carColor = UIImage(named: "white car")!
        default:
            break
        }
        car.image = Settings.set.carColor
    }
    
    private func forObstacle() {
        if UserDefaults.standard.value(forKey: "Obstacle") as? String == enumSettings.brick.rawValue {
            selectedSetting = .brick
        } else if UserDefaults.standard.value(forKey: "Obstacle") as? String == enumSettings.stone.rawValue {
            selectedSetting = .stone
        }
        switch  selectedSetting {
        case .brick:
            Settings.set.obstacle = UIImage(named: "brick")!
        case .stone:
            Settings.set.obstacle = UIImage(named: "stone")!
            brick.tintColor = .red
        default:
            break
        }
        brick.image = Settings.set.obstacle
    }
    
    private func forTimer() {
        if UserDefaults.standard.value(forKey: "Speed") as? String == enumSettings.three.rawValue {
            selectedSetting = .three
        } else if UserDefaults.standard.value(forKey: "Speed") as? String == enumSettings.twoFive.rawValue {
            selectedSetting = .twoFive
        }  else if UserDefaults.standard.value(forKey: "Speed") as? String == enumSettings.two.rawValue {
            selectedSetting = .two
        }
        switch selectedSetting {
        case .three:
            Settings.set.speed = 3.0
        case .twoFive:
            Settings.set.speed = 2.5
        case .two:
            Settings.set.speed = 2.0
        default:
            break
        }
    }
}
