//
//  RacesViewController.swift
//  homework
//
//  Created by p h on 01.06.2022.
//

import Foundation
import UIKit

class RacesVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var Play: UIButton!
    @IBOutlet weak var Scores: UIButton!
    @IBOutlet weak var Settings: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonsOutlets = [Play, Scores, Settings] as! [UIButton]
        buttonsOutlets.forEach{ $0.addCornerRadius() }
        buttonsOutlets.forEach{ $0.addGradient() }
        buttonsOutlets.forEach{ $0.setTitleColor(.red, for: .normal) }
        buttonsOutlets.forEach{ $0.addShadow() }
    }
    
    // MARK: - Actions
    @IBAction func PlayButton(_ sender: Any) {
        play()
    }
    
    @IBAction func ScoresButton(_ sender: Any) {
        scores()
    }
    
    @IBAction func SettingsButton(_ sender: Any) {
        settings()
    }
    
    // MARK: - Private Funcs
    private func play() {
        let storyboard = UIStoryboard(name: "Play", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PlayRacesV")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func scores() {
        let storyboard = UIStoryboard(name: "Scores", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ScoresRacesV")
        navigationController?.pushViewController(viewController, animated: true)    }
    
    private func settings() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsRacesV")
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - Extensions
extension UIView {
    func addShadow(shadowColor: UIColor = .red, offset: CGSize = .init(width: 5, height: 5), radius: CGFloat = 10, opacity: Float = 1) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func addGradient(type: CAGradientLayerType = .axial, colors: [CGColor] = [UIColor.red.cgColor, UIColor.purple.cgColor, UIColor.cyan.cgColor]) {
        let gradient = CAGradientLayer()
        gradient.type = type
        gradient.colors = colors
//        gradient.locations = locations
        gradient.startPoint = .init(x: 1, y: 0.9)
        gradient.endPoint = .init(x: 0, y: 0.2)
        gradient.frame = layer.bounds
        gradient.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradient, at: 1)
    }
    
    func addCornerRadius() {
        layer.cornerRadius = layer.frame.height / 2
    }
}
