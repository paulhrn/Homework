//
//  SettingsRaces.swift
//  homework
//
//  Created by p h on 01.06.2022.
//

import Foundation
import UIKit

// MARK: - Singleton
class Settings {
    static let set = Settings(carColor: UIImage(named: "car")!, obstacle: UIImage(named: "brick")!, speed: 2.5)
    
    var carColor: UIImage
    var obstacle: UIImage
    var speed: Double
    
    private init(carColor: UIImage, obstacle: UIImage, speed: Double) {
        self.carColor = carColor
        self.obstacle = obstacle
        self.speed = speed
    }
}

// MARK: - VC class
class SettingsRacesVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var carColor: UIButton!
    @IBOutlet weak var obstacle: UIButton!
    @IBOutlet weak var speed: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let outlets = [carColor, obstacle, speed] as? [UIButton] else { return }
        outlets.forEach{ $0.addCornerRadius() }
    }
    
    // MARK: - Actions
    @IBAction func carColorAction(_ sender: Any) {
        let action1 = UIAlertAction(title: "White", style: .default) { action in
            self.forSave(value: enumSettings.white.rawValue, key: "CarColor")
        }
        let action2 = UIAlertAction(title: "Default", style: .default) { action in
            self.forSave(value: enumSettings.yellow.rawValue, key: "CarColor")
        }
        let action3 = UIAlertAction(title: "Back", style: .cancel)
        self.addAlert(title: "", message: "Choose color:", preferredStyle: .actionSheet, actions: [action1, action2, action3])
    }
    
    @IBAction func obstacleAction(_ sender: Any) {
        
        let action1 = UIAlertAction(title: "Heart", style: .default) { action in
            self.forSave(value: enumSettings.stone.rawValue, key: "Obstacle")
        }
        let action2 = UIAlertAction(title: "Default", style: .default) { action in
            self.forSave(value: enumSettings.brick.rawValue, key: "Obstacle")
        }
        let action3 = UIAlertAction(title: "Back", style: .cancel)
        self.addAlert(title: "", message: "Choose obstacle:", preferredStyle: .actionSheet, actions: [action1, action2, action3])
    }
    
    @IBAction func speedAction(_ sender: Any) {
        let action1 = UIAlertAction(title: "Faster", style: .default) { action in
            self.forSave(value: enumSettings.two.rawValue, key: "Speed")
        }
        let action2 = UIAlertAction(title: "Slower", style: .default) { action in
            self.forSave(value: enumSettings.three.rawValue, key: "Speed")
        }
        let action3 = UIAlertAction(title: "Default", style: .default) { action in
            self.forSave(value: enumSettings.twoFive.rawValue, key: "Speed")
        }
        let action4 = UIAlertAction(title: "Back", style: .cancel)
        self.addAlert(title: "", message: "Choose speed:", preferredStyle: .actionSheet, actions: [action1, action2, action3, action4])
    }
    
    // MARK: - Private Funcs
    private func forSave(value: String, key: String) {
        let alert = UIAlertController(title: "Do you want to save changes?", message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Yes", style: .default) { action in
            UserDefaults.standard.set(value, forKey: key)
        }
        let action2 = UIAlertAction(title: "No", style: .default)
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
    }
}
